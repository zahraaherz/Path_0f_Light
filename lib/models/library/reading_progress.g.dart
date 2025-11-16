// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReadingProgressImpl _$$ReadingProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$ReadingProgressImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      bookId: json['book_id'] as String,
      bookTitleAr: json['book_title_ar'] as String,
      bookTitleEn: json['book_title_en'] as String?,
      currentSectionId: json['current_section_id'] as String?,
      currentParagraphId: json['current_paragraph_id'] as String?,
      paragraphsRead: (json['paragraphs_read'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      totalParagraphs: (json['total_paragraphs'] as num?)?.toInt() ?? 0,
      progressPercentage:
          (json['progress_percentage'] as num?)?.toDouble() ?? 0.0,
      lastReadDate: json['last_read_date'] == null
          ? null
          : DateTime.parse(json['last_read_date'] as String),
      totalReadingTimeMinutes:
          (json['total_reading_time_minutes'] as num?)?.toInt() ?? 0,
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      isCompleted: json['is_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReadingProgressImplToJson(
        _$ReadingProgressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'book_id': instance.bookId,
      'book_title_ar': instance.bookTitleAr,
      'book_title_en': instance.bookTitleEn,
      'current_section_id': instance.currentSectionId,
      'current_paragraph_id': instance.currentParagraphId,
      'paragraphs_read': instance.paragraphsRead,
      'total_paragraphs': instance.totalParagraphs,
      'progress_percentage': instance.progressPercentage,
      'last_read_date': instance.lastReadDate?.toIso8601String(),
      'total_reading_time_minutes': instance.totalReadingTimeMinutes,
      'started_at': instance.startedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'is_completed': instance.isCompleted,
    };
