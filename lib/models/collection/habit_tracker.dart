import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_tracker.freezed.dart';
part 'habit_tracker.g.dart';

/// Habit tracking for spiritual practices
@freezed
class HabitTracker with _$HabitTracker {
  const factory HabitTracker({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'collection_item_id') required String collectionItemId,

    // Habit details
    required String title,
    @JsonKey(name: 'arabic_title') String? arabicTitle,
    String? description,

    // Goal tracking
    @JsonKey(name: 'target_count') @Default(1) int targetCount, // Times per day/week
    @JsonKey(name: 'current_count') @Default(0) int currentCount,
    @JsonKey(name: 'tracking_period') @Default('daily') String trackingPeriod, // daily, weekly, monthly

    // Completion tracking
    @JsonKey(name: 'is_completed_today') @Default(false) bool isCompletedToday,
    @JsonKey(name: 'last_completed_date') String? lastCompletedDate, // YYYY-MM-DD format
    @JsonKey(name: 'completion_history') @Default([]) List<String> completionHistory, // List of dates

    // Streak tracking
    @JsonKey(name: 'current_streak') @Default(0) int currentStreak,
    @JsonKey(name: 'longest_streak') @Default(0) int longestStreak,
    @JsonKey(name: 'total_completions') @Default(0) int totalCompletions,

    // Progress statistics
    @JsonKey(name: 'completion_rate') @Default(0.0) double completionRate, // 0.0 - 1.0
    @JsonKey(name: 'weekly_completions') @Default(0) int weeklyCompletions,
    @JsonKey(name: 'monthly_completions') @Default(0) int monthlyCompletions,

    // Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _HabitTracker;

  factory HabitTracker.fromJson(Map<String, dynamic> json) =>
      _$HabitTrackerFromJson(json);
}

/// Daily checklist item for spiritual practices
@freezed
class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'collection_item_id') String? collectionItemId,

    // Item details
    required String title,
    @JsonKey(name: 'arabic_title') String? arabicTitle,
    String? description,

    // Completion tracking
    @JsonKey(name: 'is_completed') @Default(false) bool isCompleted,
    @JsonKey(name: 'completed_at') DateTime? completedAt,

    // Display order
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,

    // Date for daily checklist
    @JsonKey(name: 'checklist_date') required String checklistDate, // YYYY-MM-DD format

    // Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);
}

/// Progress summary for a time period
@freezed
class ProgressSummary with _$ProgressSummary {
  const factory ProgressSummary({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'period_type') required String periodType, // daily, weekly, monthly
    @JsonKey(name: 'period_start') required DateTime periodStart,
    @JsonKey(name: 'period_end') required DateTime periodEnd,

    // Overall statistics
    @JsonKey(name: 'total_items') required int totalItems,
    @JsonKey(name: 'completed_items') required int completedItems,
    @JsonKey(name: 'completion_percentage') required double completionPercentage,

    // Streak information
    @JsonKey(name: 'current_streak') required int currentStreak,
    @JsonKey(name: 'best_day') String? bestDay, // Day with most completions
    @JsonKey(name: 'best_day_count') int? bestDayCount,

    // Category breakdown
    @JsonKey(name: 'by_category') @Default({}) Map<String, int> byCategory,

    // Daily breakdown for week/month view
    @JsonKey(name: 'daily_breakdown') @Default({}) Map<String, int> dailyBreakdown,
  }) = _ProgressSummary;

  factory ProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryFromJson(json);
}

/// Extension methods for HabitTracker
extension HabitTrackerExtensions on HabitTracker {
  /// Get progress percentage for current period
  double get progressPercentage {
    if (targetCount == 0) return 0.0;
    return (currentCount / targetCount).clamp(0.0, 1.0);
  }

  /// Check if goal is completed for current period
  bool get isGoalCompleted => currentCount >= targetCount;

