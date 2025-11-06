import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Configuration constants for the battery/energy system
 */
const BATTERY_CONFIG = {
  MAX_HEARTS: 5,
  REFILL_INTERVAL_HOURS: 2,
  REFILL_INTERVAL_MS: 2 * 60 * 60 * 1000, // 2 hours in milliseconds
  DAILY_RESET_HOUR: 0, // Reset at midnight
  DAILY_BONUS_HEARTS: 5,
};

/**
 * Interface for user battery data
 */
interface BatteryData {
  currentHearts: number;
  maxHearts: number;
  lastRefillTime: admin.firestore.Timestamp;
  lastDailyResetDate: string;
  totalHeartsUsed: number;
  totalHeartsRefilled: number;
}

/**
 * Scheduled function that runs every hour to refill hearts for users
 * Triggered by Cloud Scheduler
 */
export const scheduledHeartRefill = functions.pubsub
  .schedule("every 1 hours")
  .onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    const refillThresholdTime = new Date(
      now.toMillis() - BATTERY_CONFIG.REFILL_INTERVAL_MS
    );

    try {
      // Query users who need heart refills
      const usersSnapshot = await db.collection("users")
        .where("battery.currentHearts", "<", BATTERY_CONFIG.MAX_HEARTS)
        .where("battery.lastRefillTime", "<=", refillThresholdTime)
        .limit(500) // Process in batches
        .get();

      const batch = db.batch();
      let updateCount = 0;

      usersSnapshot.forEach((doc) => {
        const userData = doc.data();
        const battery = userData.battery as BatteryData;

        // Calculate how many hearts to refill
        const timeSinceLastRefill =
          now.toMillis() - battery.lastRefillTime.toMillis();
        const intervalsElapsed = Math.floor(
          timeSinceLastRefill / BATTERY_CONFIG.REFILL_INTERVAL_MS
        );
        const heartsToAdd = Math.min(
          intervalsElapsed,
          BATTERY_CONFIG.MAX_HEARTS - battery.currentHearts
        );

        if (heartsToAdd > 0) {
          const newHeartCount = Math.min(
            battery.currentHearts + heartsToAdd,
            BATTERY_CONFIG.MAX_HEARTS
          );

          batch.update(doc.ref, {
            "battery.currentHearts": newHeartCount,
            "battery.lastRefillTime": now,
            "battery.totalHeartsRefilled":
              admin.firestore.FieldValue.increment(heartsToAdd),
          });

          updateCount++;
        }
      });

      if (updateCount > 0) {
        await batch.commit();
        console.log(`Refilled hearts for ${updateCount} users`);
      }

      return {success: true, usersUpdated: updateCount};
    } catch (error) {
      console.error("Error in scheduledHeartRefill:", error);
      throw error;
    }
  });

/**
 * Scheduled function for daily reset and bonus distribution
 * Runs at midnight every day
 */
export const dailyBatteryReset = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("UTC")
  .onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    const today = new Date().toISOString().split("T")[0];

    try {
      // Query users who haven't received today's bonus
      const usersSnapshot = await db.collection("users")
        .where("battery.lastDailyResetDate", "<", today)
        .limit(500)
        .get();

      const batch = db.batch();
      let updateCount = 0;

      usersSnapshot.forEach((doc) => {
        batch.update(doc.ref, {
          "battery.currentHearts": BATTERY_CONFIG.DAILY_BONUS_HEARTS,
          "battery.lastDailyResetDate": today,
          "battery.lastRefillTime": now,
          "dailyStats.lastLoginDate": today,
          "dailyStats.loginStreak": admin.firestore.FieldValue.increment(1),
        });
        updateCount++;
      });

      if (updateCount > 0) {
        await batch.commit();
        console.log(`Daily reset completed for ${updateCount} users`);
      }

      return {success: true, usersUpdated: updateCount};
    } catch (error) {
      console.error("Error in dailyBatteryReset:", error);
      throw error;
    }
  });

/**
 * HTTP function to get current battery status for a user
 * Called from the app when user opens the quiz section
 */
