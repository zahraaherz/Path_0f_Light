import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/leaderboard/leaderboard_entry.dart';

/// Exception class for leaderboard repository errors
class LeaderboardRepositoryException implements Exception {
  final String message;
  final String code;

  LeaderboardRepositoryException(this.message, this.code);

  @override
  String toString() => message;
}

/// Repository for managing leaderboard data
class LeaderboardRepository {
  final FirebaseFirestore _firestore;

  LeaderboardRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Get top users by points
  Future<List<LeaderboardEntry>> getTopByPoints({
    int limit = 100,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('settings.privacy.showInLeaderboard', isEqualTo: true)
          .where('accountStatus', isEqualTo: 'active')
          .orderBy('quizProgress.totalPoints', descending: true)
          .limit(limit)
          .get();

      return _processLeaderboardEntries(snapshot.docs);
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to fetch leaderboard by points: ${e.toString()}',
        'fetch-points-failed',
      );
    }
  }

  /// Get top users by streak
  Future<List<LeaderboardEntry>> getTopByStreak({
    int limit = 100,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('settings.privacy.showInLeaderboard', isEqualTo: true)
          .where('accountStatus', isEqualTo: 'active')
          .orderBy('quizProgress.currentStreak', descending: true)
          .limit(limit)
          .get();

      return _processLeaderboardEntries(snapshot.docs);
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to fetch leaderboard by streak: ${e.toString()}',
        'fetch-streak-failed',
      );
    }
  }

  /// Get top users by login streak
  Future<List<LeaderboardEntry>> getTopByLoginStreak({
    int limit = 100,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('settings.privacy.showInLeaderboard', isEqualTo: true)
          .where('accountStatus', isEqualTo: 'active')
          .orderBy('dailyStats.loginStreak', descending: true)
          .limit(limit)
          .get();

      return _processLeaderboardEntries(snapshot.docs);
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to fetch leaderboard by login streak: ${e.toString()}',
        'fetch-login-streak-failed',
      );
    }
  }

  /// Get top users by total questions answered
  Future<List<LeaderboardEntry>> getTopByQuestionsAnswered({
    int limit = 100,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('settings.privacy.showInLeaderboard', isEqualTo: true)
          .where('accountStatus', isEqualTo: 'active')
          .orderBy('quizProgress.totalQuestionsAnswered', descending: true)
          .limit(limit)
          .get();

      return _processLeaderboardEntries(snapshot.docs);
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to fetch leaderboard by questions: ${e.toString()}',
        'fetch-questions-failed',
      );
    }
  }

  /// Get user's rank by points
  Future<int> getUserRankByPoints(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) return -1;

      final userData = userDoc.data() as Map<String, dynamic>;
      final userPoints = ((userData['quizProgress'] as Map<String, dynamic>?)?['totalPoints'] as num?)?.toInt() ?? 0;

      final higherRankedCount = await _firestore
          .collection('users')
          .where('settings.privacy.showInLeaderboard', isEqualTo: true)
          .where('accountStatus', isEqualTo: 'active')
          .where('quizProgress.totalPoints', isGreaterThan: userPoints)
          .count()
          .get();

      return higherRankedCount.count! + 1;
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to get user rank: ${e.toString()}',
        'get-rank-failed',
      );
    }
  }

  /// Get user's rank by streak
  Future<int> getUserRankByStreak(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) return -1;

      final userData = userDoc.data() as Map<String, dynamic>;
      final userStreak = ((userData['quizProgress'] as Map<String, dynamic>?)?['currentStreak'] as num?)?.toInt() ?? 0;

      final higherRankedCount = await _firestore
          .collection('users')
          .where('settings.privacy.showInLeaderboard', isEqualTo: true)
          .where('accountStatus', isEqualTo: 'active')
          .where('quizProgress.currentStreak', isGreaterThan: userStreak)
          .count()
          .get();

      return higherRankedCount.count! + 1;
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to get user streak rank: ${e.toString()}',
        'get-streak-rank-failed',
      );
    }
  }

  /// Get nearby users on leaderboard (users ranked close to the current user)
  Future<List<LeaderboardEntry>> getNearbyUsers(
    String uid, {
    int range = 5,
  }) async {
    try {
      final userRank = await getUserRankByPoints(uid);
      if (userRank == -1) return [];

      final startRank = (userRank - range).clamp(1, double.infinity).toInt();
      final endRank = userRank + range;

      final allUsers = await getTopByPoints(limit: endRank);

      return allUsers
          .where((entry) => entry.rank >= startRank && entry.rank <= endRank)
          .toList();
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to fetch nearby users: ${e.toString()}',
        'fetch-nearby-failed',
      );
    }
  }

  /// Search users by display name
  Future<List<LeaderboardEntry>> searchUsers(String query) async {
    try {
      if (query.isEmpty) return [];

      final snapshot = await _firestore
          .collection('users')
          .where('settings.privacy.showInLeaderboard', isEqualTo: true)
          .where('accountStatus', isEqualTo: 'active')
          .where('displayName', isGreaterThanOrEqualTo: query)
          .where('displayName', isLessThan: query + 'z')
          .limit(20)
          .get();

      return _processLeaderboardEntries(snapshot.docs);
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to search users: ${e.toString()}',
        'search-users-failed',
      );
    }
  }

  /// Compare two users
  Future<Map<String, dynamic>> compareUsers(
    String userId1,
    String userId2,
  ) async {
    try {
      final user1Doc = await _firestore.collection('users').doc(userId1).get();
      final user2Doc = await _firestore.collection('users').doc(userId2).get();

      if (!user1Doc.exists || !user2Doc.exists) {
        throw LeaderboardRepositoryException(
          'One or both users not found',
          'users-not-found',
        );
      }

      final user1Data = user1Doc.data() as Map<String, dynamic>;
      final user2Data = user2Doc.data() as Map<String, dynamic>;

      final user1Quiz = user1Data['quizProgress'] as Map<String, dynamic>? ?? {};
      final user2Quiz = user2Data['quizProgress'] as Map<String, dynamic>? ?? {};

      return {
        'user1': {
          'uid': userId1,
          'displayName': user1Data['displayName'] ?? 'User 1',
          'photoURL': user1Data['photoURL'],
          'points': (user1Quiz['totalPoints'] as num?)?.toInt() ?? 0,
          'correctAnswers': (user1Quiz['correctAnswers'] as num?)?.toInt() ?? 0,
          'totalQuestions': (user1Quiz['totalQuestionsAnswered'] as num?)?.toInt() ?? 0,
          'currentStreak': (user1Quiz['currentStreak'] as num?)?.toInt() ?? 0,
        },
        'user2': {
          'uid': userId2,
          'displayName': user2Data['displayName'] ?? 'User 2',
          'photoURL': user2Data['photoURL'],
          'points': (user2Quiz['totalPoints'] as num?)?.toInt() ?? 0,
          'correctAnswers': (user2Quiz['correctAnswers'] as num?)?.toInt() ?? 0,
          'totalQuestions': (user2Quiz['totalQuestionsAnswered'] as num?)?.toInt() ?? 0,
          'currentStreak': (user2Quiz['currentStreak'] as num?)?.toInt() ?? 0,
        },
      };
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to compare users: ${e.toString()}',
        'compare-failed',
      );
    }
  }

  /// Get user statistics summary
  Future<Map<String, dynamic>> getUserStatsSummary(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        throw LeaderboardRepositoryException('User not found', 'user-not-found');
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      final quizProgress = userData['quizProgress'] as Map<String, dynamic>? ?? {};
      final dailyStats = userData['dailyStats'] as Map<String, dynamic>? ?? {};
      final energy = userData['energy'] as Map<String, dynamic>? ?? {};

      final totalQuestions = (quizProgress['totalQuestionsAnswered'] as num?)?.toInt() ?? 0;
      final correct = (quizProgress['correctAnswers'] as num?)?.toInt() ?? 0;

      return {
        'points': (quizProgress['totalPoints'] as num?)?.toInt() ?? 0,
        'totalQuestions': totalQuestions,
        'correctAnswers': correct,
        'wrongAnswers': (quizProgress['wrongAnswers'] as num?)?.toInt() ?? 0,
        'accuracy': totalQuestions > 0 ? (correct / totalQuestions) * 100 : 0.0,
        'currentStreak': (quizProgress['currentStreak'] as num?)?.toInt() ?? 0,
        'longestStreak': (quizProgress['longestStreak'] as num?)?.toInt() ?? 0,
        'loginStreak': (dailyStats['loginStreak'] as num?)?.toInt() ?? 0,
        'longestLoginStreak': (dailyStats['longestLoginStreak'] as num?)?.toInt() ?? 0,
        'totalLoginDays': (dailyStats['totalLoginDays'] as num?)?.toInt() ?? 0,
        'currentEnergy': (energy['currentEnergy'] as num?)?.toInt() ?? 0,
        'totalEnergyUsed': (energy['totalEnergyUsed'] as num?)?.toInt() ?? 0,
      };
    } catch (e) {
      throw LeaderboardRepositoryException(
        'Failed to get user stats: ${e.toString()}',
        'get-stats-failed',
      );
    }
  }

  /// Helper method to process leaderboard entries
  List<LeaderboardEntry> _processLeaderboardEntries(
    List<QueryDocumentSnapshot> docs,
  ) {
    final entries = <LeaderboardEntry>[];

    for (var i = 0; i < docs.length; i++) {
      final data = docs[i].data() as Map<String, dynamic>;
      entries.add(LeaderboardEntry.fromUserProfile(data, i + 1));
    }

    return entries;
  }

  /// Dispose resources
  void dispose() {
    // Nothing to dispose for now
  }
}
