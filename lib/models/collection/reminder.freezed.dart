// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reminder _$ReminderFromJson(Map<String, dynamic> json) {
  return _Reminder.fromJson(json);
}

/// @nodoc
mixin _$Reminder {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'collection_item_id')
  String get collectionItemId =>
      throw _privateConstructorUsedError; // Reminder details
  String get title => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'inspirational_text')
  String? get inspirationalText =>
      throw _privateConstructorUsedError; // Hadith or verse
// Trigger configuration
  @JsonKey(name: 'trigger_type')
  ReminderTriggerType get triggerType => throw _privateConstructorUsedError;
  ReminderFrequency get frequency =>
      throw _privateConstructorUsedError; // Time-based triggers
  @JsonKey(name: 'trigger_time')
  String? get triggerTime => throw _privateConstructorUsedError; // HH:mm format
  @JsonKey(name: 'trigger_date')
  DateTime? get triggerDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_of_week')
  List<DayOfWeek> get daysOfWeek =>
      throw _privateConstructorUsedError; // Prayer-based triggers
  @JsonKey(name: 'prayer_time')
  PrayerTimeOption? get prayerTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'minutes_before_prayer')
  int get minutesBeforePrayer => throw _privateConstructorUsedError;
  @JsonKey(name: 'minutes_after_prayer')
  int get minutesAfterPrayer =>
      throw _privateConstructorUsedError; // Islamic calendar
  @JsonKey(name: 'hijri_month')
  int? get hijriMonth => throw _privateConstructorUsedError; // 1-12
  @JsonKey(name: 'hijri_day')
  int? get hijriDay => throw _privateConstructorUsedError; // 1-30
