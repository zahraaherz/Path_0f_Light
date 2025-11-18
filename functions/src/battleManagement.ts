import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

// ==================== TYPES ====================

interface BattleConfig {
  questionCount: number;
  category?: string;
  difficulty?: string;
  language: string;
  timePerQuestion: number;
  energyCost: number;
}

interface BattlePlayer {
  userId: string;
  displayName: string;
  photoURL?: string;
  score: number;
  correctAnswers: number;
  wrongAnswers: number;
  currentStreak: number;
  answeredCount: number;
  isReady: boolean;
  hasFinished: boolean;
  finishedAt?: admin.firestore.Timestamp;
  lastAnswer?: {
    questionId: string;
    answer: string;
    isCorrect: boolean;
    timestamp: admin.firestore.Timestamp;
  };
}

// ==================== MATCHMAKING ====================

/**
 * Join matchmaking queue
 * Automatically pairs with similar skill level opponent
 */
export const joinMatchmaking = functions.https.onCall(
  async (data: {config: BattleConfig}, context) => {
    // Auth check
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const config: BattleConfig = data.config;

    try {
      // Check energy
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();

      if (!userData) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      // Get current energy
      const energyData = userData.energy || {};
      const currentEnergy = energyData.currentEnergy || 0;

      if (currentEnergy < config.energyCost) {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Insufficient energy"
        );
      }

      // Get user rating
      const battleStats = await db
        .collection("users")
        .doc(userId)
        .collection("stats")
        .doc("battles")
        .get();

      const rating = battleStats.exists ? battleStats.data()?.rating || 1000 : 1000;

      // Look for existing match within rating range (±200)
      const matchQuery = await db
        .collection("matchmaking_queue")
        .where("config.questionCount", "==", config.questionCount)
        .where("config.language", "==", config.language)
        .where("userRating", ">=", rating - 200)
        .where("userRating", "<=", rating + 200)
        .orderBy("userRating")
        .orderBy("joinedAt", "asc")
        .limit(1)
        .get();

      if (!matchQuery.empty) {
        // Match found! Create battle
        const matchDoc = matchQuery.docs[0];
        const matchData = matchDoc.data();

        // Remove from queue
        await matchDoc.ref.delete();

        // Create battle
        const battleId = await createBattle(
          matchData.userId,
          matchData.displayName,
          matchData.photoURL,
          userId,
          userData.displayName || "Unknown",
          userData.photoURL,
          config
        );

        return {id: battleId, type: "battle", status: "matched"};
      } else {
        // No match found, add to queue
        const queueDoc = await db.collection("matchmaking_queue").add({
          userId: userId,
          displayName: userData.displayName || "Unknown",
          photoURL: userData.photoURL || null,
          config: config,
          userRating: rating,
          joinedAt: admin.firestore.FieldValue.serverTimestamp(),
          timeoutSeconds: 60,
        });

        // Set timeout to remove from queue after 60 seconds
        setTimeout(async () => {
          const queueCheck = await queueDoc.get();
          if (queueCheck.exists) {
            await queueDoc.delete();
          }
        }, 60000);

        return {id: queueDoc.id, type: "queue", status: "searching"};
      }
    } catch (error: any) {
      console.error("Matchmaking error:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to join matchmaking"
      );
    }
  }
);

/**
 * Leave matchmaking queue
 */
export const leaveMatchmaking = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;

    try {
      // Find and delete user's queue entry
      const queueQuery = await db
        .collection("matchmaking_queue")
        .where("userId", "==", userId)
        .limit(1)
        .get();

      if (!queueQuery.empty) {
        await queueQuery.docs[0].ref.delete();
      }

      return {success: true};
    } catch (error: any) {
      console.error("Leave matchmaking error:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to leave matchmaking"
      );
    }
  }
);

// ==================== BATTLE CREATION ====================

