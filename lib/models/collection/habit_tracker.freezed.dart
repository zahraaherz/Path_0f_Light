// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_tracker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HabitTracker _$HabitTrackerFromJson(Map<String, dynamic> json) {
  return _HabitTracker.fromJson(json);
}

/// @nodoc
mixin _$HabitTracker {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'collection_item_id')
  String get collectionItemId =>
      throw _privateConstructorUsedError; // Habit details
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'arabic_title')
  String? get arabicTitle => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Goal tracking
  @JsonKey(name: 'target_count')
  int get targetCount =>
      throw _privateConstructorUsedError; // Times per day/week
  @JsonKey(name: 'current_count')
  int get currentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracking_period')
  String get trackingPeriod =>
      throw _privateConstructorUsedError; // daily, weekly, monthly
// Completion tracking
  @JsonKey(name: 'is_completed_today')
  bool get isCompletedToday => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_completed_date')
  String? get lastCompletedDate =>
      throw _privateConstructorUsedError; // YYYY-MM-DD format
  @JsonKey(name: 'completion_history')
  List<String> get completionHistory =>
      throw _privateConstructorUsedError; // List of dates
// Streak tracking
  @JsonKey(name: 'current_streak')
  int get currentStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'longest_streak')
  int get longestStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_completions')
  int get totalCompletions =>
      throw _privateConstructorUsedError; // Progress statistics
  @JsonKey(name: 'completion_rate')
  double get completionRate => throw _privateConstructorUsedError; // 0.0 - 1.0
  @JsonKey(name: 'weekly_completions')
  int get weeklyCompletions => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_completions')
  int get monthlyCompletions =>
      throw _privateConstructorUsedError; // Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this HabitTracker to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HabitTracker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitTrackerCopyWith<HabitTracker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitTrackerCopyWith<$Res> {
  factory $HabitTrackerCopyWith(
          HabitTracker value, $Res Function(HabitTracker) then) =
      _$HabitTrackerCopyWithImpl<$Res, HabitTracker>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'collection_item_id') String collectionItemId,
      String title,
      @JsonKey(name: 'arabic_title') String? arabicTitle,
      String? description,
      @JsonKey(name: 'target_count') int targetCount,
      @JsonKey(name: 'current_count') int currentCount,
      @JsonKey(name: 'tracking_period') String trackingPeriod,
      @JsonKey(name: 'is_completed_today') bool isCompletedToday,
      @JsonKey(name: 'last_completed_date') String? lastCompletedDate,
      @JsonKey(name: 'completion_history') List<String> completionHistory,
      @JsonKey(name: 'current_streak') int currentStreak,
      @JsonKey(name: 'longest_streak') int longestStreak,
      @JsonKey(name: 'total_completions') int totalCompletions,
      @JsonKey(name: 'completion_rate') double completionRate,
      @JsonKey(name: 'weekly_completions') int weeklyCompletions,
      @JsonKey(name: 'monthly_completions') int monthlyCompletions,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$HabitTrackerCopyWithImpl<$Res, $Val extends HabitTracker>
    implements $HabitTrackerCopyWith<$Res> {
  _$HabitTrackerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitTracker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? collectionItemId = null,
    Object? title = null,
    Object? arabicTitle = freezed,
    Object? description = freezed,
    Object? targetCount = null,
    Object? currentCount = null,
    Object? trackingPeriod = null,
    Object? isCompletedToday = null,
    Object? lastCompletedDate = freezed,
    Object? completionHistory = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalCompletions = null,
    Object? completionRate = null,
    Object? weeklyCompletions = null,
    Object? monthlyCompletions = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      collectionItemId: null == collectionItemId
          ? _value.collectionItemId
          : collectionItemId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: freezed == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      targetCount: null == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentCount: null == currentCount
          ? _value.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as int,
      trackingPeriod: null == trackingPeriod
          ? _value.trackingPeriod
          : trackingPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      isCompletedToday: null == isCompletedToday
          ? _value.isCompletedToday
          : isCompletedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      lastCompletedDate: freezed == lastCompletedDate
          ? _value.lastCompletedDate
          : lastCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      completionHistory: null == completionHistory
          ? _value.completionHistory
          : completionHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompletions: null == totalCompletions
          ? _value.totalCompletions
          : totalCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyCompletions: null == weeklyCompletions
          ? _value.weeklyCompletions
          : weeklyCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyCompletions: null == monthlyCompletions
          ? _value.monthlyCompletions
          : monthlyCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HabitTrackerImplCopyWith<$Res>
    implements $HabitTrackerCopyWith<$Res> {
  factory _$$HabitTrackerImplCopyWith(
          _$HabitTrackerImpl value, $Res Function(_$HabitTrackerImpl) then) =
      __$$HabitTrackerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'collection_item_id') String collectionItemId,
      String title,
      @JsonKey(name: 'arabic_title') String? arabicTitle,
      String? description,
      @JsonKey(name: 'target_count') int targetCount,
      @JsonKey(name: 'current_count') int currentCount,
      @JsonKey(name: 'tracking_period') String trackingPeriod,
      @JsonKey(name: 'is_completed_today') bool isCompletedToday,
      @JsonKey(name: 'last_completed_date') String? lastCompletedDate,
      @JsonKey(name: 'completion_history') List<String> completionHistory,
      @JsonKey(name: 'current_streak') int currentStreak,
      @JsonKey(name: 'longest_streak') int longestStreak,
      @JsonKey(name: 'total_completions') int totalCompletions,
      @JsonKey(name: 'completion_rate') double completionRate,
      @JsonKey(name: 'weekly_completions') int weeklyCompletions,
      @JsonKey(name: 'monthly_completions') int monthlyCompletions,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$HabitTrackerImplCopyWithImpl<$Res>
    extends _$HabitTrackerCopyWithImpl<$Res, _$HabitTrackerImpl>
    implements _$$HabitTrackerImplCopyWith<$Res> {
  __$$HabitTrackerImplCopyWithImpl(
      _$HabitTrackerImpl _value, $Res Function(_$HabitTrackerImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitTracker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? collectionItemId = null,
    Object? title = null,
    Object? arabicTitle = freezed,
    Object? description = freezed,
    Object? targetCount = null,
    Object? currentCount = null,
    Object? trackingPeriod = null,
    Object? isCompletedToday = null,
    Object? lastCompletedDate = freezed,
    Object? completionHistory = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalCompletions = null,
    Object? completionRate = null,
    Object? weeklyCompletions = null,
    Object? monthlyCompletions = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$HabitTrackerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      collectionItemId: null == collectionItemId
          ? _value.collectionItemId
          : collectionItemId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: freezed == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      targetCount: null == targetCount
          ? _value.targetCount
          : targetCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentCount: null == currentCount
          ? _value.currentCount
          : currentCount // ignore: cast_nullable_to_non_nullable
              as int,
      trackingPeriod: null == trackingPeriod
          ? _value.trackingPeriod
          : trackingPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      isCompletedToday: null == isCompletedToday
          ? _value.isCompletedToday
          : isCompletedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      lastCompletedDate: freezed == lastCompletedDate
          ? _value.lastCompletedDate
          : lastCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      completionHistory: null == completionHistory
          ? _value._completionHistory
          : completionHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompletions: null == totalCompletions
          ? _value.totalCompletions
          : totalCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      completionRate: null == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyCompletions: null == weeklyCompletions
          ? _value.weeklyCompletions
          : weeklyCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyCompletions: null == monthlyCompletions
          ? _value.monthlyCompletions
          : monthlyCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HabitTrackerImpl implements _HabitTracker {
  const _$HabitTrackerImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'collection_item_id') required this.collectionItemId,
      required this.title,
      @JsonKey(name: 'arabic_title') this.arabicTitle,
      this.description,
      @JsonKey(name: 'target_count') this.targetCount = 1,
      @JsonKey(name: 'current_count') this.currentCount = 0,
      @JsonKey(name: 'tracking_period') this.trackingPeriod = 'daily',
      @JsonKey(name: 'is_completed_today') this.isCompletedToday = false,
      @JsonKey(name: 'last_completed_date') this.lastCompletedDate,
      @JsonKey(name: 'completion_history')
      final List<String> completionHistory = const [],
      @JsonKey(name: 'current_streak') this.currentStreak = 0,
      @JsonKey(name: 'longest_streak') this.longestStreak = 0,
      @JsonKey(name: 'total_completions') this.totalCompletions = 0,
      @JsonKey(name: 'completion_rate') this.completionRate = 0.0,
      @JsonKey(name: 'weekly_completions') this.weeklyCompletions = 0,
      @JsonKey(name: 'monthly_completions') this.monthlyCompletions = 0,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _completionHistory = completionHistory;

  factory _$HabitTrackerImpl.fromJson(Map<String, dynamic> json) =>
      _$$HabitTrackerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'collection_item_id')
  final String collectionItemId;
// Habit details
  @override
  final String title;
  @override
  @JsonKey(name: 'arabic_title')
  final String? arabicTitle;
  @override
  final String? description;
// Goal tracking
  @override
  @JsonKey(name: 'target_count')
  final int targetCount;
// Times per day/week
  @override
  @JsonKey(name: 'current_count')
  final int currentCount;
  @override
  @JsonKey(name: 'tracking_period')
  final String trackingPeriod;
// daily, weekly, monthly
// Completion tracking
  @override
  @JsonKey(name: 'is_completed_today')
  final bool isCompletedToday;
  @override
  @JsonKey(name: 'last_completed_date')
  final String? lastCompletedDate;
// YYYY-MM-DD format
  final List<String> _completionHistory;
// YYYY-MM-DD format
  @override
  @JsonKey(name: 'completion_history')
  List<String> get completionHistory {
    if (_completionHistory is EqualUnmodifiableListView)
      return _completionHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completionHistory);
  }

// List of dates
// Streak tracking
  @override
  @JsonKey(name: 'current_streak')
  final int currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  final int longestStreak;
  @override
  @JsonKey(name: 'total_completions')
  final int totalCompletions;
// Progress statistics
  @override
  @JsonKey(name: 'completion_rate')
  final double completionRate;
// 0.0 - 1.0
  @override
  @JsonKey(name: 'weekly_completions')
  final int weeklyCompletions;
  @override
  @JsonKey(name: 'monthly_completions')
  final int monthlyCompletions;
// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'HabitTracker(id: $id, userId: $userId, collectionItemId: $collectionItemId, title: $title, arabicTitle: $arabicTitle, description: $description, targetCount: $targetCount, currentCount: $currentCount, trackingPeriod: $trackingPeriod, isCompletedToday: $isCompletedToday, lastCompletedDate: $lastCompletedDate, completionHistory: $completionHistory, currentStreak: $currentStreak, longestStreak: $longestStreak, totalCompletions: $totalCompletions, completionRate: $completionRate, weeklyCompletions: $weeklyCompletions, monthlyCompletions: $monthlyCompletions, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitTrackerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.collectionItemId, collectionItemId) ||
                other.collectionItemId == collectionItemId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabicTitle, arabicTitle) ||
                other.arabicTitle == arabicTitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.targetCount, targetCount) ||
                other.targetCount == targetCount) &&
            (identical(other.currentCount, currentCount) ||
                other.currentCount == currentCount) &&
            (identical(other.trackingPeriod, trackingPeriod) ||
                other.trackingPeriod == trackingPeriod) &&
            (identical(other.isCompletedToday, isCompletedToday) ||
                other.isCompletedToday == isCompletedToday) &&
            (identical(other.lastCompletedDate, lastCompletedDate) ||
                other.lastCompletedDate == lastCompletedDate) &&
            const DeepCollectionEquality()
                .equals(other._completionHistory, _completionHistory) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.totalCompletions, totalCompletions) ||
                other.totalCompletions == totalCompletions) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.weeklyCompletions, weeklyCompletions) ||
                other.weeklyCompletions == weeklyCompletions) &&
            (identical(other.monthlyCompletions, monthlyCompletions) ||
                other.monthlyCompletions == monthlyCompletions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        collectionItemId,
        title,
        arabicTitle,
        description,
        targetCount,
        currentCount,
        trackingPeriod,
        isCompletedToday,
        lastCompletedDate,
        const DeepCollectionEquality().hash(_completionHistory),
        currentStreak,
        longestStreak,
        totalCompletions,
        completionRate,
        weeklyCompletions,
        monthlyCompletions,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of HabitTracker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitTrackerImplCopyWith<_$HabitTrackerImpl> get copyWith =>
      __$$HabitTrackerImplCopyWithImpl<_$HabitTrackerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HabitTrackerImplToJson(
      this,
    );
  }
}