export const getBatteryStatus = functions.https.onCall(
  async (data, context) => {
    // Verify user is authenticated
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;

    try {
      const userDoc = await db.collection("users").doc(userId).get();

      if (!userDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "User not found"
        );
      }

      const userData = userDoc.data();
      const battery = userData?.battery as BatteryData;

      if (!battery) {
        // Initialize battery if it doesn't exist
        const newBattery: BatteryData = {
          currentHearts: BATTERY_CONFIG.MAX_HEARTS,
          maxHearts: BATTERY_CONFIG.MAX_HEARTS,
          lastRefillTime: admin.firestore.Timestamp.now(),
          lastDailyResetDate: new Date().toISOString().split("T")[0],
          totalHeartsUsed: 0,
          totalHeartsRefilled: 0,
        };

        await db.collection("users").doc(userId).update({
          battery: newBattery,
        });

        return {
          currentHearts: newBattery.currentHearts,
          maxHearts: newBattery.maxHearts,
          nextRefillTime: new Date(
            Date.now() + BATTERY_CONFIG.REFILL_INTERVAL_MS
          ).toISOString(),
          canPlayQuiz: true,
        };
      }

      // Calculate next refill time
      const nextRefillTime = new Date(
        battery.lastRefillTime.toMillis() + BATTERY_CONFIG.REFILL_INTERVAL_MS
      );

      return {
        currentHearts: battery.currentHearts,
        maxHearts: battery.maxHearts,
        nextRefillTime: nextRefillTime.toISOString(),
        canPlayQuiz: battery.currentHearts > 0,
        totalHeartsUsed: battery.totalHeartsUsed,
      };
    } catch (error) {
      console.error("Error in getBatteryStatus:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to get battery status"
      );
    }
  }
);

/**
 * HTTP function to consume a heart when user answers incorrectly
 */
export const consumeHeart = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const userId = context.auth.uid;
  const {questionId} = data;

  if (!questionId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Question ID is required"
    );
  }

  try {
    const userRef = db.collection("users").doc(userId);

    // Use a transaction to ensure atomic updates
    const result = await db.runTransaction(async (transaction) => {
      const userDoc = await transaction.get(userRef);

      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const userData = userDoc.data();
      const battery = userData?.battery as BatteryData;

      if (!battery || battery.currentHearts <= 0) {
        return {
          success: false,
          message: "No hearts available",
          currentHearts: battery?.currentHearts || 0,
        };
      }

      // Deduct one heart
      const newHeartCount = battery.currentHearts - 1;

      transaction.update(userRef, {
        "battery.currentHearts": newHeartCount,
        "battery.totalHeartsUsed":
          admin.firestore.FieldValue.increment(1),
      });

      return {
        success: true,
        currentHearts: newHeartCount,
        message: "Heart consumed successfully",
      };
    });

    return result;
  } catch (error) {
    console.error("Error in consumeHeart:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to consume heart"
    );
  }
});

/**
 * HTTP function to restore hearts through premium features or ads
 */
export const restoreHearts = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const userId = context.auth.uid;
  const {method, heartsToAdd} = data; // method: 'ad', 'premium', 'purchase'

  if (!method || !heartsToAdd) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Method and heartsToAdd are required"
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
      const battery = userData?.battery as BatteryData;

      // Verify the restoration method is valid
      if (method === "premium" && !userData?.premium?.active) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Premium subscription required"
        );
      }

      // Add hearts up to maximum
      const newHeartCount = Math.min(
        (battery?.currentHearts || 0) + heartsToAdd,
        BATTERY_CONFIG.MAX_HEARTS
      );

      transaction.update(userRef, {
        "battery.currentHearts": newHeartCount,
        "battery.totalHeartsRefilled":
          admin.firestore.FieldValue.increment(heartsToAdd),
        "battery.lastRefillTime": admin.firestore.Timestamp.now(),
      });

      // Log the restoration for analytics
      transaction.set(
        db.collection("analytics").doc(),
        {
          userId,
          eventType: "heart_restore",
          method,
          heartsRestored: heartsToAdd,
          timestamp: admin.firestore.Timestamp.now(),
        }
      );

      return {
        success: true,
        currentHearts: newHeartCount,
        message: `${heartsToAdd} hearts restored via ${method}`,
      };
    });

    return result;
  } catch (error) {
    console.error("Error in restoreHearts:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to restore hearts"
    );
  }
});