async function createBattle(
  player1Id: string,
  player1Name: string,
  player1Photo: string | undefined,
  player2Id: string,
  player2Name: string,
  player2Photo: string | undefined,
  config: BattleConfig
): Promise<string> {
  // Get random questions for the battle
  const questionsQuery = await db
    .collection("questions")
    .where("verified", "==", true)
    .limit(config.questionCount * 5) // Get more to filter
    .get();

  if (questionsQuery.empty) {
    throw new Error("No questions available");
  }

  // Shuffle and select questions
  const allQuestions = questionsQuery.docs;
  const shuffled = allQuestions.sort(() => 0.5 - Math.random());
  const selectedQuestions = shuffled.slice(0, config.questionCount);
  const questionIds = selectedQuestions.map((doc) => doc.id);

  // Create battle document
  const battleRef = await db.collection("battles").add({
    type: "quick",
    status: "ready",
    player1: {
      userId: player1Id,
      displayName: player1Name,
      photoURL: player1Photo || null,
      score: 0,
      correctAnswers: 0,
      wrongAnswers: 0,
      currentStreak: 0,
      answeredCount: 0,
      isReady: true,
      hasFinished: false,
    },
    player2: {
      userId: player2Id,
      displayName: player2Name,
      photoURL: player2Photo || null,
      score: 0,
      correctAnswers: 0,
      wrongAnswers: 0,
      currentStreak: 0,
      answeredCount: 0,
      isReady: true,
      hasFinished: false,
    },
    config: config,
    questionIds: questionIds,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    startedAt: null,
    completedAt: null,
    winnerId: null,
    isRanked: true,
  });

  // Consume energy from both players
  await consumeEnergyForBattle(player1Id, config.energyCost);
  await consumeEnergyForBattle(player2Id, config.energyCost);

  return battleRef.id;
}

async function consumeEnergyForBattle(
  userId: string,
  energyCost: number
): Promise<void> {
  const userRef = db.collection("users").doc(userId);

  await db.runTransaction(async (transaction) => {
    const userDoc = await transaction.get(userRef);
    const userData = userDoc.data();

    if (!userData) return;

    const energyData = userData.energy || {};
    const currentEnergy = energyData.currentEnergy || 0;

    transaction.update(userRef, {
      "energy.currentEnergy": Math.max(0, currentEnergy - energyCost),
      "energy.lastUpdateTime": admin.firestore.FieldValue.serverTimestamp(),
      "energy.totalUsed": (energyData.totalUsed || 0) + energyCost,
    });
  });
}

// ==================== FRIEND CHALLENGES ====================

/**
 * Send battle challenge to friend
 */
export const sendBattleChallenge = functions.https.onCall(
  async (data: {friendId: string; config: BattleConfig}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {friendId, config} = data;

    try {
      // Check if users are friends
      const friendDoc = await db
        .collection("friends")
        .doc(userId)
        .collection("connections")
        .doc(friendId)
        .get();

      if (!friendDoc.exists || friendDoc.data()?.status !== "accepted") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Users are not friends"
        );
      }

      // Get user data
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();

      if (!userData) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      // Create invitation
      const invitationRef = await db.collection("battle_invitations").add({
        fromUserId: userId,
        fromUserName: userData.displayName || "Unknown",
        fromUserPhoto: userData.photoURL || null,
        toUserId: friendId,
        config: config,
        status: "pending",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        respondedAt: null,
        expirySeconds: 300, // 5 minutes
      });

      // Send notification
      await sendBattleNotification(
        friendId,
        "Battle Challenge",
        `${userData.displayName || "A friend"} challenged you to a battle!`
      );

      return {invitationId: invitationRef.id};
    } catch (error: any) {
      console.error("Send challenge error:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to send challenge"
      );
    }
  }
);

/**
 * Accept battle challenge
 */
export const acceptBattleChallenge = functions.https.onCall(
  async (data: {invitationId: string}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {invitationId} = data;

    try {
      const invitationRef = db.collection("battle_invitations").doc(invitationId);
      const invitationDoc = await invitationRef.get();

      if (!invitationDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Invitation not found"
        );
      }

      const invitationData = invitationDoc.data();

      if (invitationData?.toUserId !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Not your invitation"
        );
      }

      if (invitationData?.status !== "pending") {
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Invitation already responded to"
        );
      }

      // Get user data
      const userDoc = await db.collection("users").doc(userId).get();
      const userData = userDoc.data();

      // Create battle
      const battleId = await createBattle(
        invitationData.fromUserId,
        invitationData.fromUserName,
        invitationData.fromUserPhoto,
        userId,
        userData?.displayName || "Unknown",
        userData?.photoURL,
        invitationData.config
      );

      // Update invitation
      await invitationRef.update({
        status: "accepted",
        respondedAt: admin.firestore.FieldValue.serverTimestamp(),
        battleId: battleId,
      });

      // Notify challenger
      await sendBattleNotification(
        invitationData.fromUserId,
        "Challenge Accepted",
        `${userData?.displayName || "Your friend"} accepted your battle challenge!`
      );

      return {battleId: battleId};
    } catch (error: any) {
      console.error("Accept challenge error:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to accept challenge"
      );
    }
  }
);

/**
 * Reject battle challenge
 */