abstract class _HabitTracker implements HabitTracker {
  const factory _HabitTracker(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'collection_item_id')
      required final String collectionItemId,
      required final String title,
      @JsonKey(name: 'arabic_title') final String? arabicTitle,
      final String? description,
      @JsonKey(name: 'target_count') final int targetCount,
      @JsonKey(name: 'current_count') final int currentCount,
      @JsonKey(name: 'tracking_period') final String trackingPeriod,
      @JsonKey(name: 'is_completed_today') final bool isCompletedToday,
      @JsonKey(name: 'last_completed_date') final String? lastCompletedDate,
      @JsonKey(name: 'completion_history') final List<String> completionHistory,
      @JsonKey(name: 'current_streak') final int currentStreak,
      @JsonKey(name: 'longest_streak') final int longestStreak,
      @JsonKey(name: 'total_completions') final int totalCompletions,
      @JsonKey(name: 'completion_rate') final double completionRate,
      @JsonKey(name: 'weekly_completions') final int weeklyCompletions,
      @JsonKey(name: 'monthly_completions') final int monthlyCompletions,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at')
      final DateTime? updatedAt}) = _$HabitTrackerImpl;

  factory _HabitTracker.fromJson(Map<String, dynamic> json) =
      _$HabitTrackerImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'collection_item_id')
  String get collectionItemId; // Habit details
  @override
  String get title;
  @override
  @JsonKey(name: 'arabic_title')
  String? get arabicTitle;
  @override
  String? get description; // Goal tracking
  @override
  @JsonKey(name: 'target_count')
  int get targetCount; // Times per day/week
  @override
  @JsonKey(name: 'current_count')
  int get currentCount;
  @override
  @JsonKey(name: 'tracking_period')
  String get trackingPeriod; // daily, weekly, monthly
