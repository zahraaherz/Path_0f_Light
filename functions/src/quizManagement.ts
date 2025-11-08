import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {ENERGY_CONFIG} from "./energySystem";

const db = admin.firestore();

/**
 * Quiz configuration constants
 */
const QUIZ_CONFIG = {
  POINTS: {
    basic: 10,
    intermediate: 15,
    advanced: 20,
    expert: 25,
  },
  QUESTIONS_PER_SESSION: 10,
  STREAK_BONUS_MULTIPLIER: 1.1,
  MAX_STREAK_BONUS: 2.0,
};

/**
 * Interface for question data
 */
interface Question {
  id: string;
  category: string;
  difficulty: "basic" | "intermediate" | "advanced" | "expert";
  question_ar: string;
  question_en: string;
  options: {
    A: {text_ar: string; text_en: string};
    B: {text_ar: string; text_en: string};
    C: {text_ar: string; text_en: string};
    D: {text_ar: string; text_en: string};
  };
  correct_answer: string;
  source: {
    paragraph_id: string;
    book_id: string;
    exact_quote_ar: string;
    page_number: number;
  };
  explanation_ar: string;
  explanation_en: string;
  points: number;
}

/**
 * Interface for user quiz progress
 */
interface QuizProgress {
  totalQuestionsAnswered: number;
  correctAnswers: number;
  wrongAnswers: number;
  currentStreak: number;
  longestStreak: number;
  totalPoints: number;
  categoryProgress: {
    [category: string]: {
      answered: number;
      correct: number;
      points: number;
    };
  };
  difficultyProgress: {
    basic: {answered: number; correct: number};
    intermediate: {answered: number; correct: number};
    advanced: {answered: number; correct: number};
    expert: {answered: number; correct: number};
  };
}

/**
 * HTTP function to get random questions for quiz session
 * Supports filtering by category, difficulty, and language
 * Checks energy availability before starting
 */
export const getQuizQuestions = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {
      category,
      difficulty,
      language = "en",
      count = QUIZ_CONFIG.QUESTIONS_PER_SESSION,
    } = data;

    try {
      // Verify user has enough energy
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();
      const currentEnergy = userData?.energy?.currentEnergy || 0;

      // Calculate total energy needed for the quiz
      const totalEnergyNeeded = count * ENERGY_CONFIG.ENERGY_PER_QUESTION;

      if (currentEnergy < totalEnergyNeeded) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          `Insufficient energy. Need ${totalEnergyNeeded}, have ${currentEnergy}`
        );
      }

      // Build query for questions
      let questionsQuery = db.collection("questions") as any;

      // Only get verified questions
      questionsQuery = questionsQuery.where("verified", "==", true);

      if (category) {
        questionsQuery = questionsQuery.where("category", "==", category);
      }

      if (difficulty) {
        questionsQuery = questionsQuery.where("difficulty", "==", difficulty);
      }

      // Get questions
      const questionsSnapshot = await questionsQuery.limit(count * 3).get();

      if (questionsSnapshot.empty) {
        throw new functions.https.HttpsError(
          "not-found",
          "No questions found matching criteria"
        );
      }

      // Get user's answered questions to avoid repetition
      const userProgressDoc = await db
        .collection("users")
        .doc(userId)
        .collection("quizProgress")
        .doc("current")
        .get();

      const answeredQuestions =
        userProgressDoc.data()?.answeredQuestions || [];

      // Filter out already answered questions and randomly select
      const availableQuestions = questionsSnapshot.docs
        .filter((doc) => !answeredQuestions.includes(doc.id))
        .map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));

      // Randomly shuffle and select required count
      const shuffled = availableQuestions
        .sort(() => Math.random() - 0.5)
        .slice(0, count);

      // Format questions for response (hide correct answer)
      const formattedQuestions = shuffled.map((q) => ({
        id: q.id,
        category: q.category,
        difficulty: q.difficulty,
        question: language === "ar" ? q.question_ar : q.question_en,
        options: {
          A: language === "ar" ? q.options.A.text_ar : q.options.A.text_en,
          B: language === "ar" ? q.options.B.text_ar : q.options.B.text_en,
          C: language === "ar" ? q.options.C.text_ar : q.options.C.text_en,
          D: language === "ar" ? q.options.D.text_ar : q.options.D.text_en,
        },
        points: q.points,
      }));

      // Create a quiz session
      const sessionId = `session_${Date.now()}`;
      await db
        .collection("users")
        .doc(userId)
        .collection("quizSessions")
        .doc(sessionId)
        .set({
          sessionId,
          startTime: admin.firestore.Timestamp.now(),
          questions: shuffled.map((q) => q.id),
          questionsCompleted: 0,
          totalQuestions: formattedQuestions.length,
          category,
          difficulty,
          language,
          status: "active",
          energyConsumed: 0,
          energyNeeded: totalEnergyNeeded,
        });

      return {
        sessionId,
        questions: formattedQuestions,
        totalQuestions: formattedQuestions.length,
        energyPerQuestion: ENERGY_CONFIG.ENERGY_PER_QUESTION,
        totalEnergyNeeded,
      };
    } catch (error) {
      console.error("Error in getQuizQuestions:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to get quiz questions"
      );
    }
  }
);

