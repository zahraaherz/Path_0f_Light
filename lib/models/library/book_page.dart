import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_page.freezed.dart';
part 'book_page.g.dart';

/// Book page model with image and optional OCR text
@freezed
class BookPage with _$BookPage {
  const factory BookPage({
    @JsonKey(name: 'page_id') required String pageId,
    @JsonKey(name: 'book_id') required String bookId,
    @JsonKey(name: 'page_number') required int pageNumber,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'storage_path') required String storagePath,
    @JsonKey(name: 'text_content') String? textContent,
    @JsonKey(name: 'word_count') @Default(0) int wordCount,
    @JsonKey(name: 'character_count') @Default(0) int characterCount,
    @JsonKey(name: 'has_ocr') @Default(false) bool hasOcr,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _BookPage;

  factory BookPage.fromJson(Map<String, dynamic> json) =>
      _$BookPageFromJson(json);
}

/// Extension methods for BookPage
extension BookPageExtensions on BookPage {
  /// Check if page has text content
  bool get hasText => textContent != null && textContent!.isNotEmpty;

  /// Get text preview (first 100 characters)
  String get textPreview {
    if (!hasText) return '';
    return textContent!.length > 100
        ? '${textContent!.substring(0, 100)}...'
        : textContent!;
  }

  /// Get estimated reading time in seconds
  int get estimatedReadingTime {
    if (!hasText) return 0;
    // Assuming 200 words per minute = 3.33 words per second
    return (wordCount / 3.33).ceil();
  }
}
