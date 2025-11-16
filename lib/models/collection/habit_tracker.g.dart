// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_tracker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitTrackerImpl _$$HabitTrackerImplFromJson(Map<String, dynamic> json) =>
    _$HabitTrackerImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      collectionItemId: json['collection_item_id'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabic_title'] as String?,
      description: json['description'] as String?,
      targetCount: (json['target_count'] as num?)?.toInt() ?? 1,
      currentCount: (json['current_count'] as num?)?.toInt() ?? 0,
      trackingPeriod: json['tracking_period'] as String? ?? 'daily',
      isCompletedToday: json['is_completed_today'] as bool? ?? false,
      lastCompletedDate: json['last_completed_date'] as String?,
      completionHistory: (json['completion_history'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentStreak: (json['current_streak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longest_streak'] as num?)?.toInt() ?? 0,
      totalCompletions: (json['total_completions'] as num?)?.toInt() ?? 0,
      completionRate: (json['completion_rate'] as num?)?.toDouble() ?? 0.0,
      weeklyCompletions: (json['weekly_completions'] as num?)?.toInt() ?? 0,
      monthlyCompletions: (json['monthly_completions'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$HabitTrackerImplToJson(_$HabitTrackerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'collection_item_id': instance.collectionItemId,
      'title': instance.title,
      'arabic_title': instance.arabicTitle,
      'description': instance.description,
      'target_count': instance.targetCount,
      'current_count': instance.currentCount,
      'tracking_period': instance.trackingPeriod,
      'is_completed_today': instance.isCompletedToday,
      'last_completed_date': instance.lastCompletedDate,
      'completion_history': instance.completionHistory,
      'current_streak': instance.currentStreak,
      'longest_streak': instance.longestStreak,
      'total_completions': instance.totalCompletions,
      'completion_rate': instance.completionRate,
      'weekly_completions': instance.weeklyCompletions,
      'monthly_completions': instance.monthlyCompletions,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$ChecklistItemImpl _$$ChecklistItemImplFromJson(Map<String, dynamic> json) =>
    _$ChecklistItemImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      collectionItemId: json['collection_item_id'] as String?,
      title: json['title'] as String,
      arabicTitle: json['arabic_title'] as String?,
      description: json['description'] as String?,
      isCompleted: json['is_completed'] as bool? ?? false,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      checklistDate: json['checklist_date'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ChecklistItemImplToJson(_$ChecklistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'collection_item_id': instance.collectionItemId,
      'title': instance.title,
      'arabic_title': instance.arabicTitle,
      'description': instance.description,
      'is_completed': instance.isCompleted,
      'completed_at': instance.completedAt?.toIso8601String(),
      'sort_order': instance.sortOrder,
      'checklist_date': instance.checklistDate,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$ProgressSummaryImpl _$$ProgressSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$ProgressSummaryImpl(
      userId: json['user_id'] as String,
      periodType: json['period_type'] as String,
      periodStart: DateTime.parse(json['period_start'] as String),
      periodEnd: DateTime.parse(json['period_end'] as String),
      totalItems: (json['total_items'] as num).toInt(),
      completedItems: (json['completed_items'] as num).toInt(),
      completionPercentage: (json['completion_percentage'] as num).toDouble(),
      currentStreak: (json['current_streak'] as num).toInt(),
      bestDay: json['best_day'] as String?,
      bestDayCount: (json['best_day_count'] as num?)?.toInt(),
      byCategory: (json['by_category'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      dailyBreakdown: (json['daily_breakdown'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ProgressSummaryImplToJson(
        _$ProgressSummaryImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'period_type': instance.periodType,
      'period_start': instance.periodStart.toIso8601String(),
      'period_end': instance.periodEnd.toIso8601String(),
      'total_items': instance.totalItems,
      'completed_items': instance.completedItems,
      'completion_percentage': instance.completionPercentage,
      'current_streak': instance.currentStreak,
      'best_day': instance.bestDay,
      'best_day_count': instance.bestDayCount,
      'by_category': instance.byCategory,
      'daily_breakdown': instance.dailyBreakdown,
    };
