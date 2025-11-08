import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_models.freezed.dart';
part 'book_models.g.dart';

/// Content status enum
enum ContentStatus {
  draft,
  verified,
  published;

  static ContentStatus fromString(String value) {
    return ContentStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => ContentStatus.draft,
    );
  }
}

/// Difficulty level enum
enum DifficultyLevel {
  basic,
  intermediate,
  advanced,
  expert;

  static DifficultyLevel fromString(String value) {
    return DifficultyLevel.values.firstWhere(
      (level) => level.name == value,
      orElse: () => DifficultyLevel.basic,
    );
  }

  String get displayName {
    switch (this) {
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

  int get points {
    switch (this) {
      case DifficultyLevel.basic:
        return 10;
      case DifficultyLevel.intermediate:
        return 15;
      case DifficultyLevel.advanced:
        return 20;
      case DifficultyLevel.expert:
        return 25;
    }
  }
}

/// Content priority enum
enum ContentPriority {
  high,
  medium,
  low;

  static ContentPriority fromString(String value) {
    return ContentPriority.values.firstWhere(
      (priority) => priority.name == value,
      orElse: () => ContentPriority.medium,
    );
  }
}

/// Timestamp converter for Freezed
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

/// Book model
@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String titleAr,
    required String titleEn,
    required String authorAr,
    required String authorEn,
    required String language,
    @Default(ContentStatus.draft) ContentStatus contentStatus,
    @Default(0) int totalSections,
    @Default(0) int totalParagraphs,
    String? pdfUrl,
    @Default('1.0') String version,
    String? verifiedBy,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @TimestampConverter() DateTime? publishedAt,
    String? publishedBy,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  factory Book.fromFirestore(String id, Map<String, dynamic> data) {
    return Book(
      id: id,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      authorAr: data['author_ar'] ?? '',
      authorEn: data['author_en'] ?? '',
      language: data['language'] ?? 'ar',
      contentStatus: ContentStatus.fromString(data['content_status'] ?? 'draft'),
      totalSections: data['total_sections'] ?? 0,
      totalParagraphs: data['total_paragraphs'] ?? 0,
      pdfUrl: data['pdf_url'],
      version: data['version'] ?? '1.0',
      verifiedBy: data['verified_by'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
      publishedAt: data['published_at'] != null
          ? (data['published_at'] as Timestamp).toDate()
          : null,
      publishedBy: data['published_by'],
    );
  }
}

/// Section model
@freezed
class BookSection with _$BookSection {
  const factory BookSection({
    required String id,
    required String bookId,
    required String bookTitleAr,
    String? bookTitleEn,
    required int sectionNumber,
    required String titleAr,
    required String titleEn,
    @Default(DifficultyLevel.basic) DifficultyLevel difficultyLevel,
    @Default([]) List<String> topics,
    @Default(0) int paragraphCount,
    String? pageRange,
    @TimestampConverter() required DateTime createdAt,
  }) = _BookSection;

  factory BookSection.fromJson(Map<String, dynamic> json) =>
      _$BookSectionFromJson(json);

  factory BookSection.fromFirestore(String id, Map<String, dynamic> data) {
    return BookSection(
      id: id,
      bookId: data['book_id'] ?? '',
      bookTitleAr: data['book_title_ar'] ?? '',
      bookTitleEn: data['book_title_en'],
      sectionNumber: data['section_number'] ?? 0,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      difficultyLevel:
          DifficultyLevel.fromString(data['difficulty_level'] ?? 'basic'),
      topics: List<String>.from(data['topics'] ?? []),
      paragraphCount: data['paragraph_count'] ?? 0,
      pageRange: data['page_range'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }
}

/// Entities model for paragraphs
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

/// Search data model
@freezed
class SearchData with _$SearchData {
  const factory SearchData({
    @Default([]) List<String> keywordsAr,
    @Default([]) List<String> keywordsEn,
  }) = _SearchData;

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
}

/// Question potential model
@freezed
class QuestionPotential with _$QuestionPotential {
  const factory QuestionPotential({
    @Default(0) int factsCount,
    @Default(false) bool canGenerateQuestions,
  }) = _QuestionPotential;

  factory QuestionPotential.fromJson(Map<String, dynamic> json) =>
      _$QuestionPotentialFromJson(json);
}

/// Paragraph metadata
@freezed
class ParagraphMetadata with _$ParagraphMetadata {
  const factory ParagraphMetadata({
    @Default(DifficultyLevel.basic) DifficultyLevel difficulty,
    int? readingTimeSeconds,
    QuestionPotential? questionPotential,
    @Default(ContentPriority.medium) ContentPriority contentPriority,
  }) = _ParagraphMetadata;

  factory ParagraphMetadata.fromJson(Map<String, dynamic> json) =>
      _$ParagraphMetadataFromJson(json);
}

/// Content model for bilingual text
@freezed
class BilingualContent with _$BilingualContent {
  const factory BilingualContent({
    required String textAr,
    String? textEn,
  }) = _BilingualContent;

  factory BilingualContent.fromJson(Map<String, dynamic> json) =>
      _$BilingualContentFromJson(json);
}

/// References model
@freezed
class ParagraphReferences with _$ParagraphReferences {
  const factory ParagraphReferences({
    @Default([]) List<String> referencedInQuestions,
    @Default([]) List<String> relatedParagraphs,
  }) = _ParagraphReferences;

  factory ParagraphReferences.fromJson(Map<String, dynamic> json) =>
      _$ParagraphReferencesFromJson(json);
}

/// Paragraph model
@freezed
class Paragraph with _$Paragraph {
  const factory Paragraph({
    required String id,
    required String bookId,
    required String sectionId,
    required String sectionTitleAr,
    String? sectionTitleEn,
    required int paragraphNumber,
    required int pageNumber,
    required BilingualContent content,
    @Default(ParagraphEntities()) ParagraphEntities entities,
    @Default(SearchData()) SearchData searchData,
    @Default(ParagraphReferences()) ParagraphReferences references,
    @Default(ParagraphMetadata()) ParagraphMetadata metadata,
    @TimestampConverter() required DateTime createdAt,
  }) = _Paragraph;

  factory Paragraph.fromJson(Map<String, dynamic> json) =>
      _$ParagraphFromJson(json);

  factory Paragraph.fromFirestore(String id, Map<String, dynamic> data) {
    return Paragraph(
      id: id,
      bookId: data['book_id'] ?? '',
      sectionId: data['section_id'] ?? '',
      sectionTitleAr: data['section_title_ar'] ?? '',
      sectionTitleEn: data['section_title_en'],
      paragraphNumber: data['paragraph_number'] ?? 0,
      pageNumber: data['page_number'] ?? 0,
      content: BilingualContent(
        textAr: data['content']?['text_ar'] ?? '',
        textEn: data['content']?['text_en'],
      ),
      entities: data['entities'] != null
          ? ParagraphEntities.fromJson(
              Map<String, dynamic>.from(data['entities']))
          : const ParagraphEntities(),
      searchData: data['search_data'] != null
          ? SearchData.fromJson(Map<String, dynamic>.from(data['search_data']))
          : const SearchData(),
      references: data['references'] != null
          ? ParagraphReferences.fromJson(
              Map<String, dynamic>.from(data['references']))
          : const ParagraphReferences(),
      metadata: data['metadata'] != null
          ? ParagraphMetadata(
              difficulty: DifficultyLevel.fromString(
                  data['metadata']['difficulty'] ?? 'basic'),
              readingTimeSeconds: data['metadata']['reading_time_seconds'],
              questionPotential: data['metadata']['question_potential'] != null
                  ? QuestionPotential.fromJson(Map<String, dynamic>.from(
                      data['metadata']['question_potential']))
                  : null,
              contentPriority: ContentPriority.fromString(
                  data['metadata']['content_priority'] ?? 'medium'),
            )
          : const ParagraphMetadata(),
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }
}

/// Reading progress model
@freezed
class ReadingProgress with _$ReadingProgress {
  const factory ReadingProgress({
    required String bookId,
    required String sectionId,
    required int currentParagraph,
    required int totalParagraphs,
    @Default(0) int completedParagraphs,
    @TimestampConverter() required DateTime lastReadAt,
  }) = _ReadingProgress;

  factory ReadingProgress.fromJson(Map<String, dynamic> json) =>
      _$ReadingProgressFromJson(json);

  double get progress {
    if (totalParagraphs == 0) return 0.0;
    return completedParagraphs / totalParagraphs;
  }

  bool get isCompleted => completedParagraphs >= totalParagraphs;
}