/**
 * HTTP function to submit and validate a quiz answer
 * Updates user progress, points, streaks
 * Consumes energy per question answered
 */
export const submitQuizAnswer = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {questionId, answer, sessionId, language = "en"} = data;

    if (!questionId || !answer || !sessionId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "questionId, answer, and sessionId are required"
      );
    }

    try {
      const userRef = db.collection("users").doc(userId);

      // Use transaction to ensure atomic updates
      const result = await db.runTransaction(async (transaction) => {
        // Get question data
        const questionDoc = await transaction.get(
          db.collection("questions").doc(questionId)
        );

        if (!questionDoc.exists) {
          throw new functions.https.HttpsError(
            "not-found",
            "Question not found"
          );
        }

        const questionData = questionDoc.data() as Question;
        const isCorrect = answer === questionData.correct_answer;

        // Get user data
        const userDoc = await transaction.get(userRef);
        const userData = userDoc.data();
        const currentProgress = userData?.quizProgress || {};
        const currentEnergy = userData?.energy?.currentEnergy || 0;

        // Check if user has enough energy
        if (currentEnergy < ENERGY_CONFIG.ENERGY_PER_QUESTION) {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "Insufficient energy to answer question"
          );
        }

        // Consume energy
        transaction.update(userRef, {
          "energy.currentEnergy":
            currentEnergy - ENERGY_CONFIG.ENERGY_PER_QUESTION,
          "energy.lastUpdateTime": admin.firestore.Timestamp.now(),
          "energy.totalEnergyUsed":
            admin.firestore.FieldValue.increment(
              ENERGY_CONFIG.ENERGY_PER_QUESTION
            ),
        });

        // Calculate points and streak
        let pointsEarned = 0;
        let newStreak = currentProgress.currentStreak || 0;

        if (isCorrect) {
          newStreak += 1;
          const basePoints =
            QUIZ_CONFIG.POINTS[questionData.difficulty] ||
            QUIZ_CONFIG.POINTS.basic;

          // Apply streak bonus (up to max multiplier)
          const streakMultiplier = Math.min(
            1 + newStreak * 0.1,
            QUIZ_CONFIG.MAX_STREAK_BONUS
          );
          pointsEarned = Math.floor(basePoints * streakMultiplier);
        } else {
          // Reset streak on wrong answer
          newStreak = 0;
        }

        // Update user progress
        const categoryKey = `quizProgress.categoryProgress.${
          questionData.category
        }`;
        const difficultyKey = `quizProgress.difficultyProgress.${
          questionData.difficulty
        }`;

        transaction.update(userRef, {
          "quizProgress.totalQuestionsAnswered":
            admin.firestore.FieldValue.increment(1),
          "quizProgress.correctAnswers":
            admin.firestore.FieldValue.increment(isCorrect ? 1 : 0),
          "quizProgress.wrongAnswers":
            admin.firestore.FieldValue.increment(isCorrect ? 0 : 1),
          "quizProgress.currentStreak": newStreak,
          "quizProgress.longestStreak": Math.max(
            newStreak,
            currentProgress.longestStreak || 0
          ),
          "quizProgress.totalPoints":
            admin.firestore.FieldValue.increment(pointsEarned),
          [`${categoryKey}.answered`]: admin.firestore.FieldValue.increment(1),
          [`${categoryKey}.correct`]:
            admin.firestore.FieldValue.increment(isCorrect ? 1 : 0),
          [`${categoryKey}.points`]:
            admin.firestore.FieldValue.increment(pointsEarned),
          [`${difficultyKey}.answered`]:
            admin.firestore.FieldValue.increment(1),
          [`${difficultyKey}.correct`]:
            admin.firestore.FieldValue.increment(isCorrect ? 1 : 0),
        });

        // Update session
        const sessionRef = userRef.collection("quizSessions").doc(sessionId);
        transaction.update(sessionRef, {
          answers: admin.firestore.FieldValue.arrayUnion({
            questionId,
            userAnswer: answer,
            isCorrect,
            pointsEarned,
            timestamp: admin.firestore.Timestamp.now(),
          }),
          questionsCompleted: admin.firestore.FieldValue.increment(1),
          energyConsumed:
            admin.firestore.FieldValue.increment(
              ENERGY_CONFIG.ENERGY_PER_QUESTION
            ),
        });

        // Add to answered questions list
        transaction.set(
          userRef.collection("quizProgress").doc("current"),
          {
            answeredQuestions:
              admin.firestore.FieldValue.arrayUnion(questionId),
          },
          {merge: true}
        );

        // Return result with explanation
        return {
          isCorrect,
          correctAnswer: questionData.correct_answer,
          explanation:
            language === "ar" ?
              questionData.explanation_ar :
              questionData.explanation_en,
          pointsEarned,
          currentStreak: newStreak,
          energyConsumed: ENERGY_CONFIG.ENERGY_PER_QUESTION,
          energyRemaining: currentEnergy - ENERGY_CONFIG.ENERGY_PER_QUESTION,
          source: {
            bookId: questionData.source.book_id,
            paragraphId: questionData.source.paragraph_id,
            pageNumber: questionData.source.page_number,
            quote:
              language === "ar" ?
                questionData.source.exact_quote_ar :
                questionData.source.exact_quote_ar, // Fallback to Arabic
          },
        };
      });

      return result;
    } catch (error) {
      console.error("Error in submitQuizAnswer:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to submit answer"
      );
    }
  }
);

