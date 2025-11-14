import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const db = admin.firestore();

/**
 * Search users by username or user code
 */
export const searchUsers = functions.https.onCall(async (data, context) => {
  // Verify user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated to search users.'
    );
  }

  const { query } = data;
  const currentUserId = context.auth.uid;

  if (!query || query.trim().length < 2) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Search query must be at least 2 characters long.'
    );
  }

  try {
    const searchQuery = query.trim().toLowerCase();
    const results: any[] = [];

    // Search by user code first
    const userCodeSnapshot = await db
      .collection('userCodes')
      .where('userCode', '==', searchQuery.toUpperCase())
      .where('isActive', '==', true)
      .get();

    if (!userCodeSnapshot.empty) {
      const userCodeDoc = userCodeSnapshot.docs[0];
      const userCodeData = userCodeDoc.data();

      // Get full user profile
      const userProfile = await db
        .collection('users')
        .doc(userCodeData.userId)
        .get();

      if (userProfile.exists) {
        results.push({
          uid: userCodeData.userId,
          username: userCodeData.username,
          userCode: userCodeData.userCode,
          ...userProfile.data(),
        });
      }
    }

    // Search by username if no exact user code match
    if (results.length === 0) {
      const usernameSnapshot = await db
        .collection('users')
        .where('username_lowercase', '>=', searchQuery)
        .where('username_lowercase', '<=', searchQuery + '\uf8ff')
        .where('accountStatus', '==', 'active')
        .limit(20)
        .get();

      for (const doc of usernameSnapshot.docs) {
        if (doc.id !== currentUserId) {
          results.push({
            uid: doc.id,
            ...doc.data(),
          });
        }
      }
    }

    // Check friendship status for each result
    const friendsRef = db.collection('friends').doc(currentUserId).collection('connections');

    for (const result of results) {
      const friendDoc = await friendsRef.doc(result.uid).get();

      if (friendDoc.exists) {
        const friendData = friendDoc.data();
        result.isFriend = friendData?.status === 'accepted';
        result.hasPendingRequest = friendData?.status === 'pending';
        result.isBlocked = friendData?.status === 'blocked';
      } else {
        result.isFriend = false;
        result.hasPendingRequest = false;
        result.isBlocked = false;
      }
    }

    return {
      success: true,
      results: results,
      count: results.length,
    };
  } catch (error: any) {
    console.error('Error searching users:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to search users: ' + error.message
    );
  }
});

/**
 * Send a friend request
 */