// Notification settings
  @JsonKey(name: 'is_enabled')
  bool get isEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'sound_enabled')
  bool get soundEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'vibration_enabled')
  bool get vibrationEnabled => throw _privateConstructorUsedError; // Tracking
  @JsonKey(name: 'last_triggered')
  DateTime? get lastTriggered => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_trigger')
  DateTime? get nextTrigger => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_triggers')
  int get totalTriggers => throw _privateConstructorUsedError; // Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Reminder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderCopyWith<Reminder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderCopyWith<$Res> {
  factory $ReminderCopyWith(Reminder value, $Res Function(Reminder) then) =
      _$ReminderCopyWithImpl<$Res, Reminder>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'collection_item_id') String collectionItemId,
      String title,
      String? message,
      @JsonKey(name: 'inspirational_text') String? inspirationalText,
      @JsonKey(name: 'trigger_type') ReminderTriggerType triggerType,
      ReminderFrequency frequency,
      @JsonKey(name: 'trigger_time') String? triggerTime,
      @JsonKey(name: 'trigger_date') DateTime? triggerDate,
      @JsonKey(name: 'days_of_week') List<DayOfWeek> daysOfWeek,
      @JsonKey(name: 'prayer_time') PrayerTimeOption? prayerTime,
      @JsonKey(name: 'minutes_before_prayer') int minutesBeforePrayer,
      @JsonKey(name: 'minutes_after_prayer') int minutesAfterPrayer,
      @JsonKey(name: 'hijri_month') int? hijriMonth,
      @JsonKey(name: 'hijri_day') int? hijriDay,
      @JsonKey(name: 'is_enabled') bool isEnabled,
      @JsonKey(name: 'sound_enabled') bool soundEnabled,
      @JsonKey(name: 'vibration_enabled') bool vibrationEnabled,
      @JsonKey(name: 'last_triggered') DateTime? lastTriggered,
      @JsonKey(name: 'next_trigger') DateTime? nextTrigger,
      @JsonKey(name: 'total_triggers') int totalTriggers,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$ReminderCopyWithImpl<$Res, $Val extends Reminder>
    implements $ReminderCopyWith<$Res> {
  _$ReminderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? collectionItemId = null,
    Object? title = null,
    Object? message = freezed,
    Object? inspirationalText = freezed,
    Object? triggerType = null,
    Object? frequency = null,
    Object? triggerTime = freezed,
    Object? triggerDate = freezed,
    Object? daysOfWeek = null,
    Object? prayerTime = freezed,
    Object? minutesBeforePrayer = null,
    Object? minutesAfterPrayer = null,
    Object? hijriMonth = freezed,
    Object? hijriDay = freezed,
    Object? isEnabled = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? lastTriggered = freezed,
    Object? nextTrigger = freezed,
    Object? totalTriggers = null,
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
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      inspirationalText: freezed == inspirationalText
          ? _value.inspirationalText
          : inspirationalText // ignore: cast_nullable_to_non_nullable
              as String?,
      triggerType: null == triggerType
          ? _value.triggerType
          : triggerType // ignore: cast_nullable_to_non_nullable
              as ReminderTriggerType,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as ReminderFrequency,
      triggerTime: freezed == triggerTime
          ? _value.triggerTime
          : triggerTime // ignore: cast_nullable_to_non_nullable
              as String?,
      triggerDate: freezed == triggerDate
          ? _value.triggerDate
          : triggerDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      daysOfWeek: null == daysOfWeek
          ? _value.daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<DayOfWeek>,
      prayerTime: freezed == prayerTime
          ? _value.prayerTime
          : prayerTime // ignore: cast_nullable_to_non_nullable
              as PrayerTimeOption?,
      minutesBeforePrayer: null == minutesBeforePrayer
          ? _value.minutesBeforePrayer
          : minutesBeforePrayer // ignore: cast_nullable_to_non_nullable
              as int,
      minutesAfterPrayer: null == minutesAfterPrayer
          ? _value.minutesAfterPrayer
          : minutesAfterPrayer // ignore: cast_nullable_to_non_nullable
              as int,
      hijriMonth: freezed == hijriMonth
          ? _value.hijriMonth
          : hijriMonth // ignore: cast_nullable_to_non_nullable
              as int?,
      hijriDay: freezed == hijriDay
          ? _value.hijriDay
          : hijriDay // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextTrigger: freezed == nextTrigger
          ? _value.nextTrigger
          : nextTrigger // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalTriggers: null == totalTriggers
          ? _value.totalTriggers
          : totalTriggers // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ReminderImplCopyWith<$Res>
    implements $ReminderCopyWith<$Res> {
  factory _$$ReminderImplCopyWith(
          _$ReminderImpl value, $Res Function(_$ReminderImpl) then) =
      __$$ReminderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'collection_item_id') String collectionItemId,
      String title,
      String? message,
      @JsonKey(name: 'inspirational_text') String? inspirationalText,
      @JsonKey(name: 'trigger_type') ReminderTriggerType triggerType,
      ReminderFrequency frequency,
      @JsonKey(name: 'trigger_time') String? triggerTime,
      @JsonKey(name: 'trigger_date') DateTime? triggerDate,
      @JsonKey(name: 'days_of_week') List<DayOfWeek> daysOfWeek,
      @JsonKey(name: 'prayer_time') PrayerTimeOption? prayerTime,
      @JsonKey(name: 'minutes_before_prayer') int minutesBeforePrayer,
      @JsonKey(name: 'minutes_after_prayer') int minutesAfterPrayer,
      @JsonKey(name: 'hijri_month') int? hijriMonth,
      @JsonKey(name: 'hijri_day') int? hijriDay,
      @JsonKey(name: 'is_enabled') bool isEnabled,
      @JsonKey(name: 'sound_enabled') bool soundEnabled,
      @JsonKey(name: 'vibration_enabled') bool vibrationEnabled,
      @JsonKey(name: 'last_triggered') DateTime? lastTriggered,
      @JsonKey(name: 'next_trigger') DateTime? nextTrigger,
      @JsonKey(name: 'total_triggers') int totalTriggers,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$ReminderImplCopyWithImpl<$Res>
    extends _$ReminderCopyWithImpl<$Res, _$ReminderImpl>
    implements _$$ReminderImplCopyWith<$Res> {
  __$$ReminderImplCopyWithImpl(
      _$ReminderImpl _value, $Res Function(_$ReminderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? collectionItemId = null,
    Object? title = null,
    Object? message = freezed,
    Object? inspirationalText = freezed,
    Object? triggerType = null,
    Object? frequency = null,
    Object? triggerTime = freezed,
    Object? triggerDate = freezed,
    Object? daysOfWeek = null,
    Object? prayerTime = freezed,
    Object? minutesBeforePrayer = null,
    Object? minutesAfterPrayer = null,
    Object? hijriMonth = freezed,
    Object? hijriDay = freezed,
    Object? isEnabled = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? lastTriggered = freezed,
    Object? nextTrigger = freezed,
    Object? totalTriggers = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ReminderImpl(
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
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      inspirationalText: freezed == inspirationalText
          ? _value.inspirationalText
          : inspirationalText // ignore: cast_nullable_to_non_nullable
              as String?,
      triggerType: null == triggerType
          ? _value.triggerType
          : triggerType // ignore: cast_nullable_to_non_nullable
              as ReminderTriggerType,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as ReminderFrequency,
      triggerTime: freezed == triggerTime
          ? _value.triggerTime
          : triggerTime // ignore: cast_nullable_to_non_nullable
              as String?,
      triggerDate: freezed == triggerDate
          ? _value.triggerDate
          : triggerDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      daysOfWeek: null == daysOfWeek
          ? _value._daysOfWeek
          : daysOfWeek // ignore: cast_nullable_to_non_nullable
              as List<DayOfWeek>,
      prayerTime: freezed == prayerTime
          ? _value.prayerTime
          : prayerTime // ignore: cast_nullable_to_non_nullable
              as PrayerTimeOption?,
      minutesBeforePrayer: null == minutesBeforePrayer
          ? _value.minutesBeforePrayer
          : minutesBeforePrayer // ignore: cast_nullable_to_non_nullable
              as int,
      minutesAfterPrayer: null == minutesAfterPrayer
          ? _value.minutesAfterPrayer
          : minutesAfterPrayer // ignore: cast_nullable_to_non_nullable
              as int,
      hijriMonth: freezed == hijriMonth
          ? _value.hijriMonth
          : hijriMonth // ignore: cast_nullable_to_non_nullable
              as int?,
      hijriDay: freezed == hijriDay
          ? _value.hijriDay
          : hijriDay // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextTrigger: freezed == nextTrigger
          ? _value.nextTrigger
          : nextTrigger // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalTriggers: null == totalTriggers
          ? _value.totalTriggers
          : totalTriggers // ignore: cast_nullable_to_non_nullable
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
class _$ReminderImpl implements _Reminder {
  const _$ReminderImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'collection_item_id') required this.collectionItemId,
      required this.title,
      this.message,
      @JsonKey(name: 'inspirational_text') this.inspirationalText,
      @JsonKey(name: 'trigger_type') required this.triggerType,
      required this.frequency,
      @JsonKey(name: 'trigger_time') this.triggerTime,
      @JsonKey(name: 'trigger_date') this.triggerDate,
      @JsonKey(name: 'days_of_week')
      final List<DayOfWeek> daysOfWeek = const [],
      @JsonKey(name: 'prayer_time') this.prayerTime,
      @JsonKey(name: 'minutes_before_prayer') this.minutesBeforePrayer = 0,
      @JsonKey(name: 'minutes_after_prayer') this.minutesAfterPrayer = 0,
      @JsonKey(name: 'hijri_month') this.hijriMonth,
      @JsonKey(name: 'hijri_day') this.hijriDay,
      @JsonKey(name: 'is_enabled') this.isEnabled = true,
      @JsonKey(name: 'sound_enabled') this.soundEnabled = true,
      @JsonKey(name: 'vibration_enabled') this.vibrationEnabled = true,
      @JsonKey(name: 'last_triggered') this.lastTriggered,
      @JsonKey(name: 'next_trigger') this.nextTrigger,
      @JsonKey(name: 'total_triggers') this.totalTriggers = 0,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _daysOfWeek = daysOfWeek;

  factory _$ReminderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReminderImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'collection_item_id')
  final String collectionItemId;
// Reminder details
  @override
  final String title;
  @override
  final String? message;
  @override
  @JsonKey(name: 'inspirational_text')
  final String? inspirationalText;
// Hadith or verse
// Trigger configuration
  @override
  @JsonKey(name: 'trigger_type')
  final ReminderTriggerType triggerType;
  @override
  final ReminderFrequency frequency;
// Time-based triggers
  @override
  @JsonKey(name: 'trigger_time')
  final String? triggerTime;
// HH:mm format
  @override
  @JsonKey(name: 'trigger_date')
  final DateTime? triggerDate;
  final List<DayOfWeek> _daysOfWeek;
  @override
  @JsonKey(name: 'days_of_week')
  List<DayOfWeek> get daysOfWeek {
    if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daysOfWeek);
  }

// Prayer-based triggers
  @override
  @JsonKey(name: 'prayer_time')
  final PrayerTimeOption? prayerTime;
  @override
  @JsonKey(name: 'minutes_before_prayer')
  final int minutesBeforePrayer;
  @override
  @JsonKey(name: 'minutes_after_prayer')
  final int minutesAfterPrayer;
// Islamic calendar
  @override
  @JsonKey(name: 'hijri_month')
  final int? hijriMonth;
// 1-12
  @override
  @JsonKey(name: 'hijri_day')
  final int? hijriDay;
// 1-30
// Notification settings
  @override
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;
  @override
  @JsonKey(name: 'sound_enabled')
  final bool soundEnabled;
  @override
  @JsonKey(name: 'vibration_enabled')
  final bool vibrationEnabled;
// Tracking
  @override
  @JsonKey(name: 'last_triggered')
  final DateTime? lastTriggered;
  @override
  @JsonKey(name: 'next_trigger')
  final DateTime? nextTrigger;
  @override
  @JsonKey(name: 'total_triggers')
  final int totalTriggers;
// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Reminder(id: $id, userId: $userId, collectionItemId: $collectionItemId, title: $title, message: $message, inspirationalText: $inspirationalText, triggerType: $triggerType, frequency: $frequency, triggerTime: $triggerTime, triggerDate: $triggerDate, daysOfWeek: $daysOfWeek, prayerTime: $prayerTime, minutesBeforePrayer: $minutesBeforePrayer, minutesAfterPrayer: $minutesAfterPrayer, hijriMonth: $hijriMonth, hijriDay: $hijriDay, isEnabled: $isEnabled, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, lastTriggered: $lastTriggered, nextTrigger: $nextTrigger, totalTriggers: $totalTriggers, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.collectionItemId, collectionItemId) ||
                other.collectionItemId == collectionItemId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.inspirationalText, inspirationalText) ||
                other.inspirationalText == inspirationalText) &&
            (identical(other.triggerType, triggerType) ||
                other.triggerType == triggerType) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.triggerTime, triggerTime) ||
                other.triggerTime == triggerTime) &&
            (identical(other.triggerDate, triggerDate) ||
                other.triggerDate == triggerDate) &&
            const DeepCollectionEquality()
                .equals(other._daysOfWeek, _daysOfWeek) &&
            (identical(other.prayerTime, prayerTime) ||
                other.prayerTime == prayerTime) &&
            (identical(other.minutesBeforePrayer, minutesBeforePrayer) ||
                other.minutesBeforePrayer == minutesBeforePrayer) &&
            (identical(other.minutesAfterPrayer, minutesAfterPrayer) ||
                other.minutesAfterPrayer == minutesAfterPrayer) &&
            (identical(other.hijriMonth, hijriMonth) ||
                other.hijriMonth == hijriMonth) &&
            (identical(other.hijriDay, hijriDay) ||
                other.hijriDay == hijriDay) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
            (identical(other.nextTrigger, nextTrigger) ||
                other.nextTrigger == nextTrigger) &&
            (identical(other.totalTriggers, totalTriggers) ||
                other.totalTriggers == totalTriggers) &&
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
        message,
        inspirationalText,
        triggerType,
        frequency,
        triggerTime,
        triggerDate,
        const DeepCollectionEquality().hash(_daysOfWeek),
        prayerTime,
        minutesBeforePrayer,
        minutesAfterPrayer,
        hijriMonth,
        hijriDay,
        isEnabled,
        soundEnabled,
        vibrationEnabled,
        lastTriggered,
        nextTrigger,
        totalTriggers,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderImplCopyWith<_$ReminderImpl> get copyWith =>
      __$$ReminderImplCopyWithImpl<_$ReminderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReminderImplToJson(
      this,
    );
  }
}

