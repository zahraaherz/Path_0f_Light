// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DuaImpl _$$DuaImplFromJson(Map<String, dynamic> json) => _$DuaImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabicTitle'] as String,
      arabicText: json['arabicText'] as String,
      translation: json['translation'] as String,
      transliteration: json['transliteration'] as String,
      category: $enumDecode(_$DuaCategoryEnumMap, json['category']),
      shortExcerpt: json['shortExcerpt'] as String?,
      meaning: json['meaning'] as String?,
      tafsir: json['tafsir'] as String?,
      source: json['source'] as String?,
      benefits: json['benefits'] as String?,
      audioUrl: json['audioUrl'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      hasTashkeel: json['hasTashkeel'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$DuaImplToJson(_$DuaImpl instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'arabicTitle': instance.arabicTitle,
      'arabicText': instance.arabicText,
      'translation': instance.translation,
      'transliteration': instance.transliteration,
      'category': _$DuaCategoryEnumMap[instance.category]!,
      'shortExcerpt': instance.shortExcerpt,
      'meaning': instance.meaning,
      'tafsir': instance.tafsir,
      'source': instance.source,
      'benefits': instance.benefits,
      'audioUrl': instance.audioUrl,
      'duration': instance.duration,
      'tags': instance.tags,
      'hasTashkeel': instance.hasTashkeel,
      'isFavorite': instance.isFavorite,
    };

const _$DuaCategoryEnumMap = {
  DuaCategory.daily: 'daily',
  DuaCategory.morning: 'morning',
  DuaCategory.evening: 'evening',
  DuaCategory.protection: 'protection',
  DuaCategory.forgiveness: 'forgiveness',
  DuaCategory.knowledge: 'knowledge',
  DuaCategory.health: 'health',
  DuaCategory.family: 'family',
  DuaCategory.special: 'special',
};

_$AudioRecitationImpl _$$AudioRecitationImplFromJson(
        Map<String, dynamic> json) =>
    _$AudioRecitationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabicTitle'] as String,
      reciter: json['reciter'] as String,
      audioUrl: json['audioUrl'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isDownloaded: json['isDownloaded'] as bool? ?? false,
    );

Map<String, dynamic> _$$AudioRecitationImplToJson(
        _$AudioRecitationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'arabicTitle': instance.arabicTitle,
      'reciter': instance.reciter,
      'audioUrl': instance.audioUrl,
      'durationMinutes': instance.durationMinutes,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'isDownloaded': instance.isDownloaded,
    };

_$SpiritualChecklistItemImpl _$$SpiritualChecklistItemImplFromJson(
        Map<String, dynamic> json) =>
    _$SpiritualChecklistItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabicTitle'] as String,
      type: json['type'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      targetCount: (json['targetCount'] as num?)?.toInt(),
      currentCount: (json['currentCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SpiritualChecklistItemImplToJson(
        _$SpiritualChecklistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'arabicTitle': instance.arabicTitle,
      'type': instance.type,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'targetCount': instance.targetCount,
      'currentCount': instance.currentCount,
    };