export const sendFriendRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { targetUserId } = data;
  const requesterId = context.auth.uid;

  if (!targetUserId) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Target user ID is required.'
    );
  }

  if (requesterId === targetUserId) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Cannot send friend request to yourself.'
    );
  }

  try {
    // Check if target user exists
    const targetUserDoc = await db.collection('users').doc(targetUserId).get();
    if (!targetUserDoc.exists) {
      throw new functions.https.HttpsError(
        'not-found',
        'Target user not found.'
      );
    }

    const targetUserData = targetUserDoc.data();

    // Check privacy settings
    if (targetUserData?.settings?.privacy?.allowFriendRequests === false) {
      throw new functions.https.HttpsError(
        'permission-denied',
        'User does not accept friend requests.'
      );
    }

    // Check if already friends or request exists
    const existingRequest = await db
      .collection('friends')
      .doc(requesterId)
      .collection('connections')
      .doc(targetUserId)
      .get();

    if (existingRequest.exists) {
      const status = existingRequest.data()?.status;
      if (status === 'accepted') {
        throw new functions.https.HttpsError(
          'already-exists',
          'Already friends with this user.'
        );
      }
      if (status === 'pending') {
        throw new functions.https.HttpsError(
          'already-exists',
          'Friend request already sent.'
        );
      }
      if (status === 'blocked') {
        throw new functions.https.HttpsError(
          'permission-denied',
          'Cannot send request to blocked user.'
        );
      }
    }

    // Rate limiting: max 10 requests per day
    const today = new Date().toISOString().split('T')[0];
    const requestsToday = await db
      .collection('friends')
      .doc(requesterId)
      .collection('connections')
      .where('createdAt', '>=', new Date(today))
      .where('requestedBy', '==', requesterId)
      .count()
      .get();

    if (requestsToday.data().count >= 10) {
      throw new functions.https.HttpsError(
        'resource-exhausted',
        'Maximum friend requests per day reached.'
      );
    }

    // Get requester data
    const requesterDoc = await db.collection('users').doc(requesterId).get();
    const requesterData = requesterDoc.data();

    const friendData = {
      userId: requesterId,
      friendId: targetUserId,
      status: 'pending',
      requestedBy: requesterId,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      friendUsername: targetUserData?.username,
      friendDisplayName: targetUserData?.displayName,
      friendPhotoURL: targetUserData?.photoURL,
    };

    const targetFriendData = {
      userId: targetUserId,
      friendId: requesterId,
      status: 'pending',
      requestedBy: requesterId,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      friendUsername: requesterData?.username,
      friendDisplayName: requesterData?.displayName,
      friendPhotoURL: requesterData?.photoURL,
    };

    // Create friend request in both users' collections
    const batch = db.batch();

    batch.set(
      db.collection('friends').doc(requesterId).collection('connections').doc(targetUserId),
      friendData
    );

    batch.set(
      db.collection('friends').doc(targetUserId).collection('connections').doc(requesterId),
      targetFriendData
    );

    // Update metadata
    batch.set(
      db.collection('friends').doc(requesterId).collection('metadata').doc('stats'),
      { sentRequests: admin.firestore.FieldValue.increment(1) },
      { merge: true }
    );

    batch.set(
      db.collection('friends').doc(targetUserId).collection('metadata').doc('stats'),
      { pendingRequests: admin.firestore.FieldValue.increment(1) },
      { merge: true }
    );

    await batch.commit();

    // TODO: Send notification to target user

    return {
      success: true,
      message: 'Friend request sent successfully',
    };
  } catch (error: any) {
    console.error('Error sending friend request:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to send friend request: ' + error.message
    );
  }
});

/**
 * Accept a friend request
 */
export const acceptFriendRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { requesterId } = data;
  const userId = context.auth.uid;

  if (!requesterId) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Requester ID is required.'
    );
  }

  try {
    // Check if request exists
    const requestDoc = await db
      .collection('friends')
      .doc(userId)
      .collection('connections')
      .doc(requesterId)
      .get();

    if (!requestDoc.exists) {
      throw new functions.https.HttpsError(
        'not-found',
        'Friend request not found.'
      );
    }

    const requestData = requestDoc.data();

    if (requestData?.status !== 'pending') {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Friend request is not pending.'
      );
    }

    if (requestData?.requestedBy !== requesterId) {
      throw new functions.https.HttpsError(
        'permission-denied',
        'This request was not sent by the specified user.'
      );
    }

    const batch = db.batch();
    const now = admin.firestore.FieldValue.serverTimestamp();

    // Update both users' friend documents
    batch.update(
      db.collection('friends').doc(userId).collection('connections').doc(requesterId),
      {
        status: 'accepted',
        acceptedAt: now,
        lastInteraction: now,
      }
    );

    batch.update(
      db.collection('friends').doc(requesterId).collection('connections').doc(userId),
      {
        status: 'accepted',
        acceptedAt: now,
        lastInteraction: now,
      }
    );

    // Update metadata
    batch.set(
      db.collection('friends').doc(userId).collection('metadata').doc('stats'),
      {
        totalFriends: admin.firestore.FieldValue.increment(1),
        pendingRequests: admin.firestore.FieldValue.increment(-1),
      },
      { merge: true }
    );

    batch.set(
      db.collection('friends').doc(requesterId).collection('metadata').doc('stats'),
      {
        totalFriends: admin.firestore.FieldValue.increment(1),
        sentRequests: admin.firestore.FieldValue.increment(-1),
      },
      { merge: true }
    );

    await batch.commit();

    // TODO: Send notification to requester

    return {
      success: true,
      message: 'Friend request accepted',
    };
  } catch (error: any) {
    console.error('Error accepting friend request:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to accept friend request: ' + error.message
    );
  }
});

/**
 * Reject a friend request
 */