// Completion tracking
  @override
  @JsonKey(name: 'is_completed_today')
  bool get isCompletedToday;
  @override
  @JsonKey(name: 'last_completed_date')
  String? get lastCompletedDate; // YYYY-MM-DD format
  @override
  @JsonKey(name: 'completion_history')
  List<String> get completionHistory; // List of dates
// Streak tracking
  @override
  @JsonKey(name: 'current_streak')
  int get currentStreak;
  @override
  @JsonKey(name: 'longest_streak')
  int get longestStreak;
  @override
  @JsonKey(name: 'total_completions')
  int get totalCompletions; // Progress statistics
  @override
  @JsonKey(name: 'completion_rate')
  double get completionRate; // 0.0 - 1.0
  @override
  @JsonKey(name: 'weekly_completions')
  int get weeklyCompletions;
  @override
  @JsonKey(name: 'monthly_completions')
  int get monthlyCompletions; // Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of HabitTracker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitTrackerImplCopyWith<_$HabitTrackerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) {
  return _ChecklistItem.fromJson(json);
}

/// @nodoc
mixin _$ChecklistItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'collection_item_id')
  String? get collectionItemId =>
      throw _privateConstructorUsedError; // Item details
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'arabic_title')
  String? get arabicTitle => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Completion tracking
  @JsonKey(name: 'is_completed')
  bool get isCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt =>
      throw _privateConstructorUsedError; // Display order
  @JsonKey(name: 'sort_order')
  int get sortOrder =>
      throw _privateConstructorUsedError; // Date for daily checklist
  @JsonKey(name: 'checklist_date')
  String get checklistDate =>
      throw _privateConstructorUsedError; // YYYY-MM-DD format
// Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChecklistItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChecklistItemCopyWith<ChecklistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChecklistItemCopyWith<$Res> {
  factory $ChecklistItemCopyWith(
          ChecklistItem value, $Res Function(ChecklistItem) then) =
      _$ChecklistItemCopyWithImpl<$Res, ChecklistItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'collection_item_id') String? collectionItemId,
      String title,
      @JsonKey(name: 'arabic_title') String? arabicTitle,
      String? description,
      @JsonKey(name: 'is_completed') bool isCompleted,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'sort_order') int sortOrder,
      @JsonKey(name: 'checklist_date') String checklistDate,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$ChecklistItemCopyWithImpl<$Res, $Val extends ChecklistItem>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? collectionItemId = freezed,
    Object? title = null,
    Object? arabicTitle = freezed,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? sortOrder = null,
    Object? checklistDate = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      collectionItemId: freezed == collectionItemId
          ? _value.collectionItemId
          : collectionItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: freezed == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      checklistDate: null == checklistDate
          ? _value.checklistDate
          : checklistDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChecklistItemImplCopyWith<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  factory _$$ChecklistItemImplCopyWith(
          _$ChecklistItemImpl value, $Res Function(_$ChecklistItemImpl) then) =
      __$$ChecklistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'collection_item_id') String? collectionItemId,
      String title,
      @JsonKey(name: 'arabic_title') String? arabicTitle,
      String? description,
      @JsonKey(name: 'is_completed') bool isCompleted,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'sort_order') int sortOrder,
      @JsonKey(name: 'checklist_date') String checklistDate,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$ChecklistItemImplCopyWithImpl<$Res>
    extends _$ChecklistItemCopyWithImpl<$Res, _$ChecklistItemImpl>
    implements _$$ChecklistItemImplCopyWith<$Res> {
  __$$ChecklistItemImplCopyWithImpl(
      _$ChecklistItemImpl _value, $Res Function(_$ChecklistItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? collectionItemId = freezed,
    Object? title = null,
    Object? arabicTitle = freezed,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? sortOrder = null,
    Object? checklistDate = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$ChecklistItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      collectionItemId: freezed == collectionItemId
          ? _value.collectionItemId
          : collectionItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      arabicTitle: freezed == arabicTitle
          ? _value.arabicTitle
          : arabicTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      checklistDate: null == checklistDate
          ? _value.checklistDate
          : checklistDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChecklistItemImpl implements _ChecklistItem {
  const _$ChecklistItemImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'collection_item_id') this.collectionItemId,
      required this.title,
      @JsonKey(name: 'arabic_title') this.arabicTitle,
      this.description,
      @JsonKey(name: 'is_completed') this.isCompleted = false,
      @JsonKey(name: 'completed_at') this.completedAt,
      @JsonKey(name: 'sort_order') this.sortOrder = 0,
      @JsonKey(name: 'checklist_date') required this.checklistDate,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$ChecklistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChecklistItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'collection_item_id')
  final String? collectionItemId;
// Item details
  @override
  final String title;
  @override
  @JsonKey(name: 'arabic_title')
  final String? arabicTitle;
  @override
  final String? description;
// Completion tracking
  @override
  @JsonKey(name: 'is_completed')
  final bool isCompleted;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
// Display order
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
// Date for daily checklist
  @override
  @JsonKey(name: 'checklist_date')
  final String checklistDate;
// YYYY-MM-DD format
// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ChecklistItem(id: $id, userId: $userId, collectionItemId: $collectionItemId, title: $title, arabicTitle: $arabicTitle, description: $description, isCompleted: $isCompleted, completedAt: $completedAt, sortOrder: $sortOrder, checklistDate: $checklistDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.collectionItemId, collectionItemId) ||
                other.collectionItemId == collectionItemId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.arabicTitle, arabicTitle) ||
                other.arabicTitle == arabicTitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.checklistDate, checklistDate) ||
                other.checklistDate == checklistDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      collectionItemId,
      title,
      arabicTitle,
      description,
      isCompleted,
      completedAt,
      sortOrder,
      checklistDate,
      createdAt);

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      __$$ChecklistItemImplCopyWithImpl<_$ChecklistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChecklistItemImplToJson(
      this,
    );
  }
}

