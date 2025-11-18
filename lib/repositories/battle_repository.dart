import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/battle/battle_models.dart';

/// Exception class for battle repository errors
class BattleRepositoryException implements Exception {
  final String message;
  final String code;

  BattleRepositoryException(this.message, this.code);

  @override
  String toString() => message;
}

/// Repository for managing battle and tournament operations
class BattleRepository {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final FirebaseAuth _auth;

  BattleRepository({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _functions = functions ?? FirebaseFunctions.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // ==================== MATCHMAKING ====================

  /// Join matchmaking queue
  /// Automatically pairs with similar skill level opponent
  Future<String> joinMatchmaking({
    required BattleConfig config,
  }) async {
    try {
      final callable = _functions.httpsCallable('joinMatchmaking');
      final result = await callable.call({
        'config': config.toJson(),
      });

      // Returns either battleId (if match found) or queueId (if waiting)
      return result.data['id'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw BattleRepositoryException(
        e.message ?? 'Failed to join matchmaking',
        e.code,
      );
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to join matchmaking: ${e.toString()}',
        'join-matchmaking-failed',
      );
    }
  }

  /// Leave matchmaking queue
  Future<void> leaveMatchmaking() async {
    try {
      final callable = _functions.httpsCallable('leaveMatchmaking');
      await callable.call();
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to leave matchmaking: ${e.toString()}',
        'leave-matchmaking-failed',
      );
    }
  }

  /// Check matchmaking status
  Stream<Map<String, dynamic>> watchMatchmaking(String queueId) {
    return _firestore
        .collection('matchmaking_queue')
        .doc(queueId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        return {'status': 'not_found'};
      }
      return {...doc.data()!, 'id': doc.id};
    });
  }

  // ==================== FRIEND CHALLENGES ====================

  /// Send battle challenge to friend
  Future<String> sendBattleChallenge({
    required String friendId,
    required BattleConfig config,
  }) async {
    try {
      final callable = _functions.httpsCallable('sendBattleChallenge');
      final result = await callable.call({
        'friendId': friendId,
        'config': config.toJson(),
      });

      return result.data['invitationId'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw BattleRepositoryException(
        e.message ?? 'Failed to send battle challenge',
        e.code,
      );
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to send battle challenge: ${e.toString()}',
        'send-challenge-failed',
      );
    }
  }

  /// Accept battle challenge
  Future<String> acceptBattleChallenge(String invitationId) async {
    try {
      final callable = _functions.httpsCallable('acceptBattleChallenge');
      final result = await callable.call({
        'invitationId': invitationId,
      });

      return result.data['battleId'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw BattleRepositoryException(
        e.message ?? 'Failed to accept battle challenge',
        e.code,
      );
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to accept battle challenge: ${e.toString()}',
        'accept-challenge-failed',
      );
    }
  }

  /// Reject battle challenge
  Future<void> rejectBattleChallenge(String invitationId) async {
    try {
      final callable = _functions.httpsCallable('rejectBattleChallenge');
      await callable.call({
        'invitationId': invitationId,
      });
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to reject battle challenge: ${e.toString()}',
        'reject-challenge-failed',
      );
    }
  }

  /// Get pending battle invitations for current user
  Stream<List<BattleInvitation>> watchPendingInvitations() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('battle_invitations')
        .where('toUserId', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => BattleInvitation.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    });
  }

  // ==================== BATTLE OPERATIONS ====================

  /// Get battle details
  Future<Battle> getBattle(String battleId) async {
    try {
      final doc = await _firestore.collection('battles').doc(battleId).get();

      if (!doc.exists) {
        throw BattleRepositoryException(
          'Battle not found',
          'battle-not-found',
        );
      }

      return Battle.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      if (e is BattleRepositoryException) rethrow;
      throw BattleRepositoryException(
        'Failed to get battle: ${e.toString()}',
        'get-battle-failed',
      );
    }
  }

  /// Watch battle real-time updates
  Stream<Battle> watchBattle(String battleId) {
    return _firestore
        .collection('battles')
        .doc(battleId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        throw BattleRepositoryException(
          'Battle not found',
          'battle-not-found',
        );
      }
      return Battle.fromJson({...doc.data()!, 'id': doc.id});
    });
  }

  /// Mark player as ready
  Future<void> markReady(String battleId) async {
    try {
      final callable = _functions.httpsCallable('markBattleReady');
      await callable.call({
        'battleId': battleId,
      });
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to mark ready: ${e.toString()}',
        'mark-ready-failed',
      );
    }
  }

  /// Submit answer in battle
  Future<Map<String, dynamic>> submitBattleAnswer({
    required String battleId,
    required String questionId,
    required String answer,
  }) async {
    try {
      final callable = _functions.httpsCallable('submitBattleAnswer');
      final result = await callable.call({
        'battleId': battleId,
        'questionId': questionId,
        'answer': answer,
      });

      return Map<String, dynamic>.from(result.data);
    } on FirebaseFunctionsException catch (e) {
      throw BattleRepositoryException(
        e.message ?? 'Failed to submit answer',
        e.code,
      );
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to submit answer: ${e.toString()}',
        'submit-answer-failed',
      );
    }
  }

  /// Complete battle (when player finishes all questions)
  Future<BattleResult> completeBattle(String battleId) async {
    try {
      final callable = _functions.httpsCallable('completeBattle');
      final result = await callable.call({
        'battleId': battleId,
      });

      return BattleResult.fromJson(Map<String, dynamic>.from(result.data));
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to complete battle: ${e.toString()}',
        'complete-battle-failed',
      );
    }
  }

  /// Leave/abandon battle
  Future<void> leaveBattle(String battleId) async {
    try {
      final callable = _functions.httpsCallable('leaveBattle');
      await callable.call({
        'battleId': battleId,
      });
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to leave battle: ${e.toString()}',
        'leave-battle-failed',
      );
    }
  }

  // ==================== BATTLE STATISTICS ====================

  /// Get user's battle statistics
  Future<BattleStats> getBattleStats() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw BattleRepositoryException(
          'User not authenticated',
          'not-authenticated',
        );
      }

      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('stats')
          .doc('battles')
          .get();

      if (!doc.exists) {
        // Return default stats if none exist
        return const BattleStats();
      }

      return BattleStats.fromJson(doc.data()!);
    } catch (e) {
      if (e is BattleRepositoryException) rethrow;
      throw BattleRepositoryException(
        'Failed to get battle stats: ${e.toString()}',
        'get-stats-failed',
      );
    }
  }

  /// Watch user's battle statistics
  Stream<BattleStats> watchBattleStats() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value(const BattleStats());
    }

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('stats')
        .doc('battles')
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        return const BattleStats();
      }
      return BattleStats.fromJson(doc.data()!);
    });
  }

  /// Get battle history
  Future<List<BattleHistoryEntry>> getBattleHistory({
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw BattleRepositoryException(
          'User not authenticated',
          'not-authenticated',
        );
      }

      Query query = _firestore
          .collection('users')
          .doc(userId)
          .collection('battle_history')
          .orderBy('completedAt', descending: true)
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => BattleHistoryEntry.fromJson({...doc.data() as Map<String, dynamic>, 'battleId': doc.id}))
          .toList();
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to get battle history: ${e.toString()}',
        'get-history-failed',
      );
    }
  }

  /// Watch active battles (for current user)
  Stream<List<Battle>> watchActiveBattles() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]);
    }

    // Query battles where user is player1 or player2 and status is not completed
    return _firestore
        .collection('battles')
        .where('status', whereIn: ['waiting', 'ready', 'in_progress'])
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Battle.fromJson({...doc.data(), 'id': doc.id}))
          .where((battle) =>
              battle.player1.userId == userId ||
              battle.player2?.userId == userId)
          .toList();
    });
  }

  // ==================== TOURNAMENTS ====================

  /// Get all available tournaments
  Stream<List<Tournament>> watchAvailableTournaments() {
    return _firestore
        .collection('tournaments')
        .where('status', whereIn: ['registration', 'ready', 'in_progress'])
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Tournament.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    });
  }

  /// Get tournament details
  Future<Tournament> getTournament(String tournamentId) async {
    try {
      final doc = await _firestore
          .collection('tournaments')
          .doc(tournamentId)
          .get();

      if (!doc.exists) {
        throw BattleRepositoryException(
          'Tournament not found',
          'tournament-not-found',
        );
      }

      return Tournament.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      if (e is BattleRepositoryException) rethrow;
      throw BattleRepositoryException(
        'Failed to get tournament: ${e.toString()}',
        'get-tournament-failed',
      );
    }
  }

  /// Watch tournament real-time updates
  Stream<Tournament> watchTournament(String tournamentId) {
    return _firestore
        .collection('tournaments')
        .doc(tournamentId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        throw BattleRepositoryException(
          'Tournament not found',
          'tournament-not-found',
        );
      }
      return Tournament.fromJson({...doc.data()!, 'id': doc.id});
    });
  }

  /// Register for tournament
  Future<void> registerForTournament(String tournamentId) async {
    try {
      final callable = _functions.httpsCallable('registerForTournament');
      await callable.call({
        'tournamentId': tournamentId,
      });
    } on FirebaseFunctionsException catch (e) {
      throw BattleRepositoryException(
        e.message ?? 'Failed to register for tournament',
        e.code,
      );
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to register for tournament: ${e.toString()}',
        'register-tournament-failed',
      );
    }
  }

  /// Unregister from tournament
  Future<void> unregisterFromTournament(String tournamentId) async {
    try {
      final callable = _functions.httpsCallable('unregisterFromTournament');
      await callable.call({
        'tournamentId': tournamentId,
      });
    } catch (e) {
      throw BattleRepositoryException(
        'Failed to unregister from tournament: ${e.toString()}',
        'unregister-tournament-failed',
      );
    }
  }

  /// Dispose resources
  void dispose() {
    // Nothing to dispose for now
  }
}
