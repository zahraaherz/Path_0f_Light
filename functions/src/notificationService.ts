import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {NotificationPayload, FCMToken} from "./types";

const db = admin.firestore();

/**
 * Send a push notification to a user
 * Retrieves user's FCM tokens and sends notification to all devices
 */
export async function sendNotification(
  payload: NotificationPayload
): Promise<void> {
  try {
    // Get user's FCM tokens
    const tokensSnapshot = await db
      .collection("fcm_tokens")
      .where("userId", "==", payload.userId)
      .get();

    if (tokensSnapshot.empty) {
      console.log(`No FCM tokens found for user ${payload.userId}`);
      return;
    }

    const tokens: string[] = [];
    const tokenDocs: admin.firestore.QueryDocumentSnapshot[] = [];

    tokensSnapshot.forEach((doc) => {
      const tokenData = doc.data() as FCMToken;
      tokens.push(tokenData.token);
      tokenDocs.push(doc);
    });

    if (tokens.length === 0) {
      console.log(`No valid tokens for user ${payload.userId}`);
      return;
    }

    // Prepare the notification message
    const message: admin.messaging.MulticastMessage = {
      tokens,
      notification: {
        title: payload.title,
        body: payload.body,
        imageUrl: payload.imageUrl,
      },
      data: payload.data,
      android: {
        priority: "high",
        notification: {
          sound: payload.sound || "default",
          channelId: "reminders",
          priority: "high",
        },
      },
      apns: {
        payload: {
          aps: {
            sound: payload.sound || "default",
            badge: 1,
          },
        },
      },
    };

    // Send the message
    const response = await admin.messaging().sendEachForMulticast(message);

    console.log(`Successfully sent ${response.successCount} notifications`);

    // Handle failed tokens
    if (response.failureCount > 0) {
      const failedTokens: string[] = [];
      response.responses.forEach((resp, idx) => {
        if (!resp.success) {
          failedTokens.push(tokens[idx]);
          console.error(
            `Error sending to token ${tokens[idx]}:`,
            resp.error
          );

          // Remove invalid tokens
          if (
            resp.error?.code === "messaging/invalid-registration-token" ||
            resp.error?.code === "messaging/registration-token-not-registered"
          ) {
            // Delete the invalid token
            tokenDocs[idx].ref.delete().catch((err) => {
              console.error("Error deleting invalid token:", err);
            });
          }
        }
      });
    }

    // Update last used timestamp for successful tokens
    const batch = db.batch();
    response.responses.forEach((resp, idx) => {
      if (resp.success) {
        batch.update(tokenDocs[idx].ref, {
          lastUsed: admin.firestore.Timestamp.now(),
        });
      }
    });
    await batch.commit();
  } catch (error) {
    console.error("Error sending notification:", error);
    throw error;
  }
}

/**
 * Callable function to register a user's FCM token
 */
export const registerFCMToken = functions.https.onCall(
  async (data, context) => {
    // Verify authentication
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {token, platform} = data;

    if (!token) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Token is required"
      );
    }

    if (!platform || !["android", "ios", "web"].includes(platform)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Invalid platform"
      );
    }

    try {
      const userId = context.auth.uid;

      // Check if token already exists
      const existingToken = await db
        .collection("fcm_tokens")
        .where("userId", "==", userId)
        .where("token", "==", token)
        .limit(1)
        .get();

      if (!existingToken.empty) {
        // Update existing token
        await existingToken.docs[0].ref.update({
          platform,
          lastUsed: admin.firestore.Timestamp.now(),
        });
      } else {
        // Create new token document
        await db.collection("fcm_tokens").add({
          userId,
          token,
          platform,
          createdAt: admin.firestore.Timestamp.now(),
          lastUsed: admin.firestore.Timestamp.now(),
        });
      }

      console.log(`Registered FCM token for user ${userId}`);

      return {success: true};
    } catch (error) {
      console.error("Error registering FCM token:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to register token"
      );
    }
  }
);

/**
 * Callable function to unregister a user's FCM token
 */
export const unregisterFCMToken = functions.https.onCall(
  async (data, context) => {
    // Verify authentication
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {token} = data;

    if (!token) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Token is required"
      );
    }

    try {
      const userId = context.auth.uid;

      // Find and delete the token
      const tokensSnapshot = await db
        .collection("fcm_tokens")
        .where("userId", "==", userId)
        .where("token", "==", token)
        .get();

      const batch = db.batch();
      tokensSnapshot.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();

      console.log(`Unregistered FCM token for user ${userId}`);

      return {success: true};
    } catch (error) {
      console.error("Error unregistering FCM token:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to unregister token"
      );
    }
  }
);

/**
 * Callable function to send a test notification
 * Useful for testing notification setup
 */
export const sendTestNotification = functions.https.onCall(
  async (data, context) => {
    // Verify authentication
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    try {
      const userId = context.auth.uid;

      await sendNotification({
        userId,
        title: "Path of Light",
        body: "Test notification - your reminders are working! 🌟",
        data: {
          type: "test",
        },
      });

      return {
        success: true,
        message: "Test notification sent successfully",
      };
    } catch (error) {
      console.error("Error sending test notification:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to send test notification"
      );
    }
  }
);

/**
 * Scheduled function to clean up old FCM tokens
 * Runs daily to remove tokens that haven't been used in 90 days
 */
export const cleanupOldTokens = functions.pubsub
  .schedule("every 24 hours")
  .onRun(async (context) => {
    console.log("Cleaning up old FCM tokens...");

    try {
      const ninetyDaysAgo = new Date();
      ninetyDaysAgo.setDate(ninetyDaysAgo.getDate() - 90);
      const cutoffTimestamp = admin.firestore.Timestamp.fromDate(
        ninetyDaysAgo
      );

      const oldTokensSnapshot = await db
        .collection("fcm_tokens")
        .where("lastUsed", "<", cutoffTimestamp)
        .get();

      if (oldTokensSnapshot.empty) {
        console.log("No old tokens to clean up");
        return null;
      }

      const batch = db.batch();
      oldTokensSnapshot.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();

      console.log(`Deleted ${oldTokensSnapshot.size} old FCM tokens`);
      return null;
    } catch (error) {
      console.error("Error cleaning up old tokens:", error);
      throw error;
    }
  });

/**
 * Firestore trigger when a user is deleted
 * Automatically removes their FCM tokens
 */
export const onUserDeleted = functions.firestore
  .document("users/{userId}")
  .onDelete(async (snap, context) => {
    const userId = context.params.userId;

    try {
      // Delete all FCM tokens for this user
      const tokensSnapshot = await db
        .collection("fcm_tokens")
        .where("userId", "==", userId)
        .get();

      const batch = db.batch();
      tokensSnapshot.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();

      console.log(`Deleted ${tokensSnapshot.size} FCM tokens for user ${userId}`);
      return null;
    } catch (error) {
      console.error("Error deleting user's FCM tokens:", error);
      return null;
    }
  });
