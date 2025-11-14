import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayer_times.freezed.dart';
part 'prayer_times.g.dart';

/// Prayer time entry
@freezed
class PrayerTime with _$PrayerTime {
  const factory PrayerTime({
    required String name,
    required String arabicName,
    required String time,
    required bool isPassed,
    String? iqamaTime,
  }) = _PrayerTime;

  factory PrayerTime.fromJson(Map<String, dynamic> json) =>
      _$PrayerTimeFromJson(json);
}

/// Daily prayer times
@freezed
class DailyPrayerTimes with _$DailyPrayerTimes {
  const factory DailyPrayerTimes({
    required DateTime date,
    required PrayerTime fajr,
    required PrayerTime sunrise,
    required PrayerTime dhuhr,
    required PrayerTime asr,
    required PrayerTime maghrib,
    required PrayerTime isha,
    String? nextPrayer,
    String? timeUntilNext,
  }) = _DailyPrayerTimes;

  factory DailyPrayerTimes.fromJson(Map<String, dynamic> json) =>
      _$DailyPrayerTimesFromJson(json);
}
