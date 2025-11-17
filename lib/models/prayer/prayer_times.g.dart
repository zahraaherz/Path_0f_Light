// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerTimeImpl _$$PrayerTimeImplFromJson(Map<String, dynamic> json) =>
    _$PrayerTimeImpl(
      name: json['name'] as String,
      arabicName: json['arabicName'] as String,
      time: json['time'] as String,
      isPassed: json['isPassed'] as bool,
      iqamaTime: json['iqamaTime'] as String?,
    );

Map<String, dynamic> _$$PrayerTimeImplToJson(_$PrayerTimeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'arabicName': instance.arabicName,
      'time': instance.time,
      'isPassed': instance.isPassed,
      'iqamaTime': instance.iqamaTime,
    };

_$DailyPrayerTimesImpl _$$DailyPrayerTimesImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyPrayerTimesImpl(
      date: DateTime.parse(json['date'] as String),
      fajr: PrayerTime.fromJson(json['fajr'] as Map<String, dynamic>),
      sunrise: PrayerTime.fromJson(json['sunrise'] as Map<String, dynamic>),
      dhuhr: PrayerTime.fromJson(json['dhuhr'] as Map<String, dynamic>),
      asr: PrayerTime.fromJson(json['asr'] as Map<String, dynamic>),
      maghrib: PrayerTime.fromJson(json['maghrib'] as Map<String, dynamic>),
      isha: PrayerTime.fromJson(json['isha'] as Map<String, dynamic>),
      nextPrayer: json['nextPrayer'] as String?,
      timeUntilNext: json['timeUntilNext'] as String?,
    );

Map<String, dynamic> _$$DailyPrayerTimesImplToJson(
        _$DailyPrayerTimesImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'fajr': instance.fajr,
      'sunrise': instance.sunrise,
      'dhuhr': instance.dhuhr,
      'asr': instance.asr,
      'maghrib': instance.maghrib,
      'isha': instance.isha,
      'nextPrayer': instance.nextPrayer,
      'timeUntilNext': instance.timeUntilNext,
    };
