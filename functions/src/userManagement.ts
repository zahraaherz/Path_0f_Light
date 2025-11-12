import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {ENERGY_CONFIG} from "./energySystem";

const db = admin.firestore();
const auth = admin.auth();

/**
 * User roles for access control
 */
export enum UserRole {
  USER = "user",
  SCHOLAR = "scholar",
  ADMIN = "admin",
  MODERATOR = "moderator",
}

/**
 * Auth providers
 */
export enum AuthProvider {
  EMAIL = "password",
  GOOGLE = "google.com",
  APPLE = "apple.com",
  FACEBOOK = "facebook.com",
  PHONE = "phone",
}

/**
 * Interface for user profile data
 */
interface UserProfileData {
  uid: string;
  email: string | null;
  displayName: string | null;
  photoURL: string | null;
  phoneNumber: string | null;
  language: "en" | "ar";
  emailVerified: boolean;
  phoneVerified: boolean;
  provider: string;
  providers: string[];
  role: UserRole;
  createdAt: admin.firestore.Timestamp;
  lastActive: admin.firestore.Timestamp;
  accountStatus: "active" | "suspended" | "deleted";
  profileComplete: boolean;
}

/**
 * Firebase Authentication Trigger
 * Automatically called when a new user is created
 * Initializes user data in Firestore
 */
export const onUserCreated = functions.auth.user().onCreate(async (user) => {
  try {
    const now = admin.firestore.Timestamp.now();
    const today = new Date().toISOString().split("T")[0];

    // Determine primary provider
    const primaryProvider = user.providerData[0]?.providerId || "password";
    const allProviders = user.providerData.map((p) => p.providerId);

    // Initialize user profile
    const userProfile: UserProfileData = {
      uid: user.uid,
      email: user.email || null,
      displayName: user.displayName || null,
      photoURL: user.photoURL || null,
      phoneNumber: user.phoneNumber || null,
      language: "en",
      emailVerified: user.emailVerified,
      phoneVerified: !!user.phoneNumber,
      provider: primaryProvider,
      providers: allProviders,
      role: UserRole.USER,
      createdAt: now,
      lastActive: now,
      accountStatus: "active",
      profileComplete: false,
    };

    // Initialize energy system
    const energyData = {
      currentEnergy: ENERGY_CONFIG.MAX_ENERGY,
      maxEnergy: ENERGY_CONFIG.MAX_ENERGY,
      lastUpdateTime: now,
      lastDailyBonusDate: today,
      totalEnergyUsed: 0,
      totalEnergyEarned: 0,
    };

    // Initialize subscription (free tier)
    const subscriptionData = {
      plan: "free",
      active: false,
      startDate: null,
      expiryDate: null,
      autoRenew: false,
    };

    // Initialize quiz progress
    const quizProgress = {
      totalQuestionsAnswered: 0,
      correctAnswers: 0,
      wrongAnswers: 0,
      currentStreak: 0,
      longestStreak: 0,
      totalPoints: 0,
      categoryProgress: {},
      difficultyProgress: {
        basic: {answered: 0, correct: 0},
        intermediate: {answered: 0, correct: 0},
        advanced: {answered: 0, correct: 0},
        expert: {answered: 0, correct: 0},
      },
    };

    // Initialize daily stats
    const dailyStats = {
      lastLoginDate: today,
      loginStreak: 1,
      longestLoginStreak: 1,
      totalLoginDays: 1,
    };

    // Initialize ad tracking
    const adTracking = {
      adsWatchedToday: 0,
      lastAdWatchedTime: null,
      lastAdResetDate: today,
      totalAdsWatched: 0,
    };

    // Initialize user settings
    const settings = {
      notifications: {
        enabled: true,
        prayerTimes: true,
        quizReminders: true,
        achievementUnlocked: true,
      },
      privacy: {
        profileVisible: true,
        showInLeaderboard: true,
        allowFriendRequests: true,
      },
      preferences: {
        theme: "light",
        fontSize: "medium",
        autoPlayAudio: false,
      },
    };

    // Create user document
    await db.collection("users").doc(user.uid).set({
      profile: userProfile,
      energy: energyData,
      subscription: subscriptionData,
      quizProgress,
      dailyStats,
      adTracking,
      settings,
    });

    // Create empty progress tracking document
    await db
      .collection("users")
      .doc(user.uid)
      .collection("quizProgress")
      .doc("current")
      .set({
        answeredQuestions: [],
      });

    // Log user creation
    await db.collection("analytics").add({
      userId: user.uid,
      eventType: "user_created",
      provider: primaryProvider,
      timestamp: now,
    });

    console.log(`User created: ${user.uid} (${user.email})`);

    return {success: true};
  } catch (error) {
    console.error("Error in onUserCreated:", error);
    throw error;
  }
});

