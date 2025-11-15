import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Quiz Functions
 * Handles quiz sessions, questions, challenges, and scoring
 */

// ============================================================================
// QUESTION MANAGEMENT
// ============================================================================

/**
 * Fetch questions for a quiz session
 * Filters by category, difficulty, and randomizes
 */
export const getQuizQuestions = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {
    category,
    difficulty,
    limit = 10,
    excludeIds = [],
    questionType,
  } = data;

  try {
    let query = db.collection("enhanced_questions").where("verified", "==", true);

    // Apply filters
    if (category) {
      query = query.where("category", "==", category);
    }
    if (difficulty) {
      query = query.where("difficulty", "==", difficulty);
    }
    if (questionType) {
      query = query.where("question_type", "==", questionType);
    }

    const snapshot = await query.get();

    // Filter out excluded questions and randomize
    let questions = snapshot.docs
      .filter((doc) => !excludeIds.includes(doc.id))
      .map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

    // Shuffle using Fisher-Yates algorithm
    for (let i = questions.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [questions[i], questions[j]] = [questions[j], questions[i]];
    }

    // Limit to requested count
    questions = questions.slice(0, limit);

    // Remove correct_answer from questions (security)
    const safeQuestions = questions.map((q) => {
      const {correct_answer, ...safeQuestion} = q;
      return safeQuestion;
    });

    return {
      success: true,
      questions: safeQuestions,
      count: safeQuestions.length,
    };
  } catch (error) {
    console.error("Error fetching quiz questions:", error);
    throw new functions.https.HttpsError("internal", "Failed to fetch questions");
  }
});

/**
 * Submit answer and get result with explanation
 */
export const submitAnswer = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {questionId, selectedAnswer, sessionId, timeSpent} = data;

  if (!questionId || !selectedAnswer || !sessionId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields"
    );
  }

  try {
    // Get question with correct answer
    const questionDoc = await db
      .collection("enhanced_questions")
      .doc(questionId)
      .get();

    if (!questionDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Question not found");
    }

    const question = questionDoc.data();
    const isCorrect = selectedAnswer === question!.correct_answer;

    // Get session for streak calculation
    const sessionDoc = await db
      .collection("quiz_sessions")
      .doc(sessionId)
      .get();

    if (!sessionDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Session not found");
    }

    const session = sessionDoc.data();
    const currentStreak = isCorrect ? (session!.current_streak || 0) + 1 : 0;

    // Calculate points with streak bonus and speed bonus
    let pointsEarned = 0;
    if (isCorrect) {
      const basePoints = question!.points || 10;
      const streakBonus = Math.min(currentStreak * 0.1, 1.0); // Max 100% bonus
      const speedBonus = timeSpent && timeSpent < 10 ? 0.2 : 0; // 20% bonus if < 10s

      pointsEarned = Math.round(
        basePoints * (1 + streakBonus + speedBonus)
      );
    }

    // Get user's energy
    const userDoc = await db
      .collection("users")
      .doc(context.auth.uid)
      .get();
    const userData = userDoc.data();
    const currentEnergy = userData?.energy?.current || 0;
    const energyConsumed = 5; // Cost per question
    const energyRemaining = Math.max(0, currentEnergy - energyConsumed);

    // Get book information
    const bookDoc = await db
      .collection("books")
      .doc(question!.source.book_id)
      .get();
    const bookData = bookDoc.data();

    // Prepare result
    const result = {
      isCorrect,
      correctAnswer: question!.correct_answer,
      explanation: question!.explanation_en,
      explanationAr: question!.explanation_ar,
      pointsEarned,
      currentStreak,
      energyConsumed,
      energyRemaining,
      source: {
        bookId: question!.source.book_id,
        paragraphId: question!.source.paragraph_id,
        pageNumber: question!.source.page_number,
        quote: question!.source.exact_quote_ar,
        exactQuoteAr: question!.source.exact_quote_ar,
        bookTitle: bookData?.title_en || "Unknown Book",
        bookTitleAr: bookData?.title_ar,
        bookTitleEn: bookData?.title_en,
      },
      timeSpent,
    };

    // Update session
    const batch = db.batch();

    batch.update(db.collection("quiz_sessions").doc(sessionId), {
      current_streak: currentStreak,
      total_points: admin.firestore.FieldValue.increment(pointsEarned),
      correct_answers: admin.firestore.FieldValue.increment(isCorrect ? 1 : 0),
      wrong_answers: admin.firestore.FieldValue.increment(isCorrect ? 0 : 1),
      questions_answered: admin.firestore.FieldValue.increment(1),
      last_updated: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update user stats
    batch.update(db.collection("users").doc(context.auth.uid), {
      "stats.total_points": admin.firestore.FieldValue.increment(pointsEarned),
      "stats.questions_answered": admin.firestore.FieldValue.increment(1),
      "stats.correct_answers": admin.firestore.FieldValue.increment(
        isCorrect ? 1 : 0
      ),
      "energy.current": energyRemaining,
      last_activity: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Record answer in history
    batch.set(
      db
        .collection("users")
        .doc(context.auth.uid)
        .collection("answer_history")
        .doc(),
      {
        question_id: questionId,
        session_id: sessionId,
        selected_answer: selectedAnswer,
        is_correct: isCorrect,
        points_earned: pointsEarned,
        time_spent: timeSpent || 0,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
      }
    );

    await batch.commit();

    return {
      success: true,
      result,
    };
  } catch (error) {
    console.error("Error submitting answer:", error);
    throw new functions.https.HttpsError("internal", "Failed to submit answer");
  }
});

/**
 * Create a new quiz session
 */
export const createQuizSession = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {category, difficulty, totalQuestions = 10, mode = "solo"} = data;

    try {
      const sessionData = {
        user_id: context.auth.uid,
        category: category || "all",
        difficulty: difficulty || "all",
        total_questions: totalQuestions,
        questions_answered: 0,
        correct_answers: 0,
        wrong_answers: 0,
        total_points: 0,
        current_streak: 0,
        max_streak: 0,
        mode, // solo, challenge, tournament
        status: "active",
        created_at: admin.firestore.FieldValue.serverTimestamp(),
        last_updated: admin.firestore.FieldValue.serverTimestamp(),
      };

      const sessionRef = await db.collection("quiz_sessions").add(sessionData);

      return {
        success: true,
        sessionId: sessionRef.id,
        session: sessionData,
      };
    } catch (error) {
      console.error("Error creating quiz session:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to create quiz session"
      );
    }
  }
);