export const rejectFriendRequest = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { requesterId } = data;
  const userId = context.auth.uid;

  try {
    const batch = db.batch();

    // Delete both friend documents
    batch.delete(
      db.collection('friends').doc(userId).collection('connections').doc(requesterId)
    );

    batch.delete(
      db.collection('friends').doc(requesterId).collection('connections').doc(userId)
    );

    // Update metadata
    batch.set(
      db.collection('friends').doc(userId).collection('metadata').doc('stats'),
      { pendingRequests: admin.firestore.FieldValue.increment(-1) },
      { merge: true }
    );

    batch.set(
      db.collection('friends').doc(requesterId).collection('metadata').doc('stats'),
      { sentRequests: admin.firestore.FieldValue.increment(-1) },
      { merge: true }
    );

    await batch.commit();

    return {
      success: true,
      message: 'Friend request rejected',
    };
  } catch (error: any) {
    console.error('Error rejecting friend request:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to reject friend request: ' + error.message
    );
  }
});

/**
 * Remove a friend
 */
export const removeFriend = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { friendId } = data;
  const userId = context.auth.uid;

  try {
    const batch = db.batch();

    // Delete both friend documents
    batch.delete(
      db.collection('friends').doc(userId).collection('connections').doc(friendId)
    );

    batch.delete(
      db.collection('friends').doc(friendId).collection('connections').doc(userId)
    );

    // Update metadata
    batch.set(
      db.collection('friends').doc(userId).collection('metadata').doc('stats'),
      { totalFriends: admin.firestore.FieldValue.increment(-1) },
      { merge: true }
    );

    batch.set(
      db.collection('friends').doc(friendId).collection('metadata').doc('stats'),
      { totalFriends: admin.firestore.FieldValue.increment(-1) },
      { merge: true }
    );

    await batch.commit();

    return {
      success: true,
      message: 'Friend removed successfully',
    };
  } catch (error: any) {
    console.error('Error removing friend:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to remove friend: ' + error.message
    );
  }
});

/**
 * Block a user
 */
export const blockUser = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { targetUserId } = data;
  const userId = context.auth.uid;

  try {
    const batch = db.batch();

    // Update or create block record
    batch.set(
      db.collection('friends').doc(userId).collection('connections').doc(targetUserId),
      {
        userId: userId,
        friendId: targetUserId,
        status: 'blocked',
        requestedBy: userId,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      }
    );

    // Remove from target user's connections
    batch.delete(
      db.collection('friends').doc(targetUserId).collection('connections').doc(userId)
    );

    await batch.commit();

    return {
      success: true,
      message: 'User blocked successfully',
    };
  } catch (error: any) {
    console.error('Error blocking user:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to block user: ' + error.message
    );
  }
});

/**
 * Get user's friends list
 */
export const getFriendsList = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const userId = context.auth.uid;

  try {
    const friendsSnapshot = await db
      .collection('friends')
      .doc(userId)
      .collection('connections')
      .where('status', '==', 'accepted')
      .orderBy('lastInteraction', 'desc')
      .get();

    const friends = friendsSnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      success: true,
      friends: friends,
      count: friends.length,
    };
  } catch (error: any) {
    console.error('Error getting friends list:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to get friends list: ' + error.message
    );
  }
});

/**
 * Get pending friend requests
 */
export const getPendingRequests = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const userId = context.auth.uid;

  try {
    // Requests received by current user
    const receivedSnapshot = await db
      .collection('friends')
      .doc(userId)
      .collection('connections')
      .where('status', '==', 'pending')
      .where('requestedBy', '!=', userId)
      .orderBy('requestedBy')
      .orderBy('createdAt', 'desc')
      .get();

    // Requests sent by current user
    const sentSnapshot = await db
      .collection('friends')
      .doc(userId)
      .collection('connections')
      .where('status', '==', 'pending')
      .where('requestedBy', '==', userId)
      .orderBy('createdAt', 'desc')
      .get();

    const received = receivedSnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }));

    const sent = sentSnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }));

    return {
      success: true,
      received: received,
      sent: sent,
      receivedCount: received.length,
      sentCount: sent.length,
    };
  } catch (error: any) {
    console.error('Error getting pending requests:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to get pending requests: ' + error.message
    );
  }
});
