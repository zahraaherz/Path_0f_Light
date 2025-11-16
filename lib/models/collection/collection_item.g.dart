// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionItemImpl _$$CollectionItemImplFromJson(Map<String, dynamic> json) =>
    _$CollectionItemImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: $enumDecode(_$CollectionItemTypeEnumMap, json['type']),
      title: json['title'] as String,
      arabicTitle: json['arabic_title'] as String?,
      arabicText: json['arabic_text'] as String,
      translation: json['translation'] as String?,
      transliteration: json['transliteration'] as String?,
      category: $enumDecode(_$CollectionCategoryEnumMap, json['category']),
      surahNumber: (json['surah_number'] as num?)?.toInt(),
      ayahNumber: (json['ayah_number'] as num?)?.toInt(),
      juzNumber: (json['juz_number'] as num?)?.toInt(),
      bookReference: json['book_reference'] as String?,
      pageNumber: (json['page_number'] as num?)?.toInt(),
      source: json['source'] as String?,
      notes: json['notes'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      audioUrl: json['audio_url'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      lastAccessed: json['last_accessed'] == null
          ? null
          : DateTime.parse(json['last_accessed'] as String),
    );

Map<String, dynamic> _$$CollectionItemImplToJson(
        _$CollectionItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': _$CollectionItemTypeEnumMap[instance.type]!,
      'title': instance.title,
      'arabic_title': instance.arabicTitle,
      'arabic_text': instance.arabicText,
      'translation': instance.translation,
      'transliteration': instance.transliteration,
      'category': _$CollectionCategoryEnumMap[instance.category]!,
      'surah_number': instance.surahNumber,
      'ayah_number': instance.ayahNumber,
      'juz_number': instance.juzNumber,
      'book_reference': instance.bookReference,
      'page_number': instance.pageNumber,
      'source': instance.source,
      'notes': instance.notes,
      'tags': instance.tags,
      'audio_url': instance.audioUrl,
      'is_favorite': instance.isFavorite,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'last_accessed': instance.lastAccessed?.toIso8601String(),
    };

const _$CollectionItemTypeEnumMap = {
  CollectionItemType.dua: 'dua',
  CollectionItemType.surah: 'surah',
  CollectionItemType.ayah: 'ayah',
  CollectionItemType.ziyarat: 'ziyarat',
  CollectionItemType.hadith: 'hadith',
  CollectionItemType.passage: 'passage',
  CollectionItemType.dhikr: 'dhikr',
  CollectionItemType.custom: 'custom',
};

const _$CollectionCategoryEnumMap = {
  CollectionCategory.morning: 'morning',
  CollectionCategory.evening: 'evening',
  CollectionCategory.friday: 'friday',
  CollectionCategory.ramadhan: 'ramadhan',
  CollectionCategory.muharram: 'muharram',
  CollectionCategory.safar: 'safar',
  CollectionCategory.rajab: 'rajab',
  CollectionCategory.shaban: 'shaban',
  CollectionCategory.daily: 'daily',
  CollectionCategory.weekly: 'weekly',
  CollectionCategory.monthly: 'monthly',
  CollectionCategory.special: 'special',
  CollectionCategory.protection: 'protection',
  CollectionCategory.forgiveness: 'forgiveness',
  CollectionCategory.gratitude: 'gratitude',
  CollectionCategory.healing: 'healing',
  CollectionCategory.guidance: 'guidance',
  CollectionCategory.custom: 'custom',
};
