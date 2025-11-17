import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

/// Content status for books
enum ContentStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('verified')
  verified,
  @JsonValue('published')
  published,
}

/// Book model representing Islamic texts and literature
@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    @JsonKey(name: 'title_ar') required String titleAr,
    @JsonKey(name: 'title_en') required String titleEn,
    @JsonKey(name: 'author_ar') required String authorAr,
    @JsonKey(name: 'author_en') required String authorEn,
    @JsonKey(name: 'total_sections') @Default(0) int totalSections,
    @JsonKey(name: 'total_paragraphs') @Default(0) int totalParagraphs,
    @Default('ar') String language,
    @JsonKey(name: 'pdf_url') String? pdfUrl,
    @Default('1.0') String version,
    @JsonKey(name: 'verified_by') String? verifiedBy,
    @JsonKey(name: 'content_status') @Default(ContentStatus.draft) ContentStatus contentStatus,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    String? description,
    @Default([]) List<String> topics,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}

/// Extension methods for Book
extension BookExtensions on Book {
  /// Get localized title based on language
  String getTitle(String languageCode) {
    return languageCode == 'ar' ? titleAr : titleEn;
  }

  /// Get localized author based on language
  String getAuthor(String languageCode) {
    return languageCode == 'ar' ? authorAr : authorEn;
  }

  /// Check if book is published
  bool get isPublished => contentStatus == ContentStatus.published;

  /// Check if book is verified
  bool get isVerified =>
      contentStatus == ContentStatus.verified ||
      contentStatus == ContentStatus.published;

  /// Get reading progress estimate in minutes
  int get estimatedReadingTime {
    // Assuming 200 words per minute and average 150 words per paragraph
    return (totalParagraphs * 150 / 200).ceil();
  }
}