/**
 * HTTP function to get user's quiz progress and statistics
 */
export const getQuizProgress = functions.https.onCall(
  async (data, context) => {
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
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      const userData = userDoc.data();
      const quizProgress = userData?.quizProgress as QuizProgress;

      if (!quizProgress) {
        // Initialize progress if it doesn't exist
        const initialProgress: QuizProgress = {
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

        await db.collection("users").doc(userId).update({
          quizProgress: initialProgress,
        });

        return initialProgress;
      }

      // Calculate accuracy percentages
      const accuracy =
        quizProgress.totalQuestionsAnswered > 0 ?
          (quizProgress.correctAnswers /
            quizProgress.totalQuestionsAnswered) *
            100 :
          0;

      return {
        ...quizProgress,
        accuracy: accuracy.toFixed(2),
      };
    } catch (error) {
      console.error("Error in getQuizProgress:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to get quiz progress"
      );
    }
  }
);

/**
 * HTTP function to end a quiz session and get summary
 * Awards completion bonus energy
 */
export const endQuizSession = functions.https.onCall(async (data, context) => {
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
      "sessionId is required"
    );
  }

  try {
    const sessionRef = db
      .collection("users")
      .doc(userId)
      .collection("quizSessions")
      .doc(sessionId);

    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) {
      throw new functions.https.HttpsError(
        "not-found",
        "Quiz session not found"
      );
    }

    const sessionData = sessionDoc.data();
    const answers = sessionData?.answers || [];

    // Calculate session summary
    const correctCount = answers.filter((a: any) => a.isCorrect).length;
    const totalPoints = answers.reduce(
      (sum: number, a: any) => sum + (a.pointsEarned || 0),
      0
    );

    const summary = {
      sessionId,
      totalQuestions: sessionData?.totalQuestions || answers.length,
      questionsCompleted: answers.length,
      correctAnswers: correctCount,
      wrongAnswers: answers.length - correctCount,
      totalPoints,
      accuracy:
        answers.length > 0 ?
          ((correctCount / answers.length) * 100).toFixed(2) :
          0,
      duration:
        admin.firestore.Timestamp.now().toMillis() -
        sessionData.startTime.toMillis(),
      energyConsumed: sessionData?.energyConsumed || 0,
    };

    // Update session status
    await sessionRef.update({
      status: "completed",
      endTime: admin.firestore.Timestamp.now(),
      summary,
    });

    return summary;
  } catch (error) {
    console.error("Error in endQuizSession:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to end quiz session"
    );
  }
});

/**
 * HTTP function to get question source details
 * Shows the exact paragraph from the book
 */
export const getQuestionSource = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {questionId, language = "en"} = data;

    if (!questionId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "questionId is required"
      );
    }

    try {
      const questionDoc = await db
        .collection("questions")
        .doc(questionId)
        .get();

      if (!questionDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Question not found"
        );
      }

      const questionData = questionDoc.data();
      const source = questionData?.source;

      // Get the paragraph content
      const paragraphDoc = await db
        .collection("paragraphs")
        .doc(source.paragraph_id)
        .get();

      if (!paragraphDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Source paragraph not found"
        );
      }

      const paragraphData = paragraphDoc.data();

      // Get book information
      const bookDoc = await db.collection("books").doc(source.book_id).get();
      const bookData = bookDoc.data();

      return {
        book: {
          id: source.book_id,
          title:
            language === "ar" ? bookData?.title_ar : bookData?.title_en,
          author:
            language === "ar" ? bookData?.author_ar : bookData?.author_en,
        },
        paragraph: {
          content:
            language === "ar" ?
              paragraphData?.content.text_ar :
              paragraphData?.content.text_en,
          pageNumber: source.page_number,
          sectionTitle:
            language === "ar" ?
              paragraphData?.section_title_ar :
              paragraphData?.section_title_en || "",
        },
        exactQuote: source.exact_quote_ar,
      };
    } catch (error) {
      console.error("Error in getQuestionSource:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to get question source"
      );
    }
  }
);