export const rejectBattleChallenge = functions.https.onCall(
  async (data: {invitationId: string}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {invitationId} = data;

    try {
      const invitationRef = db.collection("battle_invitations").doc(invitationId);
      const invitationDoc = await invitationRef.get();

      if (!invitationDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Invitation not found"
        );
      }

      const invitationData = invitationDoc.data();

      if (invitationData?.toUserId !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Not your invitation"
        );
      }

      await invitationRef.update({
        status: "rejected",
        respondedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      return {success: true};
    } catch (error: any) {
      console.error("Reject challenge error:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to reject challenge"
      );
    }
  }
);

// ==================== BATTLE OPERATIONS ====================

/**
 * Mark player as ready
 */
export const markBattleReady = functions.https.onCall(
  async (data: {battleId: string}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {battleId} = data;

    try {
      const battleRef = db.collection("battles").doc(battleId);
      const battleDoc = await battleRef.get();

      if (!battleDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Battle not found");
      }

      const battleData = battleDoc.data();

      // Determine which player
      const isPlayer1 = battleData?.player1?.userId === userId;
      const isPlayer2 = battleData?.player2?.userId === userId;

      if (!isPlayer1 && !isPlayer2) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Not a battle participant"
        );
      }

      const playerField = isPlayer1 ? "player1" : "player2";

      await battleRef.update({
        [`${playerField}.isReady`]: true,
      });

      // If both ready, start battle
      const updatedDoc = await battleRef.get();
      const updatedData = updatedDoc.data();

      if (updatedData?.player1?.isReady && updatedData?.player2?.isReady) {
        await battleRef.update({
          status: "in_progress",
          startedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      return {success: true};
    } catch (error: any) {
      console.error("Mark ready error:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to mark ready"
      );
    }
  }
);

/**
 * Submit answer in battle
 */
export const submitBattleAnswer = functions.https.onCall(
  async (
    data: {battleId: string; questionId: string; answer: string},
    context
  ) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {battleId, questionId, answer} = data;

    try {
      // Get battle
      const battleRef = db.collection("battles").doc(battleId);
      const battleDoc = await battleRef.get();

      if (!battleDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Battle not found");
      }

      const battleData = battleDoc.data();

      // Verify participant
      const isPlayer1 = battleData?.player1?.userId === userId;
      const isPlayer2 = battleData?.player2?.userId === userId;

      if (!isPlayer1 && !isPlayer2) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Not a battle participant"
        );
      }

      // Get question
      const questionDoc = await db.collection("questions").doc(questionId).get();

      if (!questionDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Question not found"
        );
      }

      const questionData = questionDoc.data();
      const isCorrect = questionData?.correctAnswer === answer;

      // Calculate points
      const basePoints = questionData?.points || 10;
      const playerField = isPlayer1 ? "player1" : "player2";
      const currentPlayer = battleData?.[playerField];
      const currentStreak = isCorrect ? (currentPlayer.currentStreak || 0) + 1 : 0;
      const streakBonus = Math.min(currentStreak * 0.1, 1.0); // Max 100% bonus
      const pointsEarned = isCorrect ?
        Math.round(basePoints * (1 + streakBonus)) : 0;

      // Update battle
      await battleRef.update({
        [`${playerField}.answeredCount`]: (currentPlayer.answeredCount || 0) + 1,
        [`${playerField}.correctAnswers`]: isCorrect ?
          (currentPlayer.correctAnswers || 0) + 1 :
          currentPlayer.correctAnswers || 0,
        [`${playerField}.wrongAnswers`]: !isCorrect ?
          (currentPlayer.wrongAnswers || 0) + 1 :
          currentPlayer.wrongAnswers || 0,
        [`${playerField}.score`]: (currentPlayer.score || 0) + pointsEarned,
        [`${playerField}.currentStreak`]: currentStreak,
        [`${playerField}.lastAnswer`]: {
          questionId: questionId,
          answer: answer,
          isCorrect: isCorrect,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
        },
      });

      return {
        isCorrect: isCorrect,
        pointsEarned: pointsEarned,
        currentStreak: currentStreak,
        correctAnswer: questionData?.correctAnswer,
        explanation: questionData?.explanationEn || "",
      };
    } catch (error: any) {
      console.error("Submit answer error:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to submit answer"
      );
    }
  }
);

/**
 * Complete battle (when player finishes)
 */
