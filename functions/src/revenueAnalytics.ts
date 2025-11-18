import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

/**
 * Revenue Analytics Cloud Functions
 *
 * These functions provide secure, backend-calculated revenue metrics
 * All calculations are done on the server to prevent client-side manipulation
 */

interface RevenueMetrics {
  totalRevenue: number;
  activeSubscriptions: number;
  lifetimeRevenue: number;
  monthlyRecurringRevenue: number;
  averageRevenuePerUser: number;
  currency: string;
}

interface UserRevenueData {
  userId: string;
  lifetimeValue: number;
  totalPurchases: number;
  activeSubscription: boolean;
  lastPurchaseDate: admin.firestore.Timestamp | null;
  currency: string;
}

/**
 * Get total revenue across all users
 * Calculates from purchase_history collection (backend source of truth)
 */
export const getTotalRevenue = functions.https.onCall(async (data, context) => {
  // Require authentication for admin operations
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated to access revenue data'
    );
  }

  // Optional: Check if user has admin role
  // const userDoc = await admin.firestore().collection('users').doc(context.auth.uid).get();
  // if (!userDoc.data()?.isAdmin) {
  //   throw new functions.https.HttpsError('permission-denied', 'Admin access required');
  // }

  try {
    const db = admin.firestore();

    // Get all active purchases
    const activePurchases = await db
      .collection('purchase_history')
      .where('status', '==', 'active')
      .get();

    let totalRevenue = 0;
    const currencies: Record<string, number> = {};

    activePurchases.forEach((doc) => {
      const data = doc.data();
      const price = data.price || 0;
      const currency = data.currency || 'USD';

      totalRevenue += price;
      currencies[currency] = (currencies[currency] || 0) + price;
    });

    return {
      totalRevenue,
      activePurchasesCount: activePurchases.size,
      currencies,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    };
  } catch (error) {
    console.error('Error calculating total revenue:', error);
    throw new functions.https.HttpsError('internal', 'Failed to calculate revenue');
  }
});

/**
 * Get user's lifetime value (LTV)
 * This is the authoritative backend calculation
 */
export const getUserLifetimeValue = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required');
  }

  const targetUserId = data.userId || context.auth.uid;

  // Users can only access their own data unless they're admin
  if (targetUserId !== context.auth.uid) {
    // Check admin status if needed
    const userDoc = await admin.firestore().collection('users').doc(context.auth.uid).get();
    if (!userDoc.data()?.isAdmin) {
      throw new functions.https.HttpsError(
        'permission-denied',
        'Cannot access other users revenue data'
      );
    }
  }

  try {
    const db = admin.firestore();

    // Get user subscription which already tracks lifetimeValue from webhooks
    const userSubDoc = await db.collection('user_subscriptions').doc(targetUserId).get();

    if (!userSubDoc.exists) {
      return {
        userId: targetUserId,
        lifetimeValue: 0,
        totalPurchases: 0,
        currency: 'USD',
      };
    }

    const subData = userSubDoc.data();

    // Also get detailed purchase history
    const purchases = await db
      .collection('purchase_history')
      .where('userId', '==', targetUserId)
      .where('status', 'in', ['active', 'expired'])
      .get();

    const purchaseDetails = purchases.docs.map((doc) => ({
      productId: doc.data().productId,
      price: doc.data().price,
      currency: doc.data().currency,
      purchaseDate: doc.data().purchaseDate,
      status: doc.data().status,
    }));

    return {
      userId: targetUserId,
      lifetimeValue: subData?.lifetimeValue || 0,
      totalPurchases: subData?.totalPurchases || 0,
      currency: subData?.store === 'app_store' ? 'USD' : 'USD', // Can be enhanced
      isPremium: subData?.isPremium || false,
      purchaseDetails,
    };
  } catch (error) {
    console.error('Error getting user lifetime value:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get user lifetime value');
  }
});

/**
 * Get comprehensive revenue metrics
 * Admin only - provides dashboard analytics
 */
export const getRevenueMetrics = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required');
  }

  // Check admin permissions
  const userDoc = await admin.firestore().collection('users').doc(context.auth.uid).get();
  if (!userDoc.data()?.isAdmin) {
    throw new functions.https.HttpsError('permission-denied', 'Admin access required');
  }

  try {
    const db = admin.firestore();

    // Get all subscriptions
    const subscriptions = await db.collection('user_subscriptions').get();

    let totalRevenue = 0;
    let activeSubscriptions = 0;
    let monthlyRecurringRevenue = 0;
    let lifetimeRevenue = 0;

    subscriptions.forEach((doc) => {
      const data = doc.data();
      const ltv = data.lifetimeValue || 0;

      lifetimeRevenue += ltv;

      if (data.isPremium) {
        activeSubscriptions++;
      }
    });

    // Get active purchases for current revenue
    const activePurchases = await db
      .collection('purchase_history')
      .where('status', '==', 'active')
      .get();

    activePurchases.forEach((doc) => {
      const data = doc.data();
      totalRevenue += data.price || 0;

      // Estimate MRR (Monthly Recurring Revenue)
      // This is simplified - enhance based on your subscription periods
      if (data.type === 'subscription') {
        monthlyRecurringRevenue += data.price || 0;
      }
    });

    const averageRevenuePerUser =
      subscriptions.size > 0 ? lifetimeRevenue / subscriptions.size : 0;

    const metrics: RevenueMetrics = {
      totalRevenue,
      activeSubscriptions,
      lifetimeRevenue,
      monthlyRecurringRevenue,
      averageRevenuePerUser,
      currency: 'USD',
    };

    return metrics;
  } catch (error) {
    console.error('Error getting revenue metrics:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get revenue metrics');
  }
});