abstract class _ChecklistItem implements ChecklistItem {
  const factory _ChecklistItem(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'collection_item_id') final String? collectionItemId,
          required final String title,
          @JsonKey(name: 'arabic_title') final String? arabicTitle,
          final String? description,
          @JsonKey(name: 'is_completed') final bool isCompleted,
          @JsonKey(name: 'completed_at') final DateTime? completedAt,
          @JsonKey(name: 'sort_order') final int sortOrder,
          @JsonKey(name: 'checklist_date') required final String checklistDate,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$ChecklistItemImpl;

  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =
      _$ChecklistItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'collection_item_id')
  String? get collectionItemId; // Item details
  @override
  String get title;
  @override
  @JsonKey(name: 'arabic_title')
  String? get arabicTitle;
  @override
  String? get description; // Completion tracking
  @override
  @JsonKey(name: 'is_completed')
  bool get isCompleted;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt; // Display order
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder; // Date for daily checklist
  @override
  @JsonKey(name: 'checklist_date')
  String get checklistDate; // YYYY-MM-DD format
// Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressSummary _$ProgressSummaryFromJson(Map<String, dynamic> json) {
  return _ProgressSummary.fromJson(json);
}

/// @nodoc
mixin _$ProgressSummary {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_type')
  String get periodType =>
      throw _privateConstructorUsedError; // daily, weekly, monthly
  @JsonKey(name: 'period_start')
  DateTime get periodStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'period_end')
  DateTime get periodEnd =>
      throw _privateConstructorUsedError; // Overall statistics
  @JsonKey(name: 'total_items')
  int get totalItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_items')
  int get completedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'completion_percentage')
  double get completionPercentage =>
      throw _privateConstructorUsedError; // Streak information
  @JsonKey(name: 'current_streak')
  int get currentStreak => throw _privateConstructorUsedError;
  @JsonKey(name: 'best_day')
  String? get bestDay =>
      throw _privateConstructorUsedError; // Day with most completions
  @JsonKey(name: 'best_day_count')
  int? get bestDayCount =>
      throw _privateConstructorUsedError; // Category breakdown
  @JsonKey(name: 'by_category')
  Map<String, int> get byCategory =>
      throw _privateConstructorUsedError; // Daily breakdown for week/month view
  @JsonKey(name: 'daily_breakdown')
  Map<String, int> get dailyBreakdown => throw _privateConstructorUsedError;

  /// Serializes this ProgressSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressSummaryCopyWith<ProgressSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressSummaryCopyWith<$Res> {
  factory $ProgressSummaryCopyWith(
          ProgressSummary value, $Res Function(ProgressSummary) then) =
      _$ProgressSummaryCopyWithImpl<$Res, ProgressSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'period_type') String periodType,
      @JsonKey(name: 'period_start') DateTime periodStart,
      @JsonKey(name: 'period_end') DateTime periodEnd,
      @JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'completed_items') int completedItems,
      @JsonKey(name: 'completion_percentage') double completionPercentage,
      @JsonKey(name: 'current_streak') int currentStreak,
      @JsonKey(name: 'best_day') String? bestDay,
      @JsonKey(name: 'best_day_count') int? bestDayCount,
      @JsonKey(name: 'by_category') Map<String, int> byCategory,
      @JsonKey(name: 'daily_breakdown') Map<String, int> dailyBreakdown});
}

