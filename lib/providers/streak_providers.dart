import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user/user_profile.dart';
import '../repositories/user_repository.dart';
import 'auth_providers.dart';

/// Daily login result
class DailyLoginResult {
  final int loginStreak;
  final int longestLoginStreak;
  final bool isNewStreak;
  final bool streakIncreased;
  final int energyBonus;

  DailyLoginResult({
    required this.loginStreak,
    required this.longestLoginStreak,
    required this.isNewStreak,
    required this.streakIncreased,
    required this.energyBonus,
  });

  factory DailyLoginResult.fromJson(Map<String, dynamic> json) {
    return DailyLoginResult(
      loginStreak: json['loginStreak'] ?? 0,
      longestLoginStreak: json['longestLoginStreak'] ?? 0,
      isNewStreak: json['isNewStreak'] ?? false,
      streakIncreased: json['streakIncreased'] ?? false,
      energyBonus: json['energyBonus'] ?? 0,
    );
  }
}

/// Quiz streak state
class QuizStreakState {
  final int currentStreak;
  final int longestStreak;
  final int streakMultiplier;
  final bool isHotStreak; // 5+ correct in a row

  QuizStreakState({
    required this.currentStreak,
    required this.longestStreak,
    this.streakMultiplier = 1,
  }) : isHotStreak = currentStreak >= 5;

  double get pointsMultiplier => 1.0 + (currentStreak * 0.1).clamp(0.0, 1.0);
}

/// Provider for daily login tracking
final dailyLoginTrackingProvider = FutureProvider.autoDispose<DailyLoginResult?>((ref) async {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  if (!isAuthenticated) {
    return null;
  }

  try {
    final userRepo = ref.watch(userRepositoryProvider);
    final result = await userRepo.updateDailyLogin();
    return DailyLoginResult.fromJson(result);
  } catch (e) {
    // Silently fail - not critical
    print('Failed to update daily login: $e');
    return null;
  }
});

/// Provider for current login streak
final currentLoginStreakProvider = Provider<int>((ref) {
  final userProfile = ref.watch(currentUserProfileProvider);
  return userProfile.when(
    data: (profile) => profile?.dailyStats.loginStreak ?? 0,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// Provider for longest login streak
final longestLoginStreakProvider = Provider<int>((ref) {
  final userProfile = ref.watch(currentUserProfileProvider);
  return userProfile.when(
    data: (profile) => profile?.dailyStats.longestLoginStreak ?? 0,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// Provider for current quiz streak
final currentQuizStreakProvider = Provider<QuizStreakState>((ref) {
  final userProfile = ref.watch(currentUserProfileProvider);
  return userProfile.when(
    data: (profile) {
      if (profile == null) {
        return QuizStreakState(currentStreak: 0, longestStreak: 0);
      }
      return QuizStreakState(
        currentStreak: profile.quizProgress.currentStreak,
        longestStreak: profile.quizProgress.longestStreak,
      );
    },
    loading: () => QuizStreakState(currentStreak: 0, longestStreak: 0),
    error: (_, __) => QuizStreakState(currentStreak: 0, longestStreak: 0),
  );
});

/// Provider for streak milestones
final streakMilestonesProvider = Provider<List<StreakMilestone>>((ref) {
  final loginStreak = ref.watch(currentLoginStreakProvider);
  final quizStreak = ref.watch(currentQuizStreakProvider);

  return [
    StreakMilestone(
      type: StreakType.login,
      current: loginStreak,
      milestones: [3, 7, 14, 30, 60, 100],
    ),
    StreakMilestone(
      type: StreakType.quiz,
      current: quizStreak.currentStreak,
      milestones: [5, 10, 20, 50, 100],
    ),
  ];
});

/// Streak type enum
enum StreakType {
  login,
  quiz;

  String get displayName {
    switch (this) {
      case StreakType.login:
        return 'Daily Login';
      case StreakType.quiz:
        return 'Quiz Answers';
    }
  }

  String get icon {
    switch (this) {
      case StreakType.login:
        return '📅';
      case StreakType.quiz:
        return '🔥';
    }
  }
}

/// Streak milestone model
class StreakMilestone {
  final StreakType type;
  final int current;
  final List<int> milestones;

  StreakMilestone({
    required this.type,
    required this.current,
    required this.milestones,
  });

  /// Get next milestone
  int? get nextMilestone {
    for (final milestone in milestones) {
      if (current < milestone) {
        return milestone;
      }
    }
    return null;
  }

  /// Get progress to next milestone (0.0 to 1.0)
  double get progressToNext {
    final next = nextMilestone;
    if (next == null) return 1.0;

    // Find previous milestone
    int previous = 0;
    for (final milestone in milestones) {
      if (milestone < next) {
        previous = milestone;
      }
    }

    final range = next - previous;
    final progress = current - previous;
    return (progress / range).clamp(0.0, 1.0);
  }

  /// Check if current is a milestone
  bool get isAtMilestone => milestones.contains(current);

  /// Get achieved milestones
  List<int> get achievedMilestones {
    return milestones.where((m) => current >= m).toList();
  }
}

/// Provider for streak celebration state
class StreakCelebrationNotifier extends StateNotifier<StreakCelebration?> {
  StreakCelebrationNotifier() : super(null);

  void celebrate({
    required StreakType type,
    required int streak,
    required bool isMilestone,
    String? message,
  }) {
    state = StreakCelebration(
      type: type,
      streak: streak,
      isMilestone: isMilestone,
      message: message ?? _getDefaultMessage(type, streak, isMilestone),
      timestamp: DateTime.now(),
    );
  }

  void clear() {
    state = null;
  }

  String _getDefaultMessage(StreakType type, int streak, bool isMilestone) {
    if (isMilestone) {
      return 'Alhamdulillah! You reached a $streak-day ${type.displayName} streak!';
    }
    return '${type.icon} ${type.displayName} streak: $streak!';
  }
}

class StreakCelebration {
  final StreakType type;
  final int streak;
  final bool isMilestone;
  final String message;
  final DateTime timestamp;

  StreakCelebration({
    required this.type,
    required this.streak,
    required this.isMilestone,
    required this.message,
    required this.timestamp,
  });
}

final streakCelebrationProvider = StateNotifierProvider<StreakCelebrationNotifier, StreakCelebration?>(
  (ref) => StreakCelebrationNotifier(),
);
