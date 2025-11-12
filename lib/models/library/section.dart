import 'package:freezed_annotation/freezed_annotation.dart';

part 'section.freezed.dart';
part 'section.g.dart';

/// Difficulty level for sections
enum DifficultyLevel {
  @JsonValue('basic')
  basic,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('expert')
  expert,
}

/// Section model representing chapters/sections within a book
@freezed
class Section with _$Section {
  const factory Section({
    required String id,
    @JsonKey(name: 'book_id') required String bookId,
    @JsonKey(name: 'book_title_ar') required String bookTitleAr,
    @JsonKey(name: 'book_title_en') String? bookTitleEn,
    @JsonKey(name: 'section_number') required int sectionNumber,
    @JsonKey(name: 'title_ar') required String titleAr,
    @JsonKey(name: 'title_en') required String titleEn,
    @JsonKey(name: 'paragraph_count') @Default(0) int paragraphCount,
    @JsonKey(name: 'page_range') String? pageRange,
    @JsonKey(name: 'difficulty_level') @Default(DifficultyLevel.basic) DifficultyLevel difficultyLevel,
    @Default([]) List<String> topics,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}

/// Extension methods for Section
extension SectionExtensions on Section {
  /// Get localized title based on language
  String getTitle(String languageCode) {
    return languageCode == 'ar' ? titleAr : titleEn;
  }

  /// Get localized book title based on language
  String getBookTitle(String languageCode) {
    if (languageCode == 'ar') return bookTitleAr;
    return bookTitleEn ?? bookTitleAr;
  }

  /// Get difficulty level display name
  String get difficultyName {
    switch (difficultyLevel) {
      case DifficultyLevel.basic:
        return 'Basic';
      case DifficultyLevel.intermediate:
        return 'Intermediate';
      case DifficultyLevel.advanced:
        return 'Advanced';
      case DifficultyLevel.expert:
        return 'Expert';
    }
  }

  /// Get estimated reading time in minutes
  int get estimatedReadingTime {
    // Assuming 200 words per minute and average 150 words per paragraph
    return (paragraphCount * 150 / 200).ceil();
  }

  /// Get difficulty color
  String get difficultyColor {
    switch (difficultyLevel) {
      case DifficultyLevel.basic:
        return '#4CAF50'; // Green
      case DifficultyLevel.intermediate:
        return '#2196F3'; // Blue
      case DifficultyLevel.advanced:
        return '#FF9800'; // Orange
      case DifficultyLevel.expert:
        return '#F44336'; // Red
    }
  }
}