/// @nodoc
class _$ProgressSummaryCopyWithImpl<$Res, $Val extends ProgressSummary>
    implements $ProgressSummaryCopyWith<$Res> {
  _$ProgressSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? periodType = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalItems = null,
    Object? completedItems = null,
    Object? completionPercentage = null,
    Object? currentStreak = null,
    Object? bestDay = freezed,
    Object? bestDayCount = freezed,
    Object? byCategory = null,
    Object? dailyBreakdown = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      periodType: null == periodType
          ? _value.periodType
          : periodType // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      completedItems: null == completedItems
          ? _value.completedItems
          : completedItems // ignore: cast_nullable_to_non_nullable
              as int,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestDay: freezed == bestDay
          ? _value.bestDay
          : bestDay // ignore: cast_nullable_to_non_nullable
              as String?,
      bestDayCount: freezed == bestDayCount
          ? _value.bestDayCount
          : bestDayCount // ignore: cast_nullable_to_non_nullable
              as int?,
      byCategory: null == byCategory
          ? _value.byCategory
          : byCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      dailyBreakdown: null == dailyBreakdown
          ? _value.dailyBreakdown
          : dailyBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressSummaryImplCopyWith<$Res>
    implements $ProgressSummaryCopyWith<$Res> {
  factory _$$ProgressSummaryImplCopyWith(_$ProgressSummaryImpl value,
          $Res Function(_$ProgressSummaryImpl) then) =
      __$$ProgressSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'period_type') String periodType,
      @JsonKey(name: 'period_start') DateTime periodStart,
      @JsonKey(name: 'period_end') DateTime periodEnd,
      @JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'completed_items') int completedItems,
      @JsonKey(name: 'completion_percentage') double completionPercentage,
      @JsonKey(name: 'current_streak') int currentStreak,
      @JsonKey(name: 'best_day') String? bestDay,
      @JsonKey(name: 'best_day_count') int? bestDayCount,
      @JsonKey(name: 'by_category') Map<String, int> byCategory,
      @JsonKey(name: 'daily_breakdown') Map<String, int> dailyBreakdown});
}

