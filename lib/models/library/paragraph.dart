import 'package:freezed_annotation/freezed_annotation.dart';
import 'section.dart'; // For DifficultyLevel

part 'paragraph.freezed.dart';
part 'paragraph.g.dart';

/// Content priority for paragraphs
enum ContentPriority {
  @JsonValue('high')
  high,
  @JsonValue('medium')
  medium,
  @JsonValue('low')
  low,
}

/// Paragraph content in multiple languages
@freezed
class ParagraphContent with _$ParagraphContent {
  const factory ParagraphContent({
    @JsonKey(name: 'text_ar') required String textAr,
    @JsonKey(name: 'text_en') String? textEn,
  }) = _ParagraphContent;

  factory ParagraphContent.fromJson(Map<String, dynamic> json) =>
      _$ParagraphContentFromJson(json);
}

/// Named entities extracted from paragraph
@freezed
class ParagraphEntities with _$ParagraphEntities {
  const factory ParagraphEntities({
    @Default([]) List<String> people,
    @Default([]) List<String> places,
    @Default([]) List<String> events,
    @Default([]) List<String> dates,
  }) = _ParagraphEntities;

  factory ParagraphEntities.fromJson(Map<String, dynamic> json) =>
      _$ParagraphEntitiesFromJson(json);
}

/// Search keywords for the paragraph
@freezed
class ParagraphSearchData with _$ParagraphSearchData {
  const factory ParagraphSearchData({
    @JsonKey(name: 'keywords_ar') @Default([]) List<String> keywordsAr,
    @JsonKey(name: 'keywords_en') @Default([]) List<String> keywordsEn,
  }) = _ParagraphSearchData;

  factory ParagraphSearchData.fromJson(Map<String, dynamic> json) =>
      _$ParagraphSearchDataFromJson(json);
}

/// References to questions and related paragraphs
@freezed
class ParagraphReferences with _$ParagraphReferences {
  const factory ParagraphReferences({
    @JsonKey(name: 'referenced_in_questions') @Default([]) List<String> referencedInQuestions,
    @JsonKey(name: 'related_paragraphs') @Default([]) List<String> relatedParagraphs,
  }) = _ParagraphReferences;

  factory ParagraphReferences.fromJson(Map<String, dynamic> json) =>
      _$ParagraphReferencesFromJson(json);
}

/// Question generation potential metadata
@freezed
class QuestionPotential with _$QuestionPotential {
  const factory QuestionPotential({
    @JsonKey(name: 'facts_count') @Default(0) int factsCount,
    @JsonKey(name: 'can_generate_questions') @Default(false) bool canGenerateQuestions,
  }) = _QuestionPotential;

  factory QuestionPotential.fromJson(Map<String, dynamic> json) =>
      _$QuestionPotentialFromJson(json);
}

/// Metadata about the paragraph
@freezed
class ParagraphMetadata with _$ParagraphMetadata {
  const factory ParagraphMetadata({
    @Default(DifficultyLevel.basic) DifficultyLevel difficulty,
    @JsonKey(name: 'reading_time_seconds') @Default(0) int readingTimeSeconds,
    @JsonKey(name: 'question_potential') QuestionPotential? questionPotential,
    @JsonKey(name: 'content_priority') @Default(ContentPriority.medium) ContentPriority contentPriority,
  }) = _ParagraphMetadata;

  factory ParagraphMetadata.fromJson(Map<String, dynamic> json) =>
      _$ParagraphMetadataFromJson(json);
}

/// Paragraph model representing individual text segments with rich metadata
@freezed
class Paragraph with _$Paragraph {
  const factory Paragraph({
    required String id,
    @JsonKey(name: 'book_id') required String bookId,
    @JsonKey(name: 'section_id') required String sectionId,
    @JsonKey(name: 'section_title_ar') required String sectionTitleAr,
    @JsonKey(name: 'section_title_en') String? sectionTitleEn,
    @JsonKey(name: 'paragraph_number') required int paragraphNumber,
    @JsonKey(name: 'page_number') required int pageNumber,
    required ParagraphContent content,
    @Default(ParagraphEntities()) ParagraphEntities entities,
    @JsonKey(name: 'search_data') @Default(ParagraphSearchData()) ParagraphSearchData searchData,
    @Default(ParagraphReferences()) ParagraphReferences references,
    @Default(ParagraphMetadata()) ParagraphMetadata metadata,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Paragraph;

  factory Paragraph.fromJson(Map<String, dynamic> json) =>
      _$ParagraphFromJson(json);
}

/// Extension methods for Paragraph
extension ParagraphExtensions on Paragraph {
  /// Get localized text based on language
  String getText(String languageCode) {
    if (languageCode == 'ar') return content.textAr;
    return content.textEn ?? content.textAr;
  }

  /// Get localized section title based on language
  String getSectionTitle(String languageCode) {
    if (languageCode == 'ar') return sectionTitleAr;
    return sectionTitleEn ?? sectionTitleAr;
  }

  /// Check if paragraph has questions referencing it
  bool get hasQuestions => references.referencedInQuestions.isNotEmpty;

  /// Get total number of entities
  int get totalEntities =>
      entities.people.length +
      entities.places.length +
      entities.events.length +
      entities.dates.length;

  /// Check if paragraph is high priority
  bool get isHighPriority => metadata.contentPriority == ContentPriority.high;

  /// Check if paragraph can generate questions
  bool get canGenerateQuestions =>
      metadata.questionPotential?.canGenerateQuestions ?? false;

  /// Get estimated reading time in human-readable format
  String get readingTimeFormatted {
    final seconds = metadata.readingTimeSeconds;
    if (seconds < 60) {
      return '$seconds seconds';
    }
    final minutes = (seconds / 60).ceil();
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
  }

  /// Get all keywords combined
  List<String> get allKeywords => [
        ...searchData.keywordsAr,
        ...searchData.keywordsEn,
      ];

  /// Get text length
  int get textLength => content.textAr.length;

  /// Get word count (approximate)
  int get wordCount => content.textAr.split(RegExp(r'\s+')).length;
}
