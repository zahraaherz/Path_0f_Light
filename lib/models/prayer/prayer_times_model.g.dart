// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerTimesModelImpl _$$PrayerTimesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PrayerTimesModelImpl(
      date: DateTime.parse(json['date'] as String),
      fajr: DateTime.parse(json['fajr'] as String),
      sunrise: DateTime.parse(json['sunrise'] as String),
      dhuhr: DateTime.parse(json['dhuhr'] as String),
      asr: DateTime.parse(json['asr'] as String),
      maghrib: DateTime.parse(json['maghrib'] as String),
      isha: DateTime.parse(json['isha'] as String),
      midnight: DateTime.parse(json['midnight'] as String),
      locationName: json['locationName'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$PrayerTimesModelImplToJson(
        _$PrayerTimesModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'fajr': instance.fajr.toIso8601String(),
      'sunrise': instance.sunrise.toIso8601String(),
      'dhuhr': instance.dhuhr.toIso8601String(),
      'asr': instance.asr.toIso8601String(),
      'maghrib': instance.maghrib.toIso8601String(),
      'isha': instance.isha.toIso8601String(),
      'midnight': instance.midnight.toIso8601String(),
      'locationName': instance.locationName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