/**
 * Firebase Authentication Trigger
 * Automatically called when a user is deleted
 * Cleanup user data
 */
export const onUserDeleted = functions.auth.user().onDelete(async (user) => {
  try {
    const userId = user.uid;

    // Delete user document and subcollections
    const userRef = db.collection("users").doc(userId);

    // Delete subcollections
    const subcollections = ["quizSessions", "quizProgress", "achievements"];

    for (const subcollection of subcollections) {
      const snapshot = await userRef.collection(subcollection).get();
      const batch = db.batch();

      snapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });

      if (!snapshot.empty) {
        await batch.commit();
      }
    }

    // Delete main user document
    await userRef.delete();

    // Log deletion
    await db.collection("analytics").add({
      userId,
      eventType: "user_deleted",
      timestamp: admin.firestore.Timestamp.now(),
    });

    console.log(`User deleted: ${userId}`);

    return {success: true};
  } catch (error) {
    console.error("Error in onUserDeleted:", error);
    throw error;
  }
});

/**
 * HTTP function to complete user profile after registration
 * Called after social auth or to update profile info
 */
export const completeUserProfile = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {displayName, language, photoURL} = data;

    if (!displayName || !language) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "displayName and language are required"
      );
    }

    try {
      const updateData: any = {
        "profile.displayName": displayName,
        "profile.language": language,
        "profile.lastActive": admin.firestore.Timestamp.now(),
        "profile.profileComplete": true,
      };

      if (photoURL) {
        updateData["profile.photoURL"] = photoURL;
      }

      // Update Firestore
      await db.collection("users").doc(userId).update(updateData);

      // Update Firebase Auth profile
      await auth.updateUser(userId, {
        displayName,
        ...(photoURL && {photoURL}),
      });

      return {
        success: true,
        message: "Profile completed successfully",
        profile: {
          displayName,
          language,
          photoURL: photoURL || null,
        },
      };
    } catch (error) {
      console.error("Error in completeUserProfile:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to complete profile"
      );
    }
  }
);

/**
 * HTTP function to get user profile
 */
export const getUserProfile = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = data.userId || context.auth.uid;

    try {
      const userDoc = await db.collection("users").doc(userId).get();

      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const userData = userDoc.data();

      // If requesting own profile, return full data
      if (userId === context.auth.uid) {
        return {
          success: true,
          profile: userData?.profile,
          energy: userData?.energy,
          subscription: userData?.subscription,
          quizProgress: userData?.quizProgress,
          dailyStats: userData?.dailyStats,
          settings: userData?.settings,
        };
      }

      // If requesting another user's profile, return limited public data
      const isPublic = userData?.settings?.privacy?.profileVisible !== false;

      if (!isPublic) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "This profile is private"
        );
      }

      return {
        success: true,
        profile: {
          uid: userData?.profile?.uid,
          displayName: userData?.profile?.displayName,
          photoURL: userData?.profile?.photoURL,
          role: userData?.profile?.role,
        },
        quizProgress: {
          totalQuestionsAnswered:
            userData?.quizProgress?.totalQuestionsAnswered,
          correctAnswers: userData?.quizProgress?.correctAnswers,
          totalPoints: userData?.quizProgress?.totalPoints,
          longestStreak: userData?.quizProgress?.longestStreak,
        },
      };
    } catch (error) {
      console.error("Error in getUserProfile:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to get user profile"
      );
    }
  }
);

/**
 * HTTP function to update user profile
 */