export const completeBattle = functions.https.onCall(
  async (data: {battleId: string}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {battleId} = data;

    try {
      const battleRef = db.collection("battles").doc(battleId);

      await db.runTransaction(async (transaction) => {
        const battleDoc = await transaction.get(battleRef);

        if (!battleDoc.exists) {
          throw new functions.https.HttpsError("not-found", "Battle not found");
        }

        const battleData = battleDoc.data();

        const isPlayer1 = battleData?.player1?.userId === userId;
        const isPlayer2 = battleData?.player2?.userId === userId;

        if (!isPlayer1 && !isPlayer2) {
          throw new functions.https.HttpsError(
            "permission-denied",
            "Not a battle participant"
          );
        }

        const playerField = isPlayer1 ? "player1" : "player2";

        // Mark as finished
        transaction.update(battleRef, {
          [`${playerField}.hasFinished`]: true,
          [`${playerField}.finishedAt`]:
            admin.firestore.FieldValue.serverTimestamp(),
        });

        // Check if both finished
        const player1 = battleData?.player1;
        const player2 = battleData?.player2;
        const bothFinished =
          (isPlayer1 || player1?.hasFinished) &&
          (isPlayer2 || player2?.hasFinished);

        if (bothFinished) {
          // Determine winner
          const player1Score = player1?.score || 0;
          const player2Score = player2?.score || 0;

          const winnerId =
            player1Score > player2Score ?
              player1.userId :
              player2Score > player1Score ?
                player2.userId :
                null; // Draw

          transaction.update(battleRef, {
            status: "completed",
            completedAt: admin.firestore.FieldValue.serverTimestamp(),
            winnerId: winnerId,
          });

          // Update stats asynchronously (don't wait)
          setTimeout(() => {
            updateBattleStats(battleId, battleData);
          }, 0);
        }
      });

      // Get updated battle for return
      const updatedBattle = await battleRef.get();
      const battleData = updatedBattle.data();

      return {
        battleId: battleId,
        player1: battleData?.player1,
        player2: battleData?.player2,
        winnerId: battleData?.winnerId,
        player1Score: battleData?.player1?.score || 0,
        player2Score: battleData?.player2?.score || 0,
        scoreDifference: Math.abs(
          (battleData?.player1?.score || 0) - (battleData?.player2?.score || 0)
        ),
        completedAt: battleData?.completedAt,
        durationSeconds: battleData?.startedAt ?
          Math.floor(
            (Date.now() - battleData.startedAt.toMillis()) / 1000
          ) : 0,
      };
    } catch (error: any) {
      console.error("Complete battle error:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to complete battle"
      );
    }
  }
);

/**
 * Leave/abandon battle
 */
export const leaveBattle = functions.https.onCall(
  async (data: {battleId: string}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {battleId} = data;

    try {
      const battleRef = db.collection("battles").doc(battleId);
      const battleDoc = await battleRef.get();

      if (!battleDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Battle not found");
      }

      const battleData = battleDoc.data();

      const isPlayer1 = battleData?.player1?.userId === userId;
      const isPlayer2 = battleData?.player2?.userId === userId;

      if (!isPlayer1 && !isPlayer2) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Not a battle participant"
        );
      }

      // Mark battle as abandoned
      await battleRef.update({
        status: "abandoned",
        completedAt: admin.firestore.FieldValue.serverTimestamp(),
        winnerId: isPlayer1 ? battleData?.player2?.userId : battleData?.player1?.userId,
      });

      return {success: true};
    } catch (error: any) {
      console.error("Leave battle error:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to leave battle"
      );
    }
  }
);

// ==================== TOURNAMENT MANAGEMENT ====================

/**
 * Register for tournament
 */
export const registerForTournament = functions.https.onCall(
  async (data: {tournamentId: string}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {tournamentId} = data;

    try {
      const tournamentRef = db.collection("tournaments").doc(tournamentId);

      await db.runTransaction(async (transaction) => {
        const tournamentDoc = await transaction.get(tournamentRef);

        if (!tournamentDoc.exists) {
          throw new functions.https.HttpsError(
            "not-found",
            "Tournament not found"
          );
        }

        const tournamentData = tournamentDoc.data();

        if (tournamentData?.status !== "registration") {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "Tournament registration is closed"
          );
        }

        const participants = tournamentData?.participants || [];

        if (participants.length >= tournamentData?.maxParticipants) {
          throw new functions.https.HttpsError(
            "failed-precondition",
            "Tournament is full"
          );
        }

        // Check if already registered
        if (participants.some((p: any) => p.userId === userId)) {
          throw new functions.https.HttpsError(
            "already-exists",
            "Already registered"
          );
        }

        // Get user data
        const userDoc = await transaction.get(db.collection("users").doc(userId));
        const userData = userDoc.data();

        // Add participant
        transaction.update(tournamentRef, {
          participants: admin.firestore.FieldValue.arrayUnion({
            userId: userId,
            displayName: userData?.displayName || "Unknown",
            photoURL: userData?.photoURL || null,
            joinedAt: admin.firestore.FieldValue.serverTimestamp(),
            seed: participants.length + 1,
            wins: 0,
            losses: 0,
            totalScore: 0,
            isEliminated: false,
          }),
        });
      });

      return {success: true};
    } catch (error: any) {
      console.error("Register tournament error:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to register for tournament"
      );
    }
  }
);

