// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masoom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MasoomImpl _$$MasoomImplFromJson(Map<String, dynamic> json) => _$MasoomImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      arabicName: json['arabicName'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabicTitle'] as String,
      order: (json['order'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      birthPlace: json['birthPlace'] as String,
      birthDate: json['birthDate'] as String,
      deathPlace: json['deathPlace'] as String?,
      deathDate: json['deathDate'] as String?,
      shortBio: json['shortBio'] as String,
      notableEvents: (json['notableEvents'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      teachings:
          (json['teachings'] as List<dynamic>).map((e) => e as String).toList(),
      quizCount: (json['quizCount'] as num).toInt(),
    );

Map<String, dynamic> _$$MasoomImplToJson(_$MasoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'arabicName': instance.arabicName,
      'title': instance.title,
      'arabicTitle': instance.arabicTitle,
      'order': instance.order,
      'imageUrl': instance.imageUrl,
      'birthPlace': instance.birthPlace,
      'birthDate': instance.birthDate,
      'deathPlace': instance.deathPlace,
      'deathDate': instance.deathDate,
      'shortBio': instance.shortBio,
      'notableEvents': instance.notableEvents,
      'teachings': instance.teachings,
      'quizCount': instance.quizCount,
    };
