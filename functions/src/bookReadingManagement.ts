import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const db = admin.firestore();

// Energy rewards configuration
const READING_REWARDS = {
  PARAGRAPH: 0.5,
  SECTION: 2,
  BOOK: 10,
  COMMENT: 1,
  DAILY_STREAK: 5,
};

/**
 * Save reading progress
 */
export const saveReadingProgress = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { bookId, paragraphId, sectionId, pageNumber, totalPages } = data;
  const userId = context.auth.uid;

  if (!bookId || !paragraphId) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Book ID and paragraph ID are required.'
    );
  }

  try {
    const progressRef = db
      .collection('userBookProgress')
      .doc(userId)
      .collection('books')
      .doc(bookId);

    const progressDoc = await progressRef.get();
    const now = admin.firestore.FieldValue.serverTimestamp();

    let progressData: any = {
      bookId,
      userId,
      currentParagraphId: paragraphId,
      currentSectionId: sectionId,
      currentPage: pageNumber || 0,
      lastReadAt: now,
      totalPagesRead: admin.firestore.FieldValue.increment(1),
    };

    if (!progressDoc.exists) {
      // First time reading this book
      progressData.startedAt = now;
      progressData.energyEarned = 0;
      progressData.readingStreak = 1;
      progressData.completedSections = [];
    }

    // Calculate progress percentage
    if (totalPages) {
      progressData.progressPercentage = ((pageNumber || 0) / totalPages) * 100;

      // Check if book is completed
      if (pageNumber >= totalPages - 1) {
        progressData.completedAt = now;

        // Award energy for completing book
        await awardEnergyForReading(userId, 'BOOK');
        progressData.energyEarned = admin.firestore.FieldValue.increment(READING_REWARDS.BOOK);
      }
    }

    // Award energy for reading paragraph
    await awardEnergyForReading(userId, 'PARAGRAPH');
    progressData.energyEarned = admin.firestore.FieldValue.increment(READING_REWARDS.PARAGRAPH);

    await progressRef.set(progressData, { merge: true });

    // Update reading streak
    await updateReadingStreak(userId);

    return {
      success: true,
      message: 'Progress saved successfully',
      energyEarned: READING_REWARDS.PARAGRAPH,
    };
  } catch (error: any) {
    console.error('Error saving reading progress:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to save progress: ' + error.message
    );
  }
});

/**
 * Mark section as completed
 */
export const markSectionCompleted = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { bookId, sectionId } = data;
  const userId = context.auth.uid;

  try {
    const progressRef = db
      .collection('userBookProgress')
      .doc(userId)
      .collection('books')
      .doc(bookId);

    await progressRef.update({
      completedSections: admin.firestore.FieldValue.arrayUnion(sectionId),
      energyEarned: admin.firestore.FieldValue.increment(READING_REWARDS.SECTION),
    });

    // Award energy for completing section
    await awardEnergyForReading(userId, 'SECTION');

    return {
      success: true,
      message: 'Section marked as completed',
      energyEarned: READING_REWARDS.SECTION,
    };
  } catch (error: any) {
    console.error('Error marking section completed:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to mark section completed: ' + error.message
    );
  }
});

/**
 * Create a bookmark
 */
export const createBookmark = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { bookId, paragraphId, pageNumber, sectionTitle, note, color } = data;
  const userId = context.auth.uid;

  if (!bookId || !paragraphId) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Book ID and paragraph ID are required.'
    );
  }

  try {
    const bookmarkRef = db
      .collection('userBookmarks')
      .doc(userId)
      .collection('bookmarks')
      .doc();

    const bookmarkData = {
      id: bookmarkRef.id,
      bookId,
      userId,
      paragraphId,
      pageNumber: pageNumber || 0,
      sectionTitle: sectionTitle || '',
      note: note || null,
      color: color || 'default',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await bookmarkRef.set(bookmarkData);

    return {
      success: true,
      message: 'Bookmark created successfully',
      bookmark: bookmarkData,
    };
  } catch (error: any) {
    console.error('Error creating bookmark:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to create bookmark: ' + error.message
    );
  }
});

/**
 * Delete a bookmark
 */