/**
 * Unregister from tournament
 */
export const unregisterFromTournament = functions.https.onCall(
  async (data: {tournamentId: string}, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {tournamentId} = data;

    try {
      const tournamentRef = db.collection("tournaments").doc(tournamentId);
      const tournamentDoc = await tournamentRef.get();

      if (!tournamentDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Tournament not found"
        );
      }

      const tournamentData = tournamentDoc.data();
      const participants = tournamentData?.participants || [];

      // Find and remove participant
      const updatedParticipants = participants.filter(
        (p: any) => p.userId !== userId
      );

      await tournamentRef.update({
        participants: updatedParticipants,
      });

      return {success: true};
    } catch (error: any) {
      console.error("Unregister tournament error:", error);
      throw new functions.https.HttpsError(
        "internal",
        "Failed to unregister from tournament"
      );
    }
  }
);

// ==================== HELPER FUNCTIONS ====================

async function updateBattleStats(
  battleId: string,
  battleData: any
): Promise<void> {
  try {
    const player1 = battleData.player1;
    const player2 = battleData.player2;
    const winnerId = battleData.winnerId;

    // Update both players' stats
    await Promise.all([
      updatePlayerBattleStats(
        player1.userId,
        player1,
        player2,
        winnerId === player1.userId,
        battleId,
        battleData
      ),
      updatePlayerBattleStats(
        player2.userId,
        player2,
        player1,
        winnerId === player2.userId,
        battleId,
        battleData
      ),
    ]);
  } catch (error) {
    console.error("Error updating battle stats:", error);
  }
}

async function updatePlayerBattleStats(
  userId: string,
  player: any,
  opponent: any,
  isWinner: boolean,
  battleId: string,
  battleData: any
): Promise<void> {
  const statsRef = db
    .collection("users")
    .doc(userId)
    .collection("stats")
    .doc("battles");

  const historyRef = db
    .collection("users")
    .doc(userId)
    .collection("battle_history")
    .doc(battleId);

  await db.runTransaction(async (transaction) => {
    const statsDoc = await transaction.get(statsRef);
    const stats = statsDoc.exists ? statsDoc.data() || {} : {};

    const newTotalBattles = (stats.totalBattles || 0) + 1;
    const newWins = isWinner ? (stats.wins || 0) + 1 : stats.wins || 0;
    const newLosses = !isWinner ? (stats.losses || 0) + 1 : stats.losses || 0;
    const newWinStreak = isWinner ? (stats.winStreak || 0) + 1 : 0;
    const longestWinStreak = Math.max(
      stats.longestWinStreak || 0,
      newWinStreak
    );

    // Simple ELO calculation
    const currentRating = stats.rating || 1000;
    const expectedScore = 1 / (1 + Math.pow(10, (opponent.rating || 1000 - currentRating) / 400));
    const actualScore = isWinner ? 1 : 0;
    const k = 32; // ELO K-factor
    const ratingChange = Math.round(k * (actualScore - expectedScore));
    const newRating = currentRating + ratingChange;

    transaction.set(
      statsRef,
      {
        totalBattles: newTotalBattles,
        wins: newWins,
        losses: newLosses,
        draws: stats.draws || 0,
        winStreak: newWinStreak,
        longestWinStreak: longestWinStreak,
        rating: newRating,
        totalPointsEarned: (stats.totalPointsEarned || 0) + player.score,
        lastBattleAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      {merge: true}
    );

    // Add to history
    transaction.set(historyRef, {
      opponentId: opponent.userId,
      opponentName: opponent.displayName,
      opponentPhoto: opponent.photoURL || null,
      isWinner: isWinner,
      myScore: player.score,
      opponentScore: opponent.score,
      completedAt: battleData.completedAt,
      battleType: battleData.type || "quick",
      pointsEarned: player.score,
      ratingChange: ratingChange,
    });
  });
}

async function sendBattleNotification(
  userId: string,
  title: string,
  body: string
): Promise<void> {
  try {
    const userDoc = await db.collection("users").doc(userId).get();
    const fcmToken = userDoc.data()?.fcmToken;

    if (fcmToken) {
      await admin.messaging().send({
        token: fcmToken,
        notification: {
          title: title,
          body: body,
        },
        data: {
          type: "battle",
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
      });
    }
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}
