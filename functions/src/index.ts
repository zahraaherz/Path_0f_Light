import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Export Energy System Functions (NEW - Cost Optimized)
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

// Export Content Management Functions (NEW)
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