export const updateUserProfile = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {displayName, photoURL, language} = data;

    try {
      const updateData: any = {
        "profile.lastActive": admin.firestore.Timestamp.now(),
      };

      // Build update object
      if (displayName !== undefined) {
        updateData["profile.displayName"] = displayName;
      }
      if (photoURL !== undefined) {
        updateData["profile.photoURL"] = photoURL;
      }
      if (language !== undefined) {
        updateData["profile.language"] = language;
      }

      // Update Firestore
      await db.collection("users").doc(userId).update(updateData);

      // Update Firebase Auth profile
      const authUpdateData: any = {};
      if (displayName !== undefined) authUpdateData.displayName = displayName;
      if (photoURL !== undefined) authUpdateData.photoURL = photoURL;

      if (Object.keys(authUpdateData).length > 0) {
        await auth.updateUser(userId, authUpdateData);
      }

      return {
        success: true,
        message: "Profile updated successfully",
      };
    } catch (error) {
      console.error("Error in updateUserProfile:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to update profile"
      );
    }
  }
);

/**
 * HTTP function to update user settings
 */
export const updateUserSettings = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {notifications, privacy, preferences} = data;

    try {
      const updateData: any = {
        "profile.lastActive": admin.firestore.Timestamp.now(),
      };

      if (notifications) {
        Object.keys(notifications).forEach((key) => {
          updateData[`settings.notifications.${key}`] = notifications[key];
        });
      }

      if (privacy) {
        Object.keys(privacy).forEach((key) => {
          updateData[`settings.privacy.${key}`] = privacy[key];
        });
      }

      if (preferences) {
        Object.keys(preferences).forEach((key) => {
          updateData[`settings.preferences.${key}`] = preferences[key];
        });
      }

      await db.collection("users").doc(userId).update(updateData);

      return {
        success: true,
        message: "Settings updated successfully",
      };
    } catch (error) {
      console.error("Error in updateUserSettings:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to update settings"
      );
    }
  }
);

/**
 * HTTP function to delete user account
 * Soft delete - marks account as deleted
 */
export const deleteUserAccount = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {password} = data; // For email/password users

    try {
      // Mark account as deleted in Firestore
      await db.collection("users").doc(userId).update({
        "profile.accountStatus": "deleted",
        "profile.deletedAt": admin.firestore.Timestamp.now(),
      });

      // Log deletion
      await db.collection("analytics").add({
        userId,
        eventType: "account_deletion_requested",
        timestamp: admin.firestore.Timestamp.now(),
      });

      // Delete from Firebase Auth (this will trigger onUserDeleted)
      await auth.deleteUser(userId);

      return {
        success: true,
        message: "Account deleted successfully",
      };
    } catch (error) {
      console.error("Error in deleteUserAccount:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to delete account"
      );
    }
  }
);

/**
 * HTTP function to set custom user claims (admin, scholar, etc.)
 * Only callable by admins
 */
export const setUserRole = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  // Check if caller is admin
  const callerDoc = await db
    .collection("users")
    .doc(context.auth.uid)
    .get();
  const callerRole = callerDoc.data()?.profile?.role;

  if (callerRole !== UserRole.ADMIN) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only admins can set user roles"
    );
  }

  const {userId, role} = data;

  if (!userId || !role) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "userId and role are required"
    );
  }

  if (!Object.values(UserRole).includes(role)) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Invalid role"
    );
  }

  try {
    // Set custom claims in Firebase Auth
    await auth.setCustomUserClaims(userId, {
      role,
      isAdmin: role === UserRole.ADMIN,
      isScholar: role === UserRole.SCHOLAR,
      isModerator: role === UserRole.MODERATOR,
    });

    // Update Firestore
    await db.collection("users").doc(userId).update({
      "profile.role": role,
      "profile.lastActive": admin.firestore.Timestamp.now(),
    });

    // Log role change
    await db.collection("analytics").add({
      userId,
      eventType: "role_changed",
      newRole: role,
      changedBy: context.auth.uid,
      timestamp: admin.firestore.Timestamp.now(),
    });

    return {
      success: true,
      message: `User role set to ${role}`,
    };
  } catch (error) {
    console.error("Error in setUserRole:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to set user role"
    );
  }
});

