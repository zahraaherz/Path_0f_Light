import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Configuration constants for the energy system
 * COST-OPTIMIZED: No scheduled functions, all on-demand
 */
export const ENERGY_CONFIG = {
  // Energy costs and limits
  MAX_ENERGY: 100,
  ENERGY_PER_QUESTION: 10, // Cost to answer each question
  ENERGY_BONUS_ON_COMPLETION: 20, // Bonus for completing a quiz

  // Natural refill (calculated on-demand, no scheduled functions)
  REFILL_RATE_PER_HOUR: 5, // Energy points per hour
  REFILL_RATE_MS: 12 * 60 * 1000, // 12 minutes per energy point

  // Daily bonuses
  DAILY_LOGIN_BONUS: 50,

  // Ad rewards
  AD_REWARD_ENERGY: 15, // Energy per ad watched
  AD_COOLDOWN_MINUTES: 5, // Minimum time between ad rewards
  MAX_ADS_PER_DAY: 10, // Maximum ads that can be watched per day

  // Premium subscription benefits
  PREMIUM_MAX_ENERGY: 200, // Double energy for premium users
  PREMIUM_REFILL_RATE_PER_HOUR: 10, // Faster refill for premium
  PREMIUM_UNLIMITED: false, // Set to true to give unlimited energy
};

/**
 * Subscription plan types
 */
export enum SubscriptionPlan {
  FREE = "free",
  MONTHLY = "monthly",
  YEARLY = "yearly",
  LIFETIME = "lifetime",
}

/**
 * Interface for user energy data
 */
interface EnergyData {
  currentEnergy: number;
  maxEnergy: number;
  lastUpdateTime: admin.firestore.Timestamp;
  lastDailyBonusDate: string;
  totalEnergyUsed: number;
  totalEnergyEarned: number;
}

/**
 * Interface for ad tracking
 */
interface AdTracking {
  adsWatchedToday: number;
  lastAdWatchedTime: admin.firestore.Timestamp | null;
  lastAdResetDate: string;
  totalAdsWatched: number;
}

/**
 * Interface for subscription data
 */
interface SubscriptionData {
  plan: SubscriptionPlan;
  active: boolean;
  startDate: admin.firestore.Timestamp | null;
  expiryDate: admin.firestore.Timestamp | null;
  autoRenew: boolean;
}

/**
 * Calculate natural energy refill based on time elapsed
 * This is calculated on-demand, no scheduled functions needed!
 */
function calculateNaturalRefill(
  lastUpdateTime: admin.firestore.Timestamp,
  currentEnergy: number,
  isPremium: boolean
): number {
  const now = admin.firestore.Timestamp.now();
  const elapsedMs = now.toMillis() - lastUpdateTime.toMillis();

  // Calculate refill rate based on subscription
  const refillRate = isPremium ?
    ENERGY_CONFIG.PREMIUM_REFILL_RATE_PER_HOUR :
    ENERGY_CONFIG.REFILL_RATE_PER_HOUR;

  // Calculate energy to add
  const hoursElapsed = elapsedMs / (60 * 60 * 1000);
  const energyToAdd = Math.floor(hoursElapsed * refillRate);

  // Calculate max energy based on subscription
  const maxEnergy = isPremium ?
    ENERGY_CONFIG.PREMIUM_MAX_ENERGY :
    ENERGY_CONFIG.MAX_ENERGY;

  // Return new energy (capped at max)
  return Math.min(currentEnergy + energyToAdd, maxEnergy);
}

/**
 * HTTP function to get current energy status
 * Calculates natural refill on-demand (NO SCHEDULED FUNCTIONS = LOWER COST)
 */
