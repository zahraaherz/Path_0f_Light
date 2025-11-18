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
  updateUserRole, // Renamed from setUserRole
  linkSocialProvider,
  unlinkAuthProvider, // Renamed from unlinkSocialProvider
  checkUsernameAvailability,
  updateLastActive,
  sendEmailVerification,
  verifyEmailCode,
  sendPasswordResetEmail,
  suspendUser,
  reactivateUser, // Renamed from unsuspendUser
  getUserStats, // NEW utility function
  updateUserLanguage, // NEW utility function
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

// Export RevenueCat Webhook Handler
export {
  revenueCatWebhook,
} from "./revenueCatWebhooks";

// Export Quiz Management Functions (UPDATED for Energy System)
export {
  getQuizQuestions,
  submitQuizAnswer,
  getUserQuizProgress, // Renamed from getQuizProgress
  completeQuizSession as endQuizSession, // Alias for backward compatibility
  getQuestionSource,
  getQuizCategories, // NEW utility function
} from "./quizManagement";

// Export Enhanced Quiz Functions (NEW - Multiple Question Types, Challenges)
export {
  getQuizQuestions as getEnhancedQuestions,
  submitAnswer,
  createQuizSession,
  completeQuizSession as completeEnhancedQuizSession,
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

// Export Questions Management Functions (Quiz System)
export {
  insertQuestionWithId,
  bulkInsertQuestionsFromJSON,
  getQuestions,
  getQuestionById,
  getRandomQuestions,
  verifyQuestion,
  getQuestionStats,
} from "./questionsManagement";

// Export Collection Management Functions (NEW)
export {
  addCollectionItem,
  updateCollectionItem,
  deleteCollectionItem,
  updateCollectionItemAccess,
  addHabitTracker,
  updateHabitProgress,
  resetDailyHabits,
  deleteHabitTracker,
  addChecklistItem,
  toggleChecklistItem,
  deleteChecklistItem,
  cleanupOldChecklists,
} from "./collectionManagement";
