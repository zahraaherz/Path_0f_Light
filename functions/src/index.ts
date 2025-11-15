import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Export User Management & Authentication Functions (NEW)
export {
  onUserCreated,
  onUserDeleted,
  completeUserProfile,
  getUserProfile,
  updateUserProfile,
  updateUserSettings,
  deleteUserAccount,
  setUserRole,
  linkSocialProvider,
  unlinkSocialProvider,
  checkUsernameAvailability,
  updateLastActive,
  sendEmailVerification,
  verifyEmailCode,
  sendPasswordResetEmail,
  suspendUser,
  unsuspendUser,
} from "./userManagement";

// Export Energy System Functions (Cost Optimized)
export {
  getEnergyStatus,
  consumeEnergy,
  rewardQuizCompletion,
  rewardAdWatch,
  updateSubscription,
  checkSubscriptionStatus,
} from "./energySystem";

// Export Quiz Management Functions (UPDATED for Energy System)
export {
  getQuizQuestions,
  submitQuizAnswer,
  getQuizProgress,
  endQuizSession,
  getQuestionSource,
} from "./quizManagement";

// Export Enhanced Quiz Functions (NEW - Multiple Question Types, Challenges)
export {
  getQuizQuestions as getEnhancedQuestions,
  submitAnswer,
  createQuizSession,
  completeQuizSession,
  findRandomMatch,
  createChallenge,
  acceptChallenge,
  updateChallengeProgress,
  completeChallenge,
  saveBookToCollection,
} from "./quizFunctions";

// Export Content Management Functions
export {
  insertBook,
  insertSection,
  insertParagraph,
  bulkInsertParagraphs,
  insertQuestion,
  bulkInsertQuestions,
  verifyContent,
  publishBook,
  searchBooks,
  getBookDetails,
} from "./contentManagement";

// Export Reminder Management Functions
export {
  processReminders,
  processPrayerReminders,
  onReminderWrite,
} from "./reminderManagement";

// Export Notification Service Functions
export {
  registerFCMToken,
  unregisterFCMToken,
  sendTestNotification,
  sendAdminAnnouncement,
  cleanupOldTokens,
  onUserDeleted as onUserDeletedCleanupTokens,
} from "./notificationService";
