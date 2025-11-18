// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'islamic_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IslamicEventImpl _$$IslamicEventImplFromJson(Map<String, dynamic> json) =>
    _$IslamicEventImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabicTitle'] as String,
      description: json['description'] as String?,
      type: $enumDecode(_$IslamicEventTypeEnumMap, json['type']),
      hijriDate: json['hijriDate'] as String,
      hijriMonth: (json['hijriMonth'] as num?)?.toInt(),
      hijriDay: (json['hijriDay'] as num?)?.toInt(),
      gregorianDate: json['gregorianDate'] as String?,
      significance: json['significance'] as String?,
      recommendations: (json['recommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String?,
      isToday: json['isToday'] as bool? ?? false,
      isUpcoming: json['isUpcoming'] as bool? ?? false,
    );

Map<String, dynamic> _$$IslamicEventImplToJson(_$IslamicEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'arabicTitle': instance.arabicTitle,
      'description': instance.description,
      'type': _$IslamicEventTypeEnumMap[instance.type]!,
      'hijriDate': instance.hijriDate,
      'hijriMonth': instance.hijriMonth,
      'hijriDay': instance.hijriDay,
      'gregorianDate': instance.gregorianDate,
      'significance': instance.significance,
      'recommendations': instance.recommendations,
      'imageUrl': instance.imageUrl,
      'isToday': instance.isToday,
      'isUpcoming': instance.isUpcoming,
    };

const _$IslamicEventTypeEnumMap = {
  IslamicEventType.birth: 'birth',
  IslamicEventType.martyrdom: 'martyrdom',
  IslamicEventType.occasion: 'occasion',
  IslamicEventType.fastingDay: 'fastingDay',
  IslamicEventType.celebration: 'celebration',
};

_$HijriDateImpl _$$HijriDateImplFromJson(Map<String, dynamic> json) =>
    _$HijriDateImpl(
      day: (json['day'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      monthName: json['monthName'] as String,
      monthNameArabic: json['monthNameArabic'] as String,
      weekdayName: json['weekdayName'] as String?,
      weekdayNameArabic: json['weekdayNameArabic'] as String?,
    );

Map<String, dynamic> _$$HijriDateImplToJson(_$HijriDateImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'monthName': instance.monthName,
      'monthNameArabic': instance.monthNameArabic,
      'weekdayName': instance.weekdayName,
      'weekdayNameArabic': instance.weekdayNameArabic,
    };
