import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_entry.freezed.dart';
part 'leaderboard_entry.g.dart';

/// Type of leaderboard
enum LeaderboardType {
  points('Points'),
  streak('Streak'),
  accuracy('Accuracy'),
  questions('Questions Answered');

  final String displayName;
  const LeaderboardType(this.displayName);
}

/// Time period for leaderboard
enum LeaderboardPeriod {
  allTime('All Time'),
  monthly('This Month'),
  weekly('This Week');

  final String displayName;
  const LeaderboardPeriod(this.displayName);
}

/// Leaderboard entry representing a user's ranking
@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String uid,
    required String displayName,
    String? photoURL,
    required int rank,
    required int points,
    required int totalQuestionsAnswered,
    required int correctAnswers,
    required int currentStreak,
    required int longestStreak,
    required int loginStreak,
    @Default(0.0) double accuracy,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);

  /// Create from UserProfile
  factory LeaderboardEntry.fromUserProfile(
    Map<String, dynamic> userData,
    int rank,
  ) {
    final quizProgress = userData['quizProgress'] as Map<String, dynamic>? ?? {};
    final dailyStats = userData['dailyStats'] as Map<String, dynamic>? ?? {};

    final totalQuestions = (quizProgress['totalQuestionsAnswered'] as num?)?.toInt() ?? 0;
    final correct = (quizProgress['correctAnswers'] as num?)?.toInt() ?? 0;
    final accuracy = totalQuestions > 0 ? (correct / totalQuestions) * 100 : 0.0;

    return LeaderboardEntry(
      uid: userData['uid'] as String? ?? '',
      displayName: userData['displayName'] as String? ?? 'Unknown User',
      photoURL: userData['photoURL'] as String?,
      rank: rank,
      points: (quizProgress['totalPoints'] as num?)?.toInt() ?? 0,
      totalQuestionsAnswered: totalQuestions,
      correctAnswers: correct,
      currentStreak: (quizProgress['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (quizProgress['longestStreak'] as num?)?.toInt() ?? 0,
      loginStreak: (dailyStats['loginStreak'] as num?)?.toInt() ?? 0,
      accuracy: accuracy,
    );
  }
}

/// Achievement model
@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String iconName,
    required int requiredValue,
    required String category,
    @Default(false) bool isUnlocked,
    int? unlockedAt,
    int? currentProgress,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}