/// @nodoc
class __$$ProgressSummaryImplCopyWithImpl<$Res>
    extends _$ProgressSummaryCopyWithImpl<$Res, _$ProgressSummaryImpl>
    implements _$$ProgressSummaryImplCopyWith<$Res> {
  __$$ProgressSummaryImplCopyWithImpl(
      _$ProgressSummaryImpl _value, $Res Function(_$ProgressSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? periodType = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalItems = null,
    Object? completedItems = null,
    Object? completionPercentage = null,
    Object? currentStreak = null,
    Object? bestDay = freezed,
    Object? bestDayCount = freezed,
    Object? byCategory = null,
    Object? dailyBreakdown = null,
  }) {
    return _then(_$ProgressSummaryImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      periodType: null == periodType
          ? _value.periodType
          : periodType // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      completedItems: null == completedItems
          ? _value.completedItems
          : completedItems // ignore: cast_nullable_to_non_nullable
              as int,
      completionPercentage: null == completionPercentage
          ? _value.completionPercentage
          : completionPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestDay: freezed == bestDay
          ? _value.bestDay
          : bestDay // ignore: cast_nullable_to_non_nullable
              as String?,
      bestDayCount: freezed == bestDayCount
          ? _value.bestDayCount
          : bestDayCount // ignore: cast_nullable_to_non_nullable
              as int?,
      byCategory: null == byCategory
          ? _value._byCategory
          : byCategory // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      dailyBreakdown: null == dailyBreakdown
          ? _value._dailyBreakdown
          : dailyBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressSummaryImpl implements _ProgressSummary {
  const _$ProgressSummaryImpl(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'period_type') required this.periodType,
      @JsonKey(name: 'period_start') required this.periodStart,
      @JsonKey(name: 'period_end') required this.periodEnd,
      @JsonKey(name: 'total_items') required this.totalItems,
      @JsonKey(name: 'completed_items') required this.completedItems,
      @JsonKey(name: 'completion_percentage')
      required this.completionPercentage,
      @JsonKey(name: 'current_streak') required this.currentStreak,
      @JsonKey(name: 'best_day') this.bestDay,
      @JsonKey(name: 'best_day_count') this.bestDayCount,
      @JsonKey(name: 'by_category')
      final Map<String, int> byCategory = const {},
      @JsonKey(name: 'daily_breakdown')
      final Map<String, int> dailyBreakdown = const {}})
      : _byCategory = byCategory,
        _dailyBreakdown = dailyBreakdown;

  factory _$ProgressSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'period_type')
  final String periodType;
// daily, weekly, monthly
  @override
  @JsonKey(name: 'period_start')
  final DateTime periodStart;
  @override
  @JsonKey(name: 'period_end')
  final DateTime periodEnd;
// Overall statistics
  @override
  @JsonKey(name: 'total_items')
  final int totalItems;
  @override
  @JsonKey(name: 'completed_items')
  final int completedItems;
  @override
  @JsonKey(name: 'completion_percentage')
  final double completionPercentage;
// Streak information
  @override
  @JsonKey(name: 'current_streak')
  final int currentStreak;
  @override
  @JsonKey(name: 'best_day')
  final String? bestDay;
// Day with most completions
  @override
  @JsonKey(name: 'best_day_count')
  final int? bestDayCount;
// Category breakdown
  final Map<String, int> _byCategory;
// Category breakdown
  @override
  @JsonKey(name: 'by_category')
  Map<String, int> get byCategory {
    if (_byCategory is EqualUnmodifiableMapView) return _byCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byCategory);
  }

