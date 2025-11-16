// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkImpl _$$BookmarkImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      bookId: json['book_id'] as String,
      bookTitleAr: json['book_title_ar'] as String,
      bookTitleEn: json['book_title_en'] as String?,
      sectionId: json['section_id'] as String,
      sectionTitleAr: json['section_title_ar'] as String,
      sectionTitleEn: json['section_title_en'] as String?,
      paragraphId: json['paragraph_id'] as String,
      paragraphNumber: (json['paragraph_number'] as num).toInt(),
      pageNumber: (json['page_number'] as num).toInt(),
      note: json['note'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isFavorite: json['is_favorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookmarkImplToJson(_$BookmarkImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'book_id': instance.bookId,
      'book_title_ar': instance.bookTitleAr,
      'book_title_en': instance.bookTitleEn,
      'section_id': instance.sectionId,
      'section_title_ar': instance.sectionTitleAr,
      'section_title_en': instance.sectionTitleEn,
      'paragraph_id': instance.paragraphId,
      'paragraph_number': instance.paragraphNumber,
      'page_number': instance.pageNumber,
      'note': instance.note,
      'tags': instance.tags,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_favorite': instance.isFavorite,
    };

_$HighlightImpl _$$HighlightImplFromJson(Map<String, dynamic> json) =>
    _$HighlightImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      bookId: json['book_id'] as String,
      paragraphId: json['paragraph_id'] as String,
      highlightedText: json['highlighted_text'] as String,
      highlightColor: json['highlight_color'] as String? ?? '#FFEB3B',
      note: json['note'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$HighlightImplToJson(_$HighlightImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'book_id': instance.bookId,
      'paragraph_id': instance.paragraphId,
      'highlighted_text': instance.highlightedText,
      'highlight_color': instance.highlightColor,
      'note': instance.note,
      'created_at': instance.createdAt?.toIso8601String(),
    };