export const getEnergyStatus = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;

    try {
      const userRef = db.collection("users").doc(userId);
      const userDoc = await userRef.get();

      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const userData = userDoc.data();
      const energy = userData?.energy as EnergyData;
      const subscription = userData?.subscription as SubscriptionData;
      const isPremium = subscription?.active || false;

      // Check for daily bonus
      const today = new Date().toISOString().split("T")[0];
      const needsDailyBonus = energy?.lastDailyBonusDate !== today;

      let currentEnergy = energy?.currentEnergy || 0;
      let updated = false;

      if (!energy) {
        // Initialize energy for new user
        const maxEnergy = isPremium ?
          ENERGY_CONFIG.PREMIUM_MAX_ENERGY :
          ENERGY_CONFIG.MAX_ENERGY;

        const newEnergy: EnergyData = {
          currentEnergy: maxEnergy,
          maxEnergy,
          lastUpdateTime: admin.firestore.Timestamp.now(),
          lastDailyBonusDate: today,
          totalEnergyUsed: 0,
          totalEnergyEarned: 0,
        };

        await userRef.update({energy: newEnergy});

        return {
          currentEnergy: newEnergy.currentEnergy,
          maxEnergy: newEnergy.maxEnergy,
          canPlayQuiz: true,
          isPremium,
          dailyBonusAvailable: false,
        };
      }

      // Calculate natural refill
      const refilledEnergy = calculateNaturalRefill(
        energy.lastUpdateTime,
        energy.currentEnergy,
        isPremium
      );

      if (refilledEnergy > energy.currentEnergy) {
        currentEnergy = refilledEnergy;
        updated = true;
      }

      // Add daily bonus if available
      if (needsDailyBonus) {
        const maxEnergy = isPremium ?
          ENERGY_CONFIG.PREMIUM_MAX_ENERGY :
          ENERGY_CONFIG.MAX_ENERGY;

        currentEnergy = Math.min(
          currentEnergy + ENERGY_CONFIG.DAILY_LOGIN_BONUS,
          maxEnergy
        );
        updated = true;
      }

      // Update database if energy changed
      if (updated) {
        await userRef.update({
          "energy.currentEnergy": currentEnergy,
          "energy.lastUpdateTime": admin.firestore.Timestamp.now(),
          ...(needsDailyBonus && {"energy.lastDailyBonusDate": today}),
          ...(needsDailyBonus && {
            "energy.totalEnergyEarned":
              admin.firestore.FieldValue.increment(
                ENERGY_CONFIG.DAILY_LOGIN_BONUS
              ),
          }),
        });
      }

      const maxEnergy = isPremium ?
        ENERGY_CONFIG.PREMIUM_MAX_ENERGY :
        ENERGY_CONFIG.MAX_ENERGY;

      return {
        currentEnergy,
        maxEnergy,
        canPlayQuiz: currentEnergy >= ENERGY_CONFIG.ENERGY_PER_QUESTION,
        isPremium,
        dailyBonusAvailable: needsDailyBonus,
        energyPerQuestion: ENERGY_CONFIG.ENERGY_PER_QUESTION,
        adRewardEnergy: ENERGY_CONFIG.AD_REWARD_ENERGY,
      };
    } catch (error) {
      console.error("Error in getEnergyStatus:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to get energy status"
      );
    }
  }
);

/**
 * HTTP function to consume energy when answering a question
 * Energy is consumed for EVERY question, not just wrong answers
 */
export const consumeEnergy = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const userId = context.auth.uid;
  const {sessionId} = data;

  if (!sessionId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Session ID is required"
    );
  }

  try {
    const userRef = db.collection("users").doc(userId);

    const result = await db.runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const userData = userDoc.data();
      const energy = userData?.energy as EnergyData;
      const subscription = userData?.subscription as SubscriptionData;
      const isPremium = subscription?.active || false;

      // Premium users with unlimited energy don't consume
      if (isPremium && ENERGY_CONFIG.PREMIUM_UNLIMITED) {
        return {
          success: true,
          currentEnergy: energy?.currentEnergy || 0,
          message: "Premium unlimited energy",
          isPremium: true,
        };
      }

      // Calculate natural refill before consuming
      const refilledEnergy = calculateNaturalRefill(
        energy.lastUpdateTime,
        energy.currentEnergy,
        isPremium
      );

      if (refilledEnergy < ENERGY_CONFIG.ENERGY_PER_QUESTION) {
        return {
          success: false,
          message: "Insufficient energy",
          currentEnergy: refilledEnergy,
          energyNeeded: ENERGY_CONFIG.ENERGY_PER_QUESTION,
        };
      }

      const newEnergy = refilledEnergy - ENERGY_CONFIG.ENERGY_PER_QUESTION;

      transaction.update(userRef, {
        "energy.currentEnergy": newEnergy,
        "energy.lastUpdateTime": admin.firestore.Timestamp.now(),
        "energy.totalEnergyUsed":
          admin.firestore.FieldValue.increment(
            ENERGY_CONFIG.ENERGY_PER_QUESTION
          ),
      });

      return {
        success: true,
        currentEnergy: newEnergy,
        energyConsumed: ENERGY_CONFIG.ENERGY_PER_QUESTION,
        message: "Energy consumed successfully",
      };
    });

    return result;
  } catch (error) {
    console.error("Error in consumeEnergy:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to consume energy"
    );
  }
});

/**
 * HTTP function to reward energy for completing a quiz
 */
