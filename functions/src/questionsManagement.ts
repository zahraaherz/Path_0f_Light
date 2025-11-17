import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Interface for Question data
 */
interface QuestionData {
  id: string;
  category: string;
  difficulty: "basic" | "intermediate" | "advanced" | "expert";
  level_evaluation: "easy" | "medium" | "hard" | "very_hard";
  question_ar: string;
  question_en: string;
  options: {
    A: { text_ar: string; text_en: string };
    B: { text_ar: string; text_en: string };
    C: { text_ar: string; text_en: string };
    D: { text_ar: string; text_en: string };
  };
  correct_answer: "A" | "B" | "C" | "D";
  source: {
    paragraph_id: string;
    book_id: string;
    exact_quote_ar: string;
    page_number: number;
  };
  explanation_ar: string;
  explanation_en: string;
  points: number;
  verified: boolean;
  masoom_tags: string[];
  topic_tags: string[];
}

/**
 * Insert a single question into Firestore with specific ID
 * Admin only function
 * Use this when you have a specific question ID (e.g., from generated questions)
 */
export const insertQuestionWithId = functions.https.onCall(
  async (data: QuestionData, context) => {
    // Check authentication
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    // TODO: Add admin role check
    // if (!context.auth.token.admin) {
    //   throw new functions.https.HttpsError(
    //     "permission-denied",
    //     "Only admins can insert questions"
    //   );
    // }

    try {
      const questionRef = db.collection("questions").doc(data.id);

      // Check if question already exists
      const existingQuestion = await questionRef.get();
      if (existingQuestion.exists) {
        throw new functions.https.HttpsError(
          "already-exists",
          `Question ${data.id} already exists`
        );
      }

      // Add timestamps
      const questionWithTimestamps = {
        ...data,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
        created_by: context.auth.uid,
      };

      await questionRef.set(questionWithTimestamps);

      return {
        success: true,
        questionId: data.id,
        message: "Question inserted successfully",
      };
    } catch (error) {
      console.error("Error inserting question:", error);
      throw new functions.https.HttpsError(
        "internal",
        `Failed to insert question: ${error}`
      );
    }
  }
);

/**
 * Bulk insert questions from JSON file format
 * Admin only function
 * Expects data in format: { questions: { "q_0001": {...}, "q_0002": {...} } }
 */
export const bulkInsertQuestionsFromJSON = functions.https.onCall(
  async (data: { questions: Record<string, QuestionData> }, context) => {
    // Check authentication
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    try {
      const questions = data.questions;
      const questionIds = Object.keys(questions);

      console.log(`Bulk inserting ${questionIds.length} questions`);

      let insertedCount = 0;
      let skippedCount = 0;
      const errors: string[] = [];

      // Process in batches of 500 (Firestore limit)
      const batchSize = 500;
      for (let i = 0; i < questionIds.length; i += batchSize) {
        const batch = db.batch();
        const batchIds = questionIds.slice(i, i + batchSize);

        for (const questionId of batchIds) {
          const question = questions[questionId];
          const questionRef = db.collection("questions").doc(questionId);

          // Check if exists
          const existing = await questionRef.get();
          if (existing.exists) {
            skippedCount++;
            continue;
          }

          const questionWithTimestamps = {
            ...question,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
            created_by: context.auth.uid,
          };

          batch.set(questionRef, questionWithTimestamps);
          insertedCount++;
        }

        await batch.commit();
        console.log(`Committed batch ${Math.floor(i / batchSize) + 1}`);
      }

      return {
        success: true,
        inserted: insertedCount,
        skipped: skippedCount,
        total: questionIds.length,
        message: `Inserted ${insertedCount} questions, skipped ${skippedCount} existing`,
      };
    } catch (error) {
      console.error("Error bulk inserting questions:", error);
      throw new functions.https.HttpsError(
        "internal",
        `Failed to bulk insert questions: ${error}`
      );
    }
  }
);

/**
 * Retrieve questions with filters
 * Supports pagination and filtering by category, difficulty, etc.
 */
export const getQuestions = functions.https.onCall(
  async (
    data: {
      category?: string;
      difficulty?: string;
      verified?: boolean;
      masoomTag?: string;
      topicTag?: string;
      limit?: number;
      startAfter?: string;
    },
    context
  ) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    try {
      let query: admin.firestore.Query = db.collection("questions");

      // Apply filters
      if (data.category) {
        query = query.where("category", "==", data.category);
      }

      if (data.difficulty) {
        query = query.where("difficulty", "==", data.difficulty);
      }

      if (data.verified !== undefined) {
        query = query.where("verified", "==", data.verified);
      }

      if (data.masoomTag) {
        query = query.where("masoom_tags", "array-contains", data.masoomTag);
      }

      if (data.topicTag) {
        query = query.where("topic_tags", "array-contains", data.topicTag);
      }

      // Pagination
      const limit = data.limit || 20;
      query = query.limit(limit);

      if (data.startAfter) {
        const startAfterDoc = await db
          .collection("questions")
          .doc(data.startAfter)
          .get();
        if (startAfterDoc.exists) {
          query = query.startAfter(startAfterDoc);
        }
      }

      const snapshot = await query.get();

      const questions = snapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      return {
        success: true,
        questions,
        count: questions.length,
        hasMore: snapshot.docs.length === limit,
      };
    } catch (error) {
      console.error("Error retrieving questions:", error);
      throw new functions.https.HttpsError(
        "internal",
        `Failed to retrieve questions: ${error}`
      );
    }
  }
);