export const deleteBookmark = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { bookmarkId } = data;
  const userId = context.auth.uid;

  try {
    await db
      .collection('userBookmarks')
      .doc(userId)
      .collection('bookmarks')
      .doc(bookmarkId)
      .delete();

    return {
      success: true,
      message: 'Bookmark deleted successfully',
    };
  } catch (error: any) {
    console.error('Error deleting bookmark:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to delete bookmark: ' + error.message
    );
  }
});

/**
 * Create a comment on a paragraph
 */
export const createComment = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated to comment.'
    );
  }

  const { bookId, paragraphId, text, isPrivate, parentCommentId } = data;
  const userId = context.auth.uid;

  if (!bookId || !paragraphId || !text || text.trim().length === 0) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Book ID, paragraph ID, and comment text are required.'
    );
  }

  if (text.length > 500) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Comment text cannot exceed 500 characters.'
    );
  }

  try {
    // Rate limiting: max 50 comments per day
    const today = new Date().toISOString().split('T')[0];
    const commentsToday = await db
      .collection('bookComments')
      .where('userId', '==', userId)
      .where('createdAt', '>=', new Date(today))
      .count()
      .get();

    if (commentsToday.data().count >= 50) {
      throw new functions.https.HttpsError(
        'resource-exhausted',
        'Maximum comments per day reached.'
      );
    }

    // Get user data
    const userDoc = await db.collection('users').doc(userId).get();
    const userData = userDoc.data();

    const commentRef = db.collection('bookComments').doc();
    const commentData = {
      id: commentRef.id,
      bookId,
      paragraphId,
      userId,
      username: userData?.username || 'Anonymous',
      userPhoto: userData?.photoURL || null,
      text: text.trim(),
      isPrivate: isPrivate || false,
      likes: 0,
      likedBy: [],
      replies: 0,
      parentCommentId: parentCommentId || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: null,
      isEdited: false,
      isReported: false,
      isDeleted: false,
    };

    await commentRef.set(commentData);

    // If this is a reply, increment parent comment's reply count
    if (parentCommentId) {
      await db
        .collection('bookComments')
        .doc(parentCommentId)
        .update({
          replies: admin.firestore.FieldValue.increment(1),
        });
    }

    // Award energy for commenting
    if (!isPrivate) {
      await awardEnergyForReading(userId, 'COMMENT');
    }

    return {
      success: true,
      message: 'Comment created successfully',
      comment: commentData,
      energyEarned: !isPrivate ? READING_REWARDS.COMMENT : 0,
    };
  } catch (error: any) {
    console.error('Error creating comment:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to create comment: ' + error.message
    );
  }
});

/**
 * Update/edit a comment
 */
export const updateComment = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { commentId, text } = data;
  const userId = context.auth.uid;

  if (!commentId || !text || text.trim().length === 0) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Comment ID and text are required.'
    );
  }

  try {
    const commentDoc = await db.collection('bookComments').doc(commentId).get();

    if (!commentDoc.exists) {
      throw new functions.https.HttpsError(
        'not-found',
        'Comment not found.'
      );
    }

    const commentData = commentDoc.data();

    // Check ownership
    if (commentData?.userId !== userId) {
      throw new functions.https.HttpsError(
        'permission-denied',
        'You can only edit your own comments.'
      );
    }

    // Check if already edited
    if (commentData?.isEdited) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'Comment can only be edited once.'
      );
    }

    // Check if within 5 minutes
    const createdAt = commentData?.createdAt?.toDate();
    const now = new Date();
    const diffMinutes = (now.getTime() - createdAt.getTime()) / 1000 / 60;

    if (diffMinutes > 5) {
      throw new functions.https.HttpsError(
        'deadline-exceeded',
        'Comments can only be edited within 5 minutes of creation.'
      );
    }

    await db.collection('bookComments').doc(commentId).update({
      text: text.trim(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      isEdited: true,
    });

    return {
      success: true,
      message: 'Comment updated successfully',
    };
  } catch (error: any) {
    console.error('Error updating comment:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to update comment: ' + error.message
    );
  }
});