// Daily breakdown for week/month view
  final Map<String, int> _dailyBreakdown;
// Daily breakdown for week/month view
  @override
  @JsonKey(name: 'daily_breakdown')
  Map<String, int> get dailyBreakdown {
    if (_dailyBreakdown is EqualUnmodifiableMapView) return _dailyBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dailyBreakdown);
  }

  @override
  String toString() {
    return 'ProgressSummary(userId: $userId, periodType: $periodType, periodStart: $periodStart, periodEnd: $periodEnd, totalItems: $totalItems, completedItems: $completedItems, completionPercentage: $completionPercentage, currentStreak: $currentStreak, bestDay: $bestDay, bestDayCount: $bestDayCount, byCategory: $byCategory, dailyBreakdown: $dailyBreakdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressSummaryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.periodType, periodType) ||
                other.periodType == periodType) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.completedItems, completedItems) ||
                other.completedItems == completedItems) &&
            (identical(other.completionPercentage, completionPercentage) ||
                other.completionPercentage == completionPercentage) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestDay, bestDay) || other.bestDay == bestDay) &&
            (identical(other.bestDayCount, bestDayCount) ||
                other.bestDayCount == bestDayCount) &&
            const DeepCollectionEquality()
                .equals(other._byCategory, _byCategory) &&
            const DeepCollectionEquality()
                .equals(other._dailyBreakdown, _dailyBreakdown));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      periodType,
      periodStart,
      periodEnd,
      totalItems,
      completedItems,
      completionPercentage,
      currentStreak,
      bestDay,
      bestDayCount,
      const DeepCollectionEquality().hash(_byCategory),
      const DeepCollectionEquality().hash(_dailyBreakdown));

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressSummaryImplCopyWith<_$ProgressSummaryImpl> get copyWith =>
      __$$ProgressSummaryImplCopyWithImpl<_$ProgressSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressSummaryImplToJson(
      this,
    );
  }
}

abstract class _ProgressSummary implements ProgressSummary {
  const factory _ProgressSummary(
      {@JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'period_type') required final String periodType,
      @JsonKey(name: 'period_start') required final DateTime periodStart,
      @JsonKey(name: 'period_end') required final DateTime periodEnd,
      @JsonKey(name: 'total_items') required final int totalItems,
      @JsonKey(name: 'completed_items') required final int completedItems,
      @JsonKey(name: 'completion_percentage')
      required final double completionPercentage,
      @JsonKey(name: 'current_streak') required final int currentStreak,
      @JsonKey(name: 'best_day') final String? bestDay,
      @JsonKey(name: 'best_day_count') final int? bestDayCount,
      @JsonKey(name: 'by_category') final Map<String, int> byCategory,
      @JsonKey(name: 'daily_breakdown')
      final Map<String, int> dailyBreakdown}) = _$ProgressSummaryImpl;

  factory _ProgressSummary.fromJson(Map<String, dynamic> json) =
      _$ProgressSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'period_type')
  String get periodType; // daily, weekly, monthly
  @override
  @JsonKey(name: 'period_start')
  DateTime get periodStart;
  @override
  @JsonKey(name: 'period_end')
  DateTime get periodEnd; // Overall statistics
  @override
  @JsonKey(name: 'total_items')
  int get totalItems;
  @override
  @JsonKey(name: 'completed_items')
  int get completedItems;
  @override
  @JsonKey(name: 'completion_percentage')
  double get completionPercentage; // Streak information
  @override
  @JsonKey(name: 'current_streak')
  int get currentStreak;
  @override
  @JsonKey(name: 'best_day')
  String? get bestDay; // Day with most completions
  @override
  @JsonKey(name: 'best_day_count')
  int? get bestDayCount; // Category breakdown
  @override
  @JsonKey(name: 'by_category')
  Map<String, int> get byCategory; // Daily breakdown for week/month view
  @override
  @JsonKey(name: 'daily_breakdown')
  Map<String, int> get dailyBreakdown;

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressSummaryImplCopyWith<_$ProgressSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