/**
 * Get a single question by ID
 * Returns question without correct answer for quiz use
 */
export const getQuestionById = functions.https.onCall(
  async (data: { questionId: string; includeAnswer?: boolean }, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    try {
      const questionDoc = await db
        .collection("questions")
        .doc(data.questionId)
        .get();

      if (!questionDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Question not found"
        );
      }

      const questionData = questionDoc.data() as QuestionData;

      // If not including answer, remove correct_answer and explanation
      if (!data.includeAnswer) {
        const { correct_answer, explanation_ar, explanation_en, ...safeData } =
          questionData;
        return {
          success: true,
          question: {
            id: questionDoc.id,
            ...safeData,
          },
        };
      }

      return {
        success: true,
        question: {
          id: questionDoc.id,
          ...questionData,
        },
      };
    } catch (error) {
      console.error("Error getting question:", error);
      throw new functions.https.HttpsError(
        "internal",
        `Failed to get question: ${error}`
      );
    }
  }
);

/**
 * Get random questions for quiz
 * Returns questions without answers
 */
export const getRandomQuestions = functions.https.onCall(
  async (
    data: {
      count?: number;
      category?: string;
      difficulty?: string;
      masoomTag?: string;
    },
    context
  ) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    try {
      let query: admin.firestore.Query = db.collection("questions");

      // Only get verified questions
      query = query.where("verified", "==", true);

      // Apply filters
      if (data.category) {
        query = query.where("category", "==", data.category);
      }

      if (data.difficulty) {
        query = query.where("difficulty", "==", data.difficulty);
      }

      if (data.masoomTag) {
        query = query.where("masoom_tags", "array-contains", data.masoomTag);
      }

      // Get more than needed and shuffle
      const count = data.count || 10;
      const snapshot = await query.limit(count * 3).get();

      if (snapshot.empty) {
        throw new functions.https.HttpsError(
          "not-found",
          "No questions found matching criteria"
        );
      }

      // Shuffle and select
      const allQuestions = snapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      const shuffled = allQuestions.sort(() => Math.random() - 0.5);
      const selected = shuffled.slice(0, count);

      // Remove answers from questions
      const questionsWithoutAnswers = selected.map((q: any) => {
        const { correct_answer, explanation_ar, explanation_en, ...safe } = q;
        return safe;
      });

      return {
        success: true,
        questions: questionsWithoutAnswers,
        count: questionsWithoutAnswers.length,
      };
    } catch (error) {
      console.error("Error getting random questions:", error);
      throw new functions.https.HttpsError(
        "internal",
        `Failed to get random questions: ${error}`
      );
    }
  }
);

/**
 * Update question verification status
 * Admin only
 */
export const verifyQuestion = functions.https.onCall(
  async (data: { questionId: string; verified: boolean }, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    try {
      await db
        .collection("questions")
        .doc(data.questionId)
        .update({
          verified: data.verified,
          verified_at: admin.firestore.FieldValue.serverTimestamp(),
          verified_by: context.auth.uid,
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        });

      return {
        success: true,
        message: `Question ${data.verified ? "verified" : "unverified"} successfully`,
      };
    } catch (error) {
      console.error("Error verifying question:", error);
      throw new functions.https.HttpsError(
        "internal",
        `Failed to verify question: ${error}`
      );
    }
  }
);

/**
 * Get question statistics
 */
export const getQuestionStats = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  try {
    const questionsSnapshot = await db.collection("questions").get();

    const stats = {
      total: 0,
      verified: 0,
      unverified: 0,
      byDifficulty: {
        basic: 0,
        intermediate: 0,
        advanced: 0,
        expert: 0,
      },
      byCategory: {} as Record<string, number>,
    };

    questionsSnapshot.docs.forEach((doc) => {
      const q = doc.data();
      stats.total++;

      if (q.verified) {
        stats.verified++;
      } else {
        stats.unverified++;
      }

      if (q.difficulty) {
        stats.byDifficulty[q.difficulty as keyof typeof stats.byDifficulty]++;
      }

      if (q.category) {
        stats.byCategory[q.category] = (stats.byCategory[q.category] || 0) + 1;
      }
    });

    return {
      success: true,
      stats,
    };
  } catch (error) {
    console.error("Error getting stats:", error);
    throw new functions.https.HttpsError(
      "internal",
      `Failed to get stats: ${error}`
    );
  }
});
