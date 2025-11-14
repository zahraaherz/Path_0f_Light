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

// Export Friends Management Functions
export {
  searchUsers,
  sendFriendRequest,
  acceptFriendRequest,
  rejectFriendRequest,
  removeFriend,
  blockUser,
  getFriendsList,
  getPendingRequests,
} from "./friendsManagement";

// Export Book Reading & Comments Management Functions
export {
  saveReadingProgress,
  markSectionCompleted,
  createBookmark,
  deleteBookmark,
  createComment,
  updateComment,
  deleteComment,
  toggleCommentLike,
  getComments,
  reportParagraph,
  addToCollection,
} from "./bookReadingManagement";
