// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionImpl _$$SectionImplFromJson(Map<String, dynamic> json) =>
    _$SectionImpl(
      id: json['id'] as String,
      bookId: json['book_id'] as String,
      bookTitleAr: json['book_title_ar'] as String,
      bookTitleEn: json['book_title_en'] as String?,
      sectionNumber: (json['section_number'] as num).toInt(),
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      paragraphCount: (json['paragraph_count'] as num?)?.toInt() ?? 0,
      pageRange: json['page_range'] as String?,
      difficultyLevel: $enumDecodeNullable(
              _$DifficultyLevelEnumMap, json['difficulty_level']) ??
          DifficultyLevel.basic,
      topics: (json['topics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$SectionImplToJson(_$SectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book_id': instance.bookId,
      'book_title_ar': instance.bookTitleAr,
      'book_title_en': instance.bookTitleEn,
      'section_number': instance.sectionNumber,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'paragraph_count': instance.paragraphCount,
      'page_range': instance.pageRange,
      'difficulty_level': _$DifficultyLevelEnumMap[instance.difficultyLevel]!,
      'topics': instance.topics,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.basic: 'basic',
  DifficultyLevel.intermediate: 'intermediate',
  DifficultyLevel.advanced: 'advanced',
  DifficultyLevel.expert: 'expert',
};