/**
 * Complete quiz session and get summary
 */
export const completeQuizSession = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {sessionId, durationSeconds} = data;

    if (!sessionId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Session ID is required"
      );
    }

    try {
      const sessionDoc = await db
        .collection("quiz_sessions")
        .doc(sessionId)
        .get();

      if (!sessionDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Session not found");
      }

      const session = sessionDoc.data();

      // Calculate accuracy
      const totalAnswered = session!.questions_answered || 0;
      const correctAnswers = session!.correct_answers || 0;
      const accuracy =
        totalAnswered > 0 ? (correctAnswers / totalAnswered) * 100 : 0;

      // Update session status
      await db.collection("quiz_sessions").doc(sessionId).update({
        status: "completed",
        accuracy,
        duration_seconds: durationSeconds || 0,
        completed_at: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Create summary
      const summary = {
        sessionId,
        totalQuestions: session!.total_questions || 0,
        correctAnswers,
        wrongAnswers: session!.wrong_answers || 0,
        totalPoints: session!.total_points || 0,
        accuracy,
        energyConsumed: totalAnswered * 5,
        durationSeconds: durationSeconds || 0,
        maxStreak: session!.max_streak || session!.current_streak || 0,
      };

      return {
        success: true,
        summary,
      };
    } catch (error) {
      console.error("Error completing quiz session:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to complete quiz session"
      );
    }
  }
);

// ============================================================================
// CHALLENGE MODE
// ============================================================================

/**
 * Find a random opponent for challenge
 */
export const findRandomMatch = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {category, difficulty} = data;

  try {
    // Get user's stats to find similar level
    const userDoc = await db.collection("users").doc(context.auth.uid).get();
    const userData = userDoc.data();
    const userLevel = userData?.level || 1;

    // Find online users with similar level (±3 levels)
    const snapshot = await db
      .collection("users")
      .where("status", "==", "online")
      .where("level", ">=", Math.max(1, userLevel - 3))
      .where("level", "<=", userLevel + 3)
      .limit(20)
      .get();

    // Filter out self and offline users
    const potentialOpponents = snapshot.docs
      .filter((doc) => doc.id !== context.auth!.uid)
      .map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

    if (potentialOpponents.length === 0) {
      // No opponents found, create bot opponent
      return {
        success: true,
        opponent: {
          id: "bot_" + Math.random().toString(36).substr(2, 9),
          name: "AI Scholar",
          nameAr: "الباحث الذكي",
          level: userLevel,
          avatar: "AI",
          isBot: true,
        },
      };
    }

    // Randomly select an opponent
    const opponent =
      potentialOpponents[
        Math.floor(Math.random() * potentialOpponents.length)
      ];

    return {
      success: true,
      opponent: {
        id: opponent.id,
        name: opponent.display_name || opponent.name,
        nameAr: opponent.name_ar,
        level: opponent.level,
        avatar: opponent.avatar,
        wins: opponent.stats?.wins || 0,
        score: opponent.stats?.total_points || 0,
        isBot: false,
      },
    };
  } catch (error) {
    console.error("Error finding random match:", error);
    throw new functions.https.HttpsError("internal", "Failed to find match");
  }
});

/**
 * Create a challenge match
 */