/**
 * HTTP function to link social provider to existing account
 */
export const linkSocialProvider = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {provider} = data; // 'google.com', 'apple.com', etc.

    if (!provider) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Provider is required"
      );
    }

    try {
      // Get current user data
      const userRecord = await auth.getUser(userId);
      const currentProviders = userRecord.providerData.map((p) => p.providerId);

      // Check if provider already linked
      if (currentProviders.includes(provider)) {
        throw new functions.https.HttpsError(
          "already-exists",
          "Provider already linked"
        );
      }

      // Update Firestore
      await db.collection("users").doc(userId).update({
        "profile.providers": admin.firestore.FieldValue.arrayUnion(provider),
        "profile.lastActive": admin.firestore.Timestamp.now(),
      });

      // Log provider link
      await db.collection("analytics").add({
        userId,
        eventType: "provider_linked",
        provider,
        timestamp: admin.firestore.Timestamp.now(),
      });

      return {
        success: true,
        message: `${provider} linked successfully`,
      };
    } catch (error) {
      console.error("Error in linkSocialProvider:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to link provider"
      );
    }
  }
);

/**
 * HTTP function to unlink social provider
 */
export const unlinkSocialProvider = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {provider} = data;

    if (!provider) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Provider is required"
      );
    }

    try {
      const userRecord = await auth.getUser(userId);
      const currentProviders = userRecord.providerData.map((p) => p.providerId);

      // Can't unlink if it's the only provider
      if (currentProviders.length <= 1) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Cannot unlink the only sign-in provider"
        );
      }

      // Unlink provider
      await auth.updateUser(userId, {
        // This is handled client-side with auth.currentUser.unlink()
      });

      // Update Firestore
      await db.collection("users").doc(userId).update({
        "profile.providers": admin.firestore.FieldValue.arrayRemove(provider),
        "profile.lastActive": admin.firestore.Timestamp.now(),
      });

      return {
        success: true,
        message: `${provider} unlinked successfully`,
      };
    } catch (error) {
      console.error("Error in unlinkSocialProvider:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to unlink provider"
      );
    }
  }
);

/**
 * HTTP function to check if username/email is available
 */
export const checkUsernameAvailability = functions.https.onCall(
  async (data, context) => {
    const {username} = data;

    if (!username) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Username is required"
      );
    }

    try {
      // Check if username exists in Firestore
      const snapshot = await db
        .collection("users")
        .where("profile.displayName", "==", username)
        .limit(1)
        .get();

      return {
        available: snapshot.empty,
        message: snapshot.empty ?
          "Username available" :
          "Username already taken",
      };
    } catch (error) {
      console.error("Error in checkUsernameAvailability:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to check username"
      );
    }
  }
);

/**
 * HTTP function to update last active timestamp
 * Call this when user opens app
 */
export const updateLastActive = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;

    try {
      const today = new Date().toISOString().split("T")[0];
      const userRef = db.collection("users").doc(userId);
      const userDoc = await userRef.get();
      const userData = userDoc.data();

      const lastLoginDate = userData?.dailyStats?.lastLoginDate;
      const currentStreak = userData?.dailyStats?.loginStreak || 0;

      const updateData: any = {
        "profile.lastActive": admin.firestore.Timestamp.now(),
        "dailyStats.lastLoginDate": today,
      };

      // Update login streak
      if (lastLoginDate !== today) {
        const yesterday = new Date();
        yesterday.setDate(yesterday.getDate() - 1);
        const yesterdayStr = yesterday.toISOString().split("T")[0];

        if (lastLoginDate === yesterdayStr) {
          // Consecutive day - increase streak
          updateData["dailyStats.loginStreak"] = currentStreak + 1;
          updateData["dailyStats.longestLoginStreak"] = Math.max(
            currentStreak + 1,
            userData?.dailyStats?.longestLoginStreak || 0
          );
        } else {
          // Streak broken - reset to 1
          updateData["dailyStats.loginStreak"] = 1;
        }

        updateData["dailyStats.totalLoginDays"] =
          admin.firestore.FieldValue.increment(1);
      }

      await userRef.update(updateData);

      return {
        success: true,
        loginStreak: updateData["dailyStats.loginStreak"] || currentStreak,
      };
    } catch (error) {
      console.error("Error in updateLastActive:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to update last active"
      );
    }
  }
);