/**
 * Delete a comment
 */
export const deleteComment = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { commentId } = data;
  const userId = context.auth.uid;

  try {
    const commentDoc = await db.collection('bookComments').doc(commentId).get();

    if (!commentDoc.exists) {
      throw new functions.https.HttpsError(
        'not-found',
        'Comment not found.'
      );
    }

    const commentData = commentDoc.data();

    // Check ownership or admin
    const userDoc = await db.collection('users').doc(userId).get();
    const isAdmin = userDoc.data()?.role === 'admin' || userDoc.data()?.role === 'moderator';

    if (commentData?.userId !== userId && !isAdmin) {
      throw new functions.https.HttpsError(
        'permission-denied',
        'You can only delete your own comments.'
      );
    }

    // Soft delete
    await db.collection('bookComments').doc(commentId).update({
      isDeleted: true,
      text: '[deleted]',
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // If this was a reply, decrement parent's reply count
    if (commentData?.parentCommentId) {
      await db
        .collection('bookComments')
        .doc(commentData.parentCommentId)
        .update({
          replies: admin.firestore.FieldValue.increment(-1),
        });
    }

    return {
      success: true,
      message: 'Comment deleted successfully',
    };
  } catch (error: any) {
    console.error('Error deleting comment:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to delete comment: ' + error.message
    );
  }
});

/**
 * Like or unlike a comment
 */
export const toggleCommentLike = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { commentId } = data;
  const userId = context.auth.uid;

  try {
    const commentRef = db.collection('bookComments').doc(commentId);
    const commentDoc = await commentRef.get();

    if (!commentDoc.exists) {
      throw new functions.https.HttpsError(
        'not-found',
        'Comment not found.'
      );
    }

    const commentData = commentDoc.data();
    const likedBy = commentData?.likedBy || [];
    const isLiked = likedBy.includes(userId);

    if (isLiked) {
      // Unlike
      await commentRef.update({
        likes: admin.firestore.FieldValue.increment(-1),
        likedBy: admin.firestore.FieldValue.arrayRemove(userId),
      });

      return {
        success: true,
        message: 'Comment unliked',
        isLiked: false,
      };
    } else {
      // Like
      await commentRef.update({
        likes: admin.firestore.FieldValue.increment(1),
        likedBy: admin.firestore.FieldValue.arrayUnion(userId),
      });

      return {
        success: true,
        message: 'Comment liked',
        isLiked: true,
      };
    }
  } catch (error: any) {
    console.error('Error toggling comment like:', error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError(
      'internal',
      'Failed to toggle like: ' + error.message
    );
  }
});

/**
 * Get comments for a paragraph
 */
export const getComments = functions.https.onCall(async (data, context) => {
  const { paragraphId, includePrivate, limit = 20, lastDocId } = data;
  const userId = context.auth?.uid;

  if (!paragraphId) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Paragraph ID is required.'
    );
  }

  try {
    let query = db
      .collection('bookComments')
      .where('paragraphId', '==', paragraphId)
      .where('isDeleted', '==', false)
      .where('parentCommentId', '==', null)
      .orderBy('createdAt', 'desc')
      .limit(limit);

    // Only show public comments for non-authenticated users
    if (!includePrivate || !userId) {
      query = query.where('isPrivate', '==', false);
    } else {
      // Show public comments and user's own private comments
      // This requires a composite index
    }

    if (lastDocId) {
      const lastDoc = await db.collection('bookComments').doc(lastDocId).get();
      query = query.startAfter(lastDoc);
    }

    const snapshot = await query.get();
    const comments = snapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }));

    // Get replies for each comment
    for (const comment of comments) {
      const repliesSnapshot = await db
        .collection('bookComments')
        .where('parentCommentId', '==', comment.id)
        .where('isDeleted', '==', false)
        .orderBy('createdAt', 'asc')
        .limit(5)
        .get();

      comment.repliesList = repliesSnapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data(),
      }));
    }

    return {
      success: true,
      comments: comments,
      hasMore: snapshot.size === limit,
      lastDocId: snapshot.docs[snapshot.docs.length - 1]?.id,
    };
  } catch (error: any) {
    console.error('Error getting comments:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to get comments: ' + error.message
    );
  }
});