/**
 * Get top revenue users
 * Admin only - for analyzing high-value customers
 */
export const getTopRevenueUsers = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required');
  }

  // Check admin permissions
  const userDoc = await admin.firestore().collection('users').doc(context.auth.uid).get();
  if (!userDoc.data()?.isAdmin) {
    throw new functions.https.HttpsError('permission-denied', 'Admin access required');
  }

  const limit = data.limit || 10;

  try {
    const db = admin.firestore();

    const topUsers = await db
      .collection('user_subscriptions')
      .orderBy('lifetimeValue', 'desc')
      .limit(limit)
      .get();

    const users: UserRevenueData[] = topUsers.docs.map((doc) => {
      const data = doc.data();
      return {
        userId: doc.id,
        lifetimeValue: data.lifetimeValue || 0,
        totalPurchases: data.totalPurchases || 0,
        activeSubscription: data.isPremium || false,
        lastPurchaseDate: data.lastPurchaseDate || null,
        currency: 'USD',
      };
    });

    return { users };
  } catch (error) {
    console.error('Error getting top revenue users:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get top revenue users');
  }
});

/**
 * Get revenue by time period
 * Admin only - for trend analysis
 */
export const getRevenueByPeriod = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required');
  }

  // Check admin permissions
  const userDoc = await admin.firestore().collection('users').doc(context.auth.uid).get();
  if (!userDoc.data()?.isAdmin) {
    throw new functions.https.HttpsError('permission-denied', 'Admin access required');
  }

  const { startDate, endDate } = data;

  if (!startDate || !endDate) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'startDate and endDate are required'
    );
  }

  try {
    const db = admin.firestore();

    const purchases = await db
      .collection('purchase_history')
      .where('purchaseDate', '>=', admin.firestore.Timestamp.fromDate(new Date(startDate)))
      .where('purchaseDate', '<=', admin.firestore.Timestamp.fromDate(new Date(endDate)))
      .get();

    let totalRevenue = 0;
    let purchaseCount = 0;
    const revenueByDay: Record<string, number> = {};

    purchases.forEach((doc) => {
      const data = doc.data();
      const price = data.price || 0;
      const date = data.purchaseDate.toDate().toISOString().split('T')[0];

      totalRevenue += price;
      purchaseCount++;
      revenueByDay[date] = (revenueByDay[date] || 0) + price;
    });

    return {
      totalRevenue,
      purchaseCount,
      revenueByDay,
      period: { startDate, endDate },
    };
  } catch (error) {
    console.error('Error getting revenue by period:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get revenue by period');
  }
});

/**
 * Recalculate user lifetime value
 * Admin only - for data integrity checks/fixes
 */
export const recalculateUserLTV = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'Authentication required');
  }

  // Check admin permissions
  const userDoc = await admin.firestore().collection('users').doc(context.auth.uid).get();
  if (!userDoc.data()?.isAdmin) {
    throw new functions.https.HttpsError('permission-denied', 'Admin access required');
  }

  const { userId } = data;

  if (!userId) {
    throw new functions.https.HttpsError('invalid-argument', 'userId is required');
  }

  try {
    const db = admin.firestore();

    // Calculate from purchase history
    const purchases = await db
      .collection('purchase_history')
      .where('userId', '==', userId)
      .where('status', 'in', ['active', 'expired'])
      .get();

    let calculatedLTV = 0;
    purchases.forEach((doc) => {
      calculatedLTV += doc.data().price || 0;
    });

    // Update user subscription with correct value
    await db.collection('user_subscriptions').doc(userId).update({
      lifetimeValue: calculatedLTV,
      totalPurchases: purchases.size,
    });

    return {
      userId,
      recalculatedLTV: calculatedLTV,
      totalPurchases: purchases.size,
      message: 'User LTV recalculated successfully',
    };
  } catch (error) {
    console.error('Error recalculating user LTV:', error);
    throw new functions.https.HttpsError('internal', 'Failed to recalculate user LTV');
  }
});
