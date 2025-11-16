// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderImpl _$$ReminderImplFromJson(Map<String, dynamic> json) =>
    _$ReminderImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      collectionItemId: json['collection_item_id'] as String,
      title: json['title'] as String,
      message: json['message'] as String?,
      inspirationalText: json['inspirational_text'] as String?,
      triggerType:
          $enumDecode(_$ReminderTriggerTypeEnumMap, json['trigger_type']),
      frequency: $enumDecode(_$ReminderFrequencyEnumMap, json['frequency']),
      triggerTime: json['trigger_time'] as String?,
      triggerDate: json['trigger_date'] == null
          ? null
          : DateTime.parse(json['trigger_date'] as String),
      daysOfWeek: (json['days_of_week'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
              .toList() ??
          const [],
      prayerTime:
          $enumDecodeNullable(_$PrayerTimeOptionEnumMap, json['prayer_time']),
      minutesBeforePrayer:
          (json['minutes_before_prayer'] as num?)?.toInt() ?? 0,
      minutesAfterPrayer: (json['minutes_after_prayer'] as num?)?.toInt() ?? 0,
      hijriMonth: (json['hijri_month'] as num?)?.toInt(),
      hijriDay: (json['hijri_day'] as num?)?.toInt(),
      isEnabled: json['is_enabled'] as bool? ?? true,
      soundEnabled: json['sound_enabled'] as bool? ?? true,
      vibrationEnabled: json['vibration_enabled'] as bool? ?? true,
      lastTriggered: json['last_triggered'] == null
          ? null
          : DateTime.parse(json['last_triggered'] as String),
      nextTrigger: json['next_trigger'] == null
          ? null
          : DateTime.parse(json['next_trigger'] as String),
      totalTriggers: (json['total_triggers'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ReminderImplToJson(_$ReminderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'collection_item_id': instance.collectionItemId,
      'title': instance.title,
      'message': instance.message,
      'inspirational_text': instance.inspirationalText,
      'trigger_type': _$ReminderTriggerTypeEnumMap[instance.triggerType]!,
      'frequency': _$ReminderFrequencyEnumMap[instance.frequency]!,
      'trigger_time': instance.triggerTime,
      'trigger_date': instance.triggerDate?.toIso8601String(),
      'days_of_week':
          instance.daysOfWeek.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
      'prayer_time': _$PrayerTimeOptionEnumMap[instance.prayerTime],
      'minutes_before_prayer': instance.minutesBeforePrayer,
      'minutes_after_prayer': instance.minutesAfterPrayer,
      'hijri_month': instance.hijriMonth,
      'hijri_day': instance.hijriDay,
      'is_enabled': instance.isEnabled,
      'sound_enabled': instance.soundEnabled,
      'vibration_enabled': instance.vibrationEnabled,
      'last_triggered': instance.lastTriggered?.toIso8601String(),
      'next_trigger': instance.nextTrigger?.toIso8601String(),
      'total_triggers': instance.totalTriggers,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ReminderTriggerTypeEnumMap = {
  ReminderTriggerType.time: 'time',
  ReminderTriggerType.prayerTime: 'prayerTime',
  ReminderTriggerType.date: 'date',
  ReminderTriggerType.dayOfWeek: 'dayOfWeek',
  ReminderTriggerType.islamicDate: 'islamicDate',
};

const _$ReminderFrequencyEnumMap = {
  ReminderFrequency.once: 'once',
  ReminderFrequency.daily: 'daily',
  ReminderFrequency.weekly: 'weekly',
  ReminderFrequency.monthly: 'monthly',
  ReminderFrequency.custom: 'custom',
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 'monday',
  DayOfWeek.tuesday: 'tuesday',
  DayOfWeek.wednesday: 'wednesday',
  DayOfWeek.thursday: 'thursday',
  DayOfWeek.friday: 'friday',
  DayOfWeek.saturday: 'saturday',
  DayOfWeek.sunday: 'sunday',
};

const _$PrayerTimeOptionEnumMap = {
  PrayerTimeOption.fajr: 'fajr',
  PrayerTimeOption.sunrise: 'sunrise',
  PrayerTimeOption.dhuhr: 'dhuhr',
  PrayerTimeOption.asr: 'asr',
  PrayerTimeOption.maghrib: 'maghrib',
  PrayerTimeOption.isha: 'isha',
};
