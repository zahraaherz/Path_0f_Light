import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

/// User's bookmark for a specific paragraph
@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'book_id') required String bookId,
    @JsonKey(name: 'book_title_ar') required String bookTitleAr,
    @JsonKey(name: 'book_title_en') String? bookTitleEn,
    @JsonKey(name: 'section_id') required String sectionId,
    @JsonKey(name: 'section_title_ar') required String sectionTitleAr,
    @JsonKey(name: 'section_title_en') String? sectionTitleEn,
    @JsonKey(name: 'paragraph_id') required String paragraphId,
    @JsonKey(name: 'paragraph_number') required int paragraphNumber,
    @JsonKey(name: 'page_number') required int pageNumber,
    String? note,
    @Default([]) List<String> tags,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
  }) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);
}

/// Extension methods for Bookmark
extension BookmarkExtensions on Bookmark {
  /// Get localized book title
  String getBookTitle(String languageCode) {
    if (languageCode == 'ar') return bookTitleAr;
    return bookTitleEn ?? bookTitleAr;
  }

  /// Get localized section title
  String getSectionTitle(String languageCode) {
    if (languageCode == 'ar') return sectionTitleAr;
    return sectionTitleEn ?? sectionTitleAr;
  }

  /// Check if bookmark has a note
  bool get hasNote => note != null && note!.isNotEmpty;

  /// Check if bookmark has tags
  bool get hasTags => tags.isNotEmpty;

  /// Get page reference (e.g., "Page 15, Para 3")
  String get pageReference => 'Page $pageNumber, Para $paragraphNumber';

  /// Check if recently created (within last 7 days)
  bool get isRecentlyCreated {
    if (createdAt == null) return false;
    final daysSinceCreated = DateTime.now().difference(createdAt!).inDays;
    return daysSinceCreated <= 7;
  }

  /// Check if recently updated (within last 7 days)
  bool get isRecentlyUpdated {
    if (updatedAt == null) return false;
    final daysSinceUpdated = DateTime.now().difference(updatedAt!).inDays;
    return daysSinceUpdated <= 7;
  }
}

/// User's highlight for a specific text
@freezed
class Highlight with _$Highlight {
  const factory Highlight({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'book_id') required String bookId,
    @JsonKey(name: 'paragraph_id') required String paragraphId,
    @JsonKey(name: 'highlighted_text') required String highlightedText,
    @JsonKey(name: 'highlight_color') @Default('#FFEB3B') String highlightColor,
    String? note,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Highlight;

  factory Highlight.fromJson(Map<String, dynamic> json) =>
      _$HighlightFromJson(json);
}

/// Extension methods for Highlight
extension HighlightExtensions on Highlight {
  /// Check if highlight has a note
  bool get hasNote => note != null && note!.isNotEmpty;

  /// Get text preview (first 50 characters)
  String get textPreview {
    if (highlightedText.length <= 50) return highlightedText;
    return '${highlightedText.substring(0, 50)}...';
  }
}
