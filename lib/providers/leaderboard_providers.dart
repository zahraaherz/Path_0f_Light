import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/leaderboard/leaderboard_entry.dart';
import '../repositories/leaderboard_repository.dart';
import 'auth_providers.dart';

/// Provider for LeaderboardRepository
final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository();
});

/// Provider for leaderboard type selection
final selectedLeaderboardTypeProvider =
    StateProvider<LeaderboardType>((ref) => LeaderboardType.points);

/// Provider for top users by points
final topUsersByPointsProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getTopByPoints(limit: 100);
});

/// Provider for top users by streak
final topUsersByStreakProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getTopByStreak(limit: 100);
});

/// Provider for top users by login streak
final topUsersByLoginStreakProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getTopByLoginStreak(limit: 100);
});

/// Provider for top users by questions answered
final topUsersByQuestionsProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getTopByQuestionsAnswered(limit: 100);
});

/// Provider for current leaderboard based on selected type
final currentLeaderboardProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final leaderboardType = ref.watch(selectedLeaderboardTypeProvider);

  switch (leaderboardType) {
    case LeaderboardType.points:
      return ref.watch(topUsersByPointsProvider.future);
    case LeaderboardType.streak:
      return ref.watch(topUsersByStreakProvider.future);
    case LeaderboardType.accuracy:
      // For accuracy, we'll use points as a proxy since we calculate accuracy from the data
      final entries = await ref.watch(topUsersByPointsProvider.future);
      // Sort by accuracy
      entries.sort((a, b) => b.accuracy.compareTo(a.accuracy));
      // Update ranks
      for (var i = 0; i < entries.length; i++) {
        entries[i] = entries[i].copyWith(rank: i + 1);
      }
      return entries;
    case LeaderboardType.questions:
      return ref.watch(topUsersByQuestionsProvider.future);
  }
});

/// Provider for user's rank by points
final userRankByPointsProvider = FutureProvider<int>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return -1;

  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getUserRankByPoints(userId);
});

/// Provider for user's rank by streak
final userRankByStreakProvider = FutureProvider<int>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return -1;

  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getUserRankByStreak(userId);
});

/// Provider for nearby users on leaderboard
final nearbyUsersProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return [];

  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getNearbyUsers(userId, range: 5);
});

/// Provider for user search query
final userSearchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for user search results
final userSearchResultsProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final query = ref.watch(userSearchQueryProvider);
  if (query.isEmpty) return [];

  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.searchUsers(query);
});

/// Provider for user stats summary
final userStatsSummaryProvider = FutureProvider.family<Map<String, dynamic>, String>(
  (ref, uid) async {
    final repository = ref.watch(leaderboardRepositoryProvider);
    return await repository.getUserStatsSummary(uid);
  },
);

/// Provider for comparing two users
final userComparisonProvider = FutureProvider.family<Map<String, dynamic>, List<String>>(
  (ref, userIds) async {
    if (userIds.length != 2) {
      throw Exception('Need exactly 2 user IDs for comparison');
    }

    final repository = ref.watch(leaderboardRepositoryProvider);
    return await repository.compareUsers(userIds[0], userIds[1]);
  },
);

/// Provider for current user's stats summary
final currentUserStatsSummaryProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return {};

  final repository = ref.watch(leaderboardRepositoryProvider);
  return await repository.getUserStatsSummary(userId);
});