abstract class _Reminder implements Reminder {
  const factory _Reminder(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'collection_item_id')
      required final String collectionItemId,
      required final String title,
      final String? message,
      @JsonKey(name: 'inspirational_text') final String? inspirationalText,
      @JsonKey(name: 'trigger_type')
      required final ReminderTriggerType triggerType,
      required final ReminderFrequency frequency,
      @JsonKey(name: 'trigger_time') final String? triggerTime,
      @JsonKey(name: 'trigger_date') final DateTime? triggerDate,
      @JsonKey(name: 'days_of_week') final List<DayOfWeek> daysOfWeek,
      @JsonKey(name: 'prayer_time') final PrayerTimeOption? prayerTime,
      @JsonKey(name: 'minutes_before_prayer') final int minutesBeforePrayer,
      @JsonKey(name: 'minutes_after_prayer') final int minutesAfterPrayer,
      @JsonKey(name: 'hijri_month') final int? hijriMonth,
      @JsonKey(name: 'hijri_day') final int? hijriDay,
      @JsonKey(name: 'is_enabled') final bool isEnabled,
      @JsonKey(name: 'sound_enabled') final bool soundEnabled,
      @JsonKey(name: 'vibration_enabled') final bool vibrationEnabled,
      @JsonKey(name: 'last_triggered') final DateTime? lastTriggered,
      @JsonKey(name: 'next_trigger') final DateTime? nextTrigger,
      @JsonKey(name: 'total_triggers') final int totalTriggers,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$ReminderImpl;