export const rewardQuizCompletion = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {sessionId, questionsCompleted} = data;

    if (!sessionId || !questionsCompleted) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "sessionId and questionsCompleted are required"
      );
    }

    try {
      const userRef = db.collection("users").doc(userId);

      const result = await db.runTransaction(async (transaction) => {
        const userDoc = await transaction.get(userRef);

        if (!userDoc.exists) {
          throw new functions.https.HttpsError("not-found", "User not found");
        }

        const userData = userDoc.data();
        const energy = userData?.energy as EnergyData;
        const subscription = userData?.subscription as SubscriptionData;
        const isPremium = subscription?.active || false;

        const maxEnergy = isPremium ?
          ENERGY_CONFIG.PREMIUM_MAX_ENERGY :
          ENERGY_CONFIG.MAX_ENERGY;

        const currentEnergy = energy?.currentEnergy || 0;
        const bonusEnergy = ENERGY_CONFIG.ENERGY_BONUS_ON_COMPLETION;
        const newEnergy = Math.min(currentEnergy + bonusEnergy, maxEnergy);

        transaction.update(userRef, {
          "energy.currentEnergy": newEnergy,
          "energy.lastUpdateTime": admin.firestore.Timestamp.now(),
          "energy.totalEnergyEarned":
            admin.firestore.FieldValue.increment(bonusEnergy),
        });

        // Log completion for analytics
        transaction.set(db.collection("analytics").doc(), {
          userId,
          eventType: "quiz_completion",
          sessionId,
          questionsCompleted,
          energyRewarded: bonusEnergy,
          timestamp: admin.firestore.Timestamp.now(),
        });

        return {
          success: true,
          currentEnergy: newEnergy,
          energyRewarded: bonusEnergy,
          message: `Quiz completed! +${bonusEnergy} energy`,
        };
      });

      return result;
    } catch (error) {
      console.error("Error in rewardQuizCompletion:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to reward quiz completion"
      );
    }
  }
);

/**
 * HTTP function to reward energy for watching an ad
 */
export const rewardAdWatch = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const userId = context.auth.uid;
  const {adId, adProvider} = data; // For verification/tracking

  try {
    const userRef = db.collection("users").doc(userId);

    const result = await db.runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const userData = userDoc.data();
      const energy = userData?.energy as EnergyData;
      const adTracking = userData?.adTracking as AdTracking;
      const subscription = userData?.subscription as SubscriptionData;
      const isPremium = subscription?.active || false;

      // Premium users don't need to watch ads
      if (isPremium) {
        return {
          success: false,
          message: "Premium users don't need to watch ads",
          isPremium: true,
        };
      }

      const now = admin.firestore.Timestamp.now();
      const today = new Date().toISOString().split("T")[0];

      // Initialize ad tracking if needed
      const currentAdTracking: AdTracking = adTracking || {
        adsWatchedToday: 0,
        lastAdWatchedTime: null,
        lastAdResetDate: today,
        totalAdsWatched: 0,
      };

      // Reset daily ad count if new day
      if (currentAdTracking.lastAdResetDate !== today) {
        currentAdTracking.adsWatchedToday = 0;
        currentAdTracking.lastAdResetDate = today;
      }

      // Check daily ad limit
      if (currentAdTracking.adsWatchedToday >= ENERGY_CONFIG.MAX_ADS_PER_DAY) {
        return {
          success: false,
          message: "Daily ad limit reached",
          adsRemaining: 0,
        };
      }

      // Check cooldown period
      if (currentAdTracking.lastAdWatchedTime) {
        const timeSinceLastAd =
          now.toMillis() - currentAdTracking.lastAdWatchedTime.toMillis();
        const cooldownMs = ENERGY_CONFIG.AD_COOLDOWN_MINUTES * 60 * 1000;

        if (timeSinceLastAd < cooldownMs) {
          const remainingSeconds = Math.ceil((cooldownMs - timeSinceLastAd) / 1000);
          return {
            success: false,
            message: "Ad cooldown active",
            cooldownRemainingSeconds: remainingSeconds,
          };
        }
      }

      // Award energy
      const maxEnergy = ENERGY_CONFIG.MAX_ENERGY;
      const currentEnergy = energy?.currentEnergy || 0;
      const energyReward = ENERGY_CONFIG.AD_REWARD_ENERGY;
      const newEnergy = Math.min(currentEnergy + energyReward, maxEnergy);

      // Update user data
      transaction.update(userRef, {
        "energy.currentEnergy": newEnergy,
        "energy.lastUpdateTime": now,
        "energy.totalEnergyEarned":
          admin.firestore.FieldValue.increment(energyReward),
        "adTracking.adsWatchedToday": currentAdTracking.adsWatchedToday + 1,
        "adTracking.lastAdWatchedTime": now,
        "adTracking.lastAdResetDate": today,
        "adTracking.totalAdsWatched":
          admin.firestore.FieldValue.increment(1),
      });

      // Log ad watch for analytics and verification
      transaction.set(db.collection("analytics").doc(), {
        userId,
        eventType: "ad_watched",
        adId,
        adProvider,
        energyRewarded: energyReward,
        timestamp: now,
      });

      return {
        success: true,
        currentEnergy: newEnergy,
        energyRewarded: energyReward,
        adsRemaining:
          ENERGY_CONFIG.MAX_ADS_PER_DAY -
          (currentAdTracking.adsWatchedToday + 1),
        message: `Ad reward! +${energyReward} energy`,
      };
    });

    return result;
  } catch (error) {
    console.error("Error in rewardAdWatch:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to reward ad watch"
    );
  }
});

