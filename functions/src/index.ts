import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Export Battery System Functions
export {
  scheduledHeartRefill,
  dailyBatteryReset,
  getBatteryStatus,
  consumeHeart,
  restoreHearts,
} from "./batterySystem";

// Export Quiz Management Functions
export {
  getQuizQuestions,
  submitQuizAnswer,
  getQuizProgress,
  endQuizSession,
  getQuestionSource,
} from "./quizManagement";