/**
 * Report a paragraph issue
 */
export const reportParagraph = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { bookId, paragraphId, issueType, description } = data;
  const userId = context.auth.uid;

  if (!bookId || !paragraphId || !issueType || !description) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'All fields are required.'
    );
  }

  try {
    const reportRef = db.collection('paragraphReports').doc();
    const reportData = {
      id: reportRef.id,
      bookId,
      paragraphId,
      userId,
      issueType,
      description: description.trim(),
      status: 'pending',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await reportRef.set(reportData);

    return {
      success: true,
      message: 'Report submitted successfully. Thank you for helping improve our content!',
    };
  } catch (error: any) {
    console.error('Error reporting paragraph:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to submit report: ' + error.message
    );
  }
});

/**
 * Add book to collection
 */
export const addToCollection = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated.'
    );
  }

  const { bookId, collectionId } = data;
  const userId = context.auth.uid;

  try {
    let targetCollectionId = collectionId;

    // If no collection specified, use default "My Books" collection
    if (!collectionId) {
      const defaultCollection = await db
        .collection('userBookCollections')
        .doc(userId)
        .collection('collections')
        .where('isDefault', '==', true)
        .limit(1)
        .get();

      if (defaultCollection.empty) {
        // Create default collection
        const newCollectionRef = db
          .collection('userBookCollections')
          .doc(userId)
          .collection('collections')
          .doc();

        await newCollectionRef.set({
          id: newCollectionRef.id,
          userId,
          name: 'My Books',
          description: 'My reading collection',
          bookIds: [bookId],
          isPublic: false,
          isDefault: true,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        return {
          success: true,
          message: 'Book added to your collection',
        };
      } else {
        targetCollectionId = defaultCollection.docs[0].id;
      }
    }

    // Add book to collection
    await db
      .collection('userBookCollections')
      .doc(userId)
      .collection('collections')
      .doc(targetCollectionId)
      .update({
        bookIds: admin.firestore.FieldValue.arrayUnion(bookId),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

    return {
      success: true,
      message: 'Book added to collection',
    };
  } catch (error: any) {
    console.error('Error adding to collection:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to add book to collection: ' + error.message
    );
  }
});

/**
 * Helper function to award energy for reading activities
 */
async function awardEnergyForReading(
  userId: string,
  action: 'PARAGRAPH' | 'SECTION' | 'BOOK' | 'COMMENT'
): Promise<void> {
  const energyAmount = READING_REWARDS[action];

  await db
    .collection('users')
    .doc(userId)
    .update({
      'energy.currentEnergy': admin.firestore.FieldValue.increment(energyAmount),
      'energy.totalEnergyEarned': admin.firestore.FieldValue.increment(energyAmount),
      'energy.lastUpdateTime': admin.firestore.FieldValue.serverTimestamp(),
    });
}

/**
 * Helper function to update reading streak
 */
async function updateReadingStreak(userId: string): Promise<void> {
  const userDoc = await db.collection('users').doc(userId).get();
  const userData = userDoc.data();

  const lastReadDate = userData?.dailyStats?.lastLoginDate;
  const today = new Date().toISOString().split('T')[0];

  if (lastReadDate !== today) {
    // Check if it's consecutive day
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayStr = yesterday.toISOString().split('T')[0];

    if (lastReadDate === yesterdayStr) {
      // Continue streak
      await db
        .collection('users')
        .doc(userId)
        .update({
          'dailyStats.loginStreak': admin.firestore.FieldValue.increment(1),
          'dailyStats.lastLoginDate': today,
        });

      // Award streak bonus if >= 7 days
      const currentStreak = (userData?.dailyStats?.loginStreak || 0) + 1;
      if (currentStreak % 7 === 0) {
        await awardEnergyForReading(userId, 'BOOK'); // Bonus for 7-day streak
      }
    } else {
      // Reset streak
      await db
        .collection('users')
        .doc(userId)
        .update({
          'dailyStats.loginStreak': 1,
          'dailyStats.lastLoginDate': today,
        });
    }
  }
}
