import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

/// Type of reminder trigger
enum ReminderTriggerType {
  time, // Specific time of day
  prayerTime, // Before/after a prayer
  date, // Specific date
  dayOfWeek, // Specific day(s) of the week
  islamicDate, // Islamic calendar date
}

/// Prayer time options for reminders
enum PrayerTimeOption {
  fajr,
  sunrise,
  dhuhr,
  asr,
  maghrib,
  isha,
}

/// Day of the week for recurring reminders
enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

/// Reminder frequency
enum ReminderFrequency {
  once, // One-time reminder
  daily, // Every day
  weekly, // Every week
  monthly, // Every month
  custom, // Custom recurring pattern
}

/// Reminder for a collection item
@freezed
class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'collection_item_id') required String collectionItemId,

    // Reminder details
    required String title,
    String? message,
    @JsonKey(name: 'inspirational_text') String? inspirationalText, // Hadith or verse

    // Trigger configuration
    @JsonKey(name: 'trigger_type') required ReminderTriggerType triggerType,
    required ReminderFrequency frequency,

    // Time-based triggers
    @JsonKey(name: 'trigger_time') String? triggerTime, // HH:mm format
    @JsonKey(name: 'trigger_date') DateTime? triggerDate,
    @JsonKey(name: 'days_of_week') @Default([]) List<DayOfWeek> daysOfWeek,

    // Prayer-based triggers
    @JsonKey(name: 'prayer_time') PrayerTimeOption? prayerTime,
    @JsonKey(name: 'minutes_before_prayer') @Default(0) int minutesBeforePrayer,
    @JsonKey(name: 'minutes_after_prayer') @Default(0) int minutesAfterPrayer,

    // Islamic calendar
    @JsonKey(name: 'hijri_month') int? hijriMonth, // 1-12
    @JsonKey(name: 'hijri_day') int? hijriDay, // 1-30

    // Notification settings
    @JsonKey(name: 'is_enabled') @Default(true) bool isEnabled,
    @JsonKey(name: 'sound_enabled') @Default(true) bool soundEnabled,
    @JsonKey(name: 'vibration_enabled') @Default(true) bool vibrationEnabled,

    // Tracking
    @JsonKey(name: 'last_triggered') DateTime? lastTriggered,
    @JsonKey(name: 'next_trigger') DateTime? nextTrigger,
    @JsonKey(name: 'total_triggers') @Default(0) int totalTriggers,

    // Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}

/// Extension methods for Reminder
extension ReminderExtensions on Reminder {
  /// Get frequency display name
  String getFrequencyName() {
    switch (frequency) {
      case ReminderFrequency.once:
        return 'Once';
      case ReminderFrequency.daily:
        return 'Daily';
      case ReminderFrequency.weekly:
        return 'Weekly';
      case ReminderFrequency.monthly:
        return 'Monthly';
      case ReminderFrequency.custom:
        return 'Custom';
    }
  }

  /// Get trigger type display name
  String getTriggerTypeName() {
    switch (triggerType) {
      case ReminderTriggerType.time:
        return 'Specific Time';
      case ReminderTriggerType.prayerTime:
        return 'Prayer Time';
      case ReminderTriggerType.date:
        return 'Specific Date';
      case ReminderTriggerType.dayOfWeek:
        return 'Day of Week';
      case ReminderTriggerType.islamicDate:
        return 'Islamic Date';
    }
  }

  /// Get prayer time display name
  String? getPrayerTimeName() {
    if (prayerTime == null) return null;
    switch (prayerTime!) {
      case PrayerTimeOption.fajr:
        return 'Fajr';
      case PrayerTimeOption.sunrise:
        return 'Sunrise';
      case PrayerTimeOption.dhuhr:
        return 'Dhuhr';
      case PrayerTimeOption.asr:
        return 'Asr';
      case PrayerTimeOption.maghrib:
        return 'Maghrib';
      case PrayerTimeOption.isha:
        return 'Isha';
    }
  }

  /// Get formatted trigger description
  String getTriggerDescription() {
    switch (triggerType) {
      case ReminderTriggerType.time:
        if (triggerTime != null) {
          return 'At $triggerTime';
        }
        return 'Time not set';

      case ReminderTriggerType.prayerTime:
        if (prayerTime != null) {
          String desc = getPrayerTimeName()!;
          if (minutesBeforePrayer > 0) {
            desc += ' - $minutesBeforePrayer min before';
          } else if (minutesAfterPrayer > 0) {
            desc += ' + $minutesAfterPrayer min after';
          }
          return desc;
        }
        return 'Prayer time not set';

      case ReminderTriggerType.date:
        if (triggerDate != null) {
          return 'On ${triggerDate!.day}/${triggerDate!.month}/${triggerDate!.year}';
        }
        return 'Date not set';

      case ReminderTriggerType.dayOfWeek:
        if (daysOfWeek.isNotEmpty) {
          return daysOfWeek.map((d) => _getDayName(d)).join(', ');
        }
        return 'Days not set';

      case ReminderTriggerType.islamicDate:
        if (hijriMonth != null && hijriDay != null) {
          return 'Islamic: $hijriDay/${_getHijriMonthName(hijriMonth!)}';
        }
        return 'Islamic date not set';
    }
  }

  /// Get day name
  String _getDayName(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.monday:
        return 'Mon';
      case DayOfWeek.tuesday:
        return 'Tue';
      case DayOfWeek.wednesday:
        return 'Wed';
      case DayOfWeek.thursday:
        return 'Thu';
      case DayOfWeek.friday:
        return 'Fri';
      case DayOfWeek.saturday:
        return 'Sat';
      case DayOfWeek.sunday:
        return 'Sun';
    }
  }

  /// Get Hijri month name
  String _getHijriMonthName(int month) {
    const months = [
      'Muharram',
      'Safar',
      'Rabi\' al-Awwal',
      'Rabi\' al-Thani',
      'Jumada al-Awwal',
      'Jumada al-Thani',
      'Rajab',
      'Sha\'ban',
      'Ramadhan',
      'Shawwal',
      'Dhu al-Qi\'dah',
      'Dhu al-Hijjah'
    ];
    return months[month - 1];
  }

  /// Check if reminder is active (enabled and has future trigger)
  bool get isActive {
    if (!isEnabled) return false;
    if (frequency == ReminderFrequency.once && nextTrigger != null) {
      return nextTrigger!.isAfter(DateTime.now());
    }
    return true;
  }

  /// Check if reminder is overdue (next trigger passed)
  bool get isOverdue {
    if (nextTrigger == null) return false;
    return nextTrigger!.isBefore(DateTime.now()) && isEnabled;
  }

  /// Get time until next trigger (in minutes)
  int? get minutesUntilNextTrigger {
    if (nextTrigger == null) return null;
    final diff = nextTrigger!.difference(DateTime.now());
    return diff.inMinutes;
  }

  /// Format time until next trigger
  String? get formattedTimeUntilNext {
    final minutes = minutesUntilNextTrigger;
    if (minutes == null) return null;

    if (minutes < 0) return 'Overdue';
    if (minutes < 60) return 'In $minutes min';
    if (minutes < 1440) {
      final hours = minutes ~/ 60;
      return 'In $hours hour${hours > 1 ? 's' : ''}';
    }
    final days = minutes ~/ 1440;
    return 'In $days day${days > 1 ? 's' : ''}';
  }
}