export const createChallenge = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {opponentId, category, difficulty, totalQuestions = 10} = data;

  if (!opponentId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Opponent ID is required"
    );
  }

  try {
    const challengeData = {
      challenger_id: context.auth.uid,
      opponent_id: opponentId,
      category: category || "all",
      difficulty: difficulty || "all",
      total_questions: totalQuestions,
      status: "pending", // pending, active, completed
      challenger_score: 0,
      opponent_score: 0,
      challenger_progress: 0,
      opponent_progress: 0,
      created_at: admin.firestore.FieldValue.serverTimestamp(),
      expires_at: admin.firestore.Timestamp.fromMillis(
        Date.now() + 24 * 60 * 60 * 1000
      ), // 24 hours
    };

    const challengeRef = await db.collection("challenges").add(challengeData);

    // Send notification to opponent (if not bot)
    if (!opponentId.startsWith("bot_")) {
      await db.collection("notifications").add({
        user_id: opponentId,
        type: "challenge_received",
        challenge_id: challengeRef.id,
        from_user_id: context.auth.uid,
        message: "You have received a new challenge!",
        read: false,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    return {
      success: true,
      challengeId: challengeRef.id,
      challenge: challengeData,
    };
  } catch (error) {
    console.error("Error creating challenge:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to create challenge"
    );
  }
});

/**
 * Accept a challenge
 */
export const acceptChallenge = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {challengeId} = data;

  if (!challengeId) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Challenge ID is required"
    );
  }

  try {
    const challengeDoc = await db
      .collection("challenges")
      .doc(challengeId)
      .get();

    if (!challengeDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Challenge not found");
    }

    const challenge = challengeDoc.data();

    if (challenge!.opponent_id !== context.auth.uid) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You are not the opponent of this challenge"
      );
    }

    await db.collection("challenges").doc(challengeId).update({
      status: "active",
      accepted_at: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Notify challenger
    await db.collection("notifications").add({
      user_id: challenge!.challenger_id,
      type: "challenge_accepted",
      challenge_id: challengeId,
      from_user_id: context.auth.uid,
      message: "Your challenge has been accepted!",
      read: false,
      created_at: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      message: "Challenge accepted",
    };
  } catch (error) {
    console.error("Error accepting challenge:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to accept challenge"
    );
  }
});

/**
 * Update challenge progress
 */
export const updateChallengeProgress = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {challengeId, score, progress} = data;

    if (!challengeId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Challenge ID is required"
      );
    }

    try {
      const challengeDoc = await db
        .collection("challenges")
        .doc(challengeId)
        .get();

      if (!challengeDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Challenge not found"
        );
      }

      const challenge = challengeDoc.data();
      const isChallenger = challenge!.challenger_id === context.auth.uid;
      const isOpponent = challenge!.opponent_id === context.auth.uid;

      if (!isChallenger && !isOpponent) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You are not part of this challenge"
        );
      }

      const updateData: any = {};
      if (isChallenger) {
        updateData.challenger_score = score;
        updateData.challenger_progress = progress;
      } else {
        updateData.opponent_score = score;
        updateData.opponent_progress = progress;
      }

      await db.collection("challenges").doc(challengeId).update(updateData);

      return {
        success: true,
        message: "Progress updated",
      };
    } catch (error) {
      console.error("Error updating challenge progress:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to update progress"
      );
    }
  }
);

/**
 * Complete challenge and determine winner
 */
export const completeChallenge = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {challengeId} = data;

    if (!challengeId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Challenge ID is required"
      );
    }

    try {
      const challengeDoc = await db
        .collection("challenges")
        .doc(challengeId)
        .get();

      if (!challengeDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Challenge not found"
        );
      }

      const challenge = challengeDoc.data();
      const challengerScore = challenge!.challenger_score || 0;
      const opponentScore = challenge!.opponent_score || 0;

      let winner = null;
      if (challengerScore > opponentScore) {
        winner = challenge!.challenger_id;
      } else if (opponentScore > challengerScore) {
        winner = challenge!.opponent_id;
      }

      await db.collection("challenges").doc(challengeId).update({
        status: "completed",
        winner_id: winner,
        completed_at: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Update winner stats
      if (winner) {
        await db
          .collection("users")
          .doc(winner)
          .update({
            "stats.wins": admin.firestore.FieldValue.increment(1),
          });

        // Update loser stats
        const loser =
          winner === challenge!.challenger_id
            ? challenge!.opponent_id
            : challenge!.challenger_id;

        if (!loser.startsWith("bot_")) {
          await db
            .collection("users")
            .doc(loser)
            .update({
              "stats.losses": admin.firestore.FieldValue.increment(1),
            });
        }
      }

      return {
        success: true,
        winner,
        challengerScore,
        opponentScore,
      };
    } catch (error) {
      console.error("Error completing challenge:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to complete challenge"
      );
    }
  }
);

// ============================================================================
// BOOK COLLECTION
// ============================================================================

/**
 * Save book to user's collection
 */
export const saveBookToCollection = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {bookId} = data;

    if (!bookId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Book ID is required"
      );
    }

    try {
      // Check if book exists
      const bookDoc = await db.collection("books").doc(bookId).get();

      if (!bookDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Book not found");
      }

      // Add to user's collection
      await db
        .collection("users")
        .doc(context.auth.uid)
        .collection("saved_books")
        .doc(bookId)
        .set({
          book_id: bookId,
          saved_at: admin.firestore.FieldValue.serverTimestamp(),
        });

      return {
        success: true,
        message: "Book saved to collection",
      };
    } catch (error) {
      console.error("Error saving book:", error);
      throw new functions.https.HttpsError("internal", "Failed to save book");
    }
  }
);