  /// Get remaining count to reach goal
  int get remainingCount {
    final remaining = targetCount - currentCount;
    return remaining > 0 ? remaining : 0;
  }

  /// Get title in specified language
  String getTitle(String languageCode) {
    if (languageCode == 'ar' && arabicTitle != null) {
      return arabicTitle!;
    }
    return title;
  }

  /// Check if needs reset based on tracking period
  bool needsReset(DateTime now) {
    if (lastCompletedDate == null) return false;

    final lastDate = DateTime.parse(lastCompletedDate!);
    final daysSinceCompletion = now.difference(lastDate).inDays;

    switch (trackingPeriod) {
      case 'daily':
        return daysSinceCompletion >= 1;
      case 'weekly':
        return daysSinceCompletion >= 7;
      case 'monthly':
        return now.month != lastDate.month || now.year != lastDate.year;
      default:
        return false;
    }
  }

  /// Get streak status message
  String get streakMessage {
    if (currentStreak == 0) return 'Start your streak today!';
    if (currentStreak == 1) return '1 day streak';
    if (currentStreak < 7) return '$currentStreak days streak 🔥';
    if (currentStreak < 30) return '$currentStreak days streak 🔥🔥';
    return '$currentStreak days streak 🔥🔥🔥';
  }

  /// Get completion rate display
  String get completionRateDisplay {
    return '${(completionRate * 100).toStringAsFixed(0)}%';
  }

  /// Get performance level
  String get performanceLevel {
    if (completionRate >= 0.9) return 'Excellent';
    if (completionRate >= 0.7) return 'Good';
    if (completionRate >= 0.5) return 'Fair';
    return 'Needs Improvement';
  }

  /// Check if recently completed (within last hour)
  bool get isRecentlyCompleted {
    if (lastCompletedDate == null) return false;
    try {
      final lastDate = DateTime.parse(lastCompletedDate!);
      final hoursSinceCompletion = DateTime.now().difference(lastDate).inHours;
      return hoursSinceCompletion < 1;
    } catch (e) {
      return false;
    }
  }
}

/// Extension methods for ChecklistItem
extension ChecklistItemExtensions on ChecklistItem {
  /// Get title in specified language
  String getTitle(String languageCode) {
    if (languageCode == 'ar' && arabicTitle != null) {
      return arabicTitle!;
    }
    return title;
  }

  /// Check if completed today
  bool get isCompletedToday {
    if (!isCompleted || completedAt == null) return false;
    final today = DateTime.now();
    final completedDate = completedAt!;
    return today.year == completedDate.year &&
        today.month == completedDate.month &&
        today.day == completedDate.day;
  }

  /// Get completion status icon
  String get statusIcon {
    if (isCompleted) return '✅';
    return '⬜';
  }
}

/// Extension methods for ProgressSummary
extension ProgressSummaryExtensions on ProgressSummary {
  /// Get completion grade (A-F)
  String get completionGrade {
    if (completionPercentage >= 90) return 'A';
    if (completionPercentage >= 80) return 'B';
    if (completionPercentage >= 70) return 'C';
    if (completionPercentage >= 60) return 'D';
    return 'F';
  }

  /// Get motivational message
  String get motivationalMessage {
    if (completionPercentage >= 90) {
      return 'Outstanding effort! Keep up the amazing work!';
    } else if (completionPercentage >= 70) {
      return 'Great progress! You\'re doing well!';
    } else if (completionPercentage >= 50) {
      return 'Good start! Keep pushing forward!';
    } else {
      return 'Every journey begins with a single step. You can do this!';
    }
  }

  /// Check if had perfect completion
  bool get isPerfectCompletion => completionPercentage >= 100;

  /// Get period display name
  String get periodDisplayName {
    switch (periodType) {
      case 'daily':
        return 'Today';
      case 'weekly':
        return 'This Week';
      case 'monthly':
        return 'This Month';
      default:
        return periodType;
    }
  }
}