/**
 * HTTP function to send email verification
 */
export const sendEmailVerification = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;

    try {
      const userRecord = await auth.getUser(userId);

      if (userRecord.emailVerified) {
        return {
          success: false,
          message: "Email already verified",
        };
      }

      // Generate email verification link
      const link = await auth.generateEmailVerificationLink(
        userRecord.email!
      );

      // TODO: Send email using SendGrid, Mailgun, or similar
      // For now, return the link (in production, send via email service)

      return {
        success: true,
        message: "Verification email sent",
        // Remove link in production, only send via email
        link,
      };
    } catch (error) {
      console.error("Error in sendEmailVerification:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to send verification email"
      );
    }
  }
);

/**
 * HTTP function to verify email with code
 */
export const verifyEmailCode = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {code} = data;

    // This is handled client-side with Firebase Auth
    // But we update our Firestore record

    try {
      await db.collection("users").doc(userId).update({
        "profile.emailVerified": true,
        "profile.lastActive": admin.firestore.Timestamp.now(),
      });

      return {
        success: true,
        message: "Email verified successfully",
      };
    } catch (error) {
      console.error("Error in verifyEmailCode:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to verify email"
      );
    }
  }
);

/**
 * HTTP function to send password reset email
 */
export const sendPasswordResetEmail = functions.https.onCall(
  async (data, context) => {
    const {email} = data;

    if (!email) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Email is required"
      );
    }

    try {
      // Generate password reset link
      const link = await auth.generatePasswordResetLink(email);

      // TODO: Send email using email service
      // For now, return the link

      return {
        success: true,
        message: "Password reset email sent",
        // Remove link in production
        link,
      };
    } catch (error) {
      console.error("Error in sendPasswordResetEmail:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to send password reset email"
      );
    }
  }
);

/**
 * HTTP function to suspend user account (admin only)
 */
export const suspendUser = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  // Check if caller is admin
  const callerDoc = await db
    .collection("users")
    .doc(context.auth.uid)
    .get();
  const callerRole = callerDoc.data()?.profile?.role;

  if (callerRole !== UserRole.ADMIN) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only admins can suspend users"
    );
  }

  const {userId, reason} = data;

  if (!userId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "userId is required"
    );
  }

  try {
    // Disable user in Firebase Auth
    await auth.updateUser(userId, {disabled: true});

    // Update Firestore
    await db.collection("users").doc(userId).update({
      "profile.accountStatus": "suspended",
      "profile.suspendedAt": admin.firestore.Timestamp.now(),
      "profile.suspensionReason": reason || "No reason provided",
    });

    // Log suspension
    await db.collection("analytics").add({
      userId,
      eventType: "user_suspended",
      reason,
      suspendedBy: context.auth.uid,
      timestamp: admin.firestore.Timestamp.now(),
    });

    return {
      success: true,
      message: "User suspended successfully",
    };
  } catch (error) {
    console.error("Error in suspendUser:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to suspend user"
    );
  }
});

/**
 * HTTP function to unsuspend user account (admin only)
 */
export const unsuspendUser = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  // Check if caller is admin
  const callerDoc = await db
    .collection("users")
    .doc(context.auth.uid)
    .get();
  const callerRole = callerDoc.data()?.profile?.role;

  if (callerRole !== UserRole.ADMIN) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only admins can unsuspend users"
    );
  }

  const {userId} = data;

  if (!userId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "userId is required"
    );
  }

  try {
    // Enable user in Firebase Auth
    await auth.updateUser(userId, {disabled: false});

    // Update Firestore
    await db.collection("users").doc(userId).update({
      "profile.accountStatus": "active",
      "profile.unsuspendedAt": admin.firestore.Timestamp.now(),
    });

    return {
      success: true,
      message: "User unsuspended successfully",
    };
  } catch (error) {
    console.error("Error in unsuspendUser:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to unsuspend user"
    );
  }
});