  factory _Reminder.fromJson(Map<String, dynamic> json) =
      _$ReminderImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'collection_item_id')
  String get collectionItemId; // Reminder details
  @override
  String get title;
  @override
  String? get message;
  @override
  @JsonKey(name: 'inspirational_text')
  String? get inspirationalText; // Hadith or verse
// Trigger configuration
  @override
  @JsonKey(name: 'trigger_type')
  ReminderTriggerType get triggerType;
  @override
  ReminderFrequency get frequency; // Time-based triggers
  @override
  @JsonKey(name: 'trigger_time')
  String? get triggerTime; // HH:mm format
  @override
  @JsonKey(name: 'trigger_date')
  DateTime? get triggerDate;
  @override
  @JsonKey(name: 'days_of_week')
  List<DayOfWeek> get daysOfWeek; // Prayer-based triggers
  @override
  @JsonKey(name: 'prayer_time')
  PrayerTimeOption? get prayerTime;
  @override
  @JsonKey(name: 'minutes_before_prayer')
  int get minutesBeforePrayer;
  @override
  @JsonKey(name: 'minutes_after_prayer')
  int get minutesAfterPrayer; // Islamic calendar
  @override
  @JsonKey(name: 'hijri_month')
  int? get hijriMonth; // 1-12
  @override
  @JsonKey(name: 'hijri_day')
  int? get hijriDay; // 1-30
// Notification settings
  @override
  @JsonKey(name: 'is_enabled')
  bool get isEnabled;
  @override
  @JsonKey(name: 'sound_enabled')
  bool get soundEnabled;
  @override
  @JsonKey(name: 'vibration_enabled')
  bool get vibrationEnabled; // Tracking
  @override
  @JsonKey(name: 'last_triggered')
  DateTime? get lastTriggered;
  @override
  @JsonKey(name: 'next_trigger')
  DateTime? get nextTrigger;
  @override
  @JsonKey(name: 'total_triggers')
  int get totalTriggers; // Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Reminder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderImplCopyWith<_$ReminderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
