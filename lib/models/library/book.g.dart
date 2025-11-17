// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookImpl _$$BookImplFromJson(Map<String, dynamic> json) => _$BookImpl(
      id: json['id'] as String,
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      authorAr: json['author_ar'] as String,
      authorEn: json['author_en'] as String,
      totalSections: (json['total_sections'] as num?)?.toInt() ?? 0,
      totalParagraphs: (json['total_paragraphs'] as num?)?.toInt() ?? 0,
      language: json['language'] as String? ?? 'ar',
      pdfUrl: json['pdf_url'] as String?,
      version: json['version'] as String? ?? '1.0',
      verifiedBy: json['verified_by'] as String?,
      contentStatus:
          $enumDecodeNullable(_$ContentStatusEnumMap, json['content_status']) ??
              ContentStatus.draft,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      description: json['description'] as String?,
      topics: (json['topics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      coverImageUrl: json['cover_image_url'] as String?,
    );

Map<String, dynamic> _$$BookImplToJson(_$BookImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'author_ar': instance.authorAr,
      'author_en': instance.authorEn,
      'total_sections': instance.totalSections,
      'total_paragraphs': instance.totalParagraphs,
      'language': instance.language,
      'pdf_url': instance.pdfUrl,
      'version': instance.version,
      'verified_by': instance.verifiedBy,
      'content_status': _$ContentStatusEnumMap[instance.contentStatus]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'description': instance.description,
      'topics': instance.topics,
      'cover_image_url': instance.coverImageUrl,
    };

const _$ContentStatusEnumMap = {
  ContentStatus.draft: 'draft',
  ContentStatus.verified: 'verified',
  ContentStatus.published: 'published',
};