/**
 * HTTP function to activate or update subscription
 */
export const updateSubscription = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {plan, purchaseToken} = data; // purchaseToken from payment verification

    if (!plan || !Object.values(SubscriptionPlan).includes(plan)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Valid subscription plan is required"
      );
    }

    // TODO: Verify purchase with payment provider (Google Play, Apple, Stripe, etc.)
    // For now, we'll assume verification is done

    try {
      const userRef = db.collection("users").doc(userId);

      const result = await db.runTransaction(async (transaction) => {
        const userDoc = await transaction.get(userRef);

        if (!userDoc.exists) {
          throw new functions.https.HttpsError("not-found", "User not found");
        }

        const now = admin.firestore.Timestamp.now();
        let expiryDate: admin.firestore.Timestamp | null = null;

        // Calculate expiry based on plan
        if (plan === SubscriptionPlan.MONTHLY) {
          const expiry = new Date();
          expiry.setMonth(expiry.getMonth() + 1);
          expiryDate = admin.firestore.Timestamp.fromDate(expiry);
        } else if (plan === SubscriptionPlan.YEARLY) {
          const expiry = new Date();
          expiry.setFullYear(expiry.getFullYear() + 1);
          expiryDate = admin.firestore.Timestamp.fromDate(expiry);
        }
        // LIFETIME has no expiry

        const subscriptionData: SubscriptionData = {
          plan: plan as SubscriptionPlan,
          active: true,
          startDate: now,
          expiryDate,
          autoRenew: plan !== SubscriptionPlan.LIFETIME,
        };

        // Update energy limits for premium users
        const userData = userDoc.data();
        const currentEnergy = userData?.energy?.currentEnergy || 0;

        transaction.update(userRef, {
          subscription: subscriptionData,
          "energy.maxEnergy": ENERGY_CONFIG.PREMIUM_MAX_ENERGY,
          "energy.currentEnergy": Math.min(
            currentEnergy,
            ENERGY_CONFIG.PREMIUM_MAX_ENERGY
          ),
        });

        // Log subscription for analytics
        transaction.set(db.collection("analytics").doc(), {
          userId,
          eventType: "subscription_activated",
          plan,
          purchaseToken,
          timestamp: now,
        });

        return {
          success: true,
          subscription: subscriptionData,
          message: `${plan} subscription activated!`,
        };
      });

      return result;
    } catch (error) {
      console.error("Error in updateSubscription:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to update subscription"
      );
    }
  }
);

/**
 * HTTP function to check and update subscription status
 * Call this periodically or when user opens app
 */
export const checkSubscriptionStatus = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;

    try {
      const userRef = db.collection("users").doc(userId);
      const userDoc = await userRef.get();

      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const userData = userDoc.data();
      const subscription = userData?.subscription as SubscriptionData;

      if (!subscription || !subscription.active) {
        return {
          active: false,
          plan: SubscriptionPlan.FREE,
          message: "No active subscription",
        };
      }

      // Check if subscription has expired
      const now = admin.firestore.Timestamp.now();

      if (
        subscription.expiryDate &&
        subscription.expiryDate.toMillis() < now.toMillis()
      ) {
        // Subscription expired, deactivate
        await userRef.update({
          "subscription.active": false,
          "energy.maxEnergy": ENERGY_CONFIG.MAX_ENERGY,
        });

        return {
          active: false,
          plan: SubscriptionPlan.FREE,
          message: "Subscription expired",
          expiredDate: subscription.expiryDate.toDate().toISOString(),
        };
      }

      // Subscription is active
      return {
        active: true,
        plan: subscription.plan,
        expiryDate: subscription.expiryDate?.toDate().toISOString(),
        autoRenew: subscription.autoRenew,
        message: "Subscription active",
      };
    } catch (error) {
      console.error("Error in checkSubscriptionStatus:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to check subscription status"
      );
    }
  }
);
