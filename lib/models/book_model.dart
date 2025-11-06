import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final String authorAr;
  final String authorEn;
  final int totalSections;
  final int totalParagraphs;
  final String language;
  final String? pdfUrl;
  final String? coverImageUrl;
  final String version;
  final String verifiedBy;
  final String contentStatus;
  final DateTime createdAt;
  final String description Ar;
  final String descriptionEn;
  final List<String> tags;

  BookModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.authorAr,
    required this.authorEn,
    required this.totalSections,
    required this.totalParagraphs,
    required this.language,
    this.pdfUrl,
    this.coverImageUrl,
    required this.version,
    required this.verifiedBy,
    required this.contentStatus,
    required this.createdAt,
    this.descriptionAr = '',
    this.descriptionEn = '',
    this.tags = const [],
  });

  factory BookModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookModel(
      id: doc.id,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      authorAr: data['author_ar'] ?? '',
      authorEn: data['author_en'] ?? '',
      totalSections: data['total_sections'] ?? 0,
      totalParagraphs: data['total_paragraphs'] ?? 0,
      language: data['language'] ?? 'arabic',
      pdfUrl: data['pdf_url'],
      coverImageUrl: data['cover_image_url'],
      version: data['version'] ?? '1.0',
      verifiedBy: data['verified_by'] ?? '',
      contentStatus: data['content_status'] ?? 'pending',
      createdAt: (data['created_at'] as Timestamp).toDate(),
      descriptionAr: data['description_ar'] ?? '',
      descriptionEn: data['description_en'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title_ar': titleAr,
      'title_en': titleEn,
      'author_ar': authorAr,
      'author_en': authorEn,
      'total_sections': totalSections,
      'total_paragraphs': totalParagraphs,
      'language': language,
      'pdf_url': pdfUrl,
      'cover_image_url': coverImageUrl,
      'version': version,
      'verified_by': verifiedBy,
      'content_status': contentStatus,
      'created_at': Timestamp.fromDate(createdAt),
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'tags': tags,
    };
  }
}

class SectionModel {
  final String id;
  final String bookId;
  final String bookTitleAr;
  final int sectionNumber;
  final String titleAr;
  final String titleEn;
  final int paragraphCount;
  final String pageRange;
  final String difficultyLevel;
  final List<String> topics;

  SectionModel({
    required this.id,
    required this.bookId,
    required this.bookTitleAr,
    required this.sectionNumber,
    required this.titleAr,
    required this.titleEn,
    required this.paragraphCount,
    required this.pageRange,
    required this.difficultyLevel,
    this.topics = const [],
  });

  factory SectionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SectionModel(
      id: doc.id,
      bookId: data['book_id'] ?? '',
      bookTitleAr: data['book_title_ar'] ?? '',
      sectionNumber: data['section_number'] ?? 0,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      paragraphCount: data['paragraph_count'] ?? 0,
      pageRange: data['page_range'] ?? '',
      difficultyLevel: data['difficulty_level'] ?? 'basic',
      topics: List<String>.from(data['topics'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'book_id': bookId,
      'book_title_ar': bookTitleAr,
      'section_number': sectionNumber,
      'title_ar': titleAr,
      'title_en': titleEn,
      'paragraph_count': paragraphCount,
      'page_range': pageRange,
      'difficulty_level': difficultyLevel,
      'topics': topics,
    };
  }
}

class ParagraphModel {
  final String id;
  final String bookId;
  final String sectionId;
  final String sectionTitleAr;
  final int paragraphNumber;
  final int pageNumber;
  final ParagraphContent content;
  final ParagraphEntities entities;
  final SearchData searchData;
  final ParagraphReferences references;
  final ParagraphMetadata metadata;

  ParagraphModel({
    required this.id,
    required this.bookId,
    required this.sectionId,
    required this.sectionTitleAr,
    required this.paragraphNumber,
    required this.pageNumber,
    required this.content,
    required this.entities,
    required this.searchData,
    required this.references,
    required this.metadata,
  });

  factory ParagraphModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ParagraphModel(
      id: doc.id,
      bookId: data['book_id'] ?? '',
      sectionId: data['section_id'] ?? '',
      sectionTitleAr: data['section_title_ar'] ?? '',
      paragraphNumber: data['paragraph_number'] ?? 0,
      pageNumber: data['page_number'] ?? 0,
      content: ParagraphContent.fromMap(data['content'] as Map<String, dynamic>),
      entities: ParagraphEntities.fromMap(data['entities'] as Map<String, dynamic>),
      searchData: SearchData.fromMap(data['search_data'] as Map<String, dynamic>),
      references: ParagraphReferences.fromMap(data['references'] as Map<String, dynamic>),
      metadata: ParagraphMetadata.fromMap(data['metadata'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'book_id': bookId,
      'section_id': sectionId,
      'section_title_ar': sectionTitleAr,
      'paragraph_number': paragraphNumber,
      'page_number': pageNumber,
      'content': content.toMap(),
      'entities': entities.toMap(),
      'search_data': searchData.toMap(),
      'references': references.toMap(),
      'metadata': metadata.toMap(),
    };
  }
}

class ParagraphContent {
  final String textAr;
  final String textEn;

  ParagraphContent({required this.textAr, required this.textEn});

  factory ParagraphContent.fromMap(Map<String, dynamic> map) {
    return ParagraphContent(
      textAr: map['text_ar'] ?? '',
      textEn: map['text_en'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'text_ar': textAr, 'text_en': textEn};
  }
}

class ParagraphEntities {
  final List<String> people;
  final List<String> places;
  final List<String> events;
  final List<String> dates;

  ParagraphEntities({
    this.people = const [],
    this.places = const [],
    this.events = const [],
    this.dates = const [],
  });

  factory ParagraphEntities.fromMap(Map<String, dynamic> map) {
    return ParagraphEntities(
      people: List<String>.from(map['people'] ?? []),
      places: List<String>.from(map['places'] ?? []),
      events: List<String>.from(map['events'] ?? []),
      dates: List<String>.from(map['dates'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'people': people,
      'places': places,
      'events': events,
      'dates': dates,
    };
  }
}

class SearchData {
  final List<String> keywordsAr;
  final List<String> keywordsEn;

  SearchData({this.keywordsAr = const [], this.keywordsEn = const []});

  factory SearchData.fromMap(Map<String, dynamic> map) {
    return SearchData(
      keywordsAr: List<String>.from(map['keywords_ar'] ?? []),
      keywordsEn: List<String>.from(map['keywords_en'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keywords_ar': keywordsAr,
      'keywords_en': keywordsEn,
    };
  }
}

class ParagraphReferences {
  final List<String> referencedInQuestions;
  final List<String> relatedParagraphs;

  ParagraphReferences({
    this.referencedInQuestions = const [],
    this.relatedParagraphs = const [],
  });

  factory ParagraphReferences.fromMap(Map<String, dynamic> map) {
    return ParagraphReferences(
      referencedInQuestions: List<String>.from(map['referenced_in_questions'] ?? []),
      relatedParagraphs: List<String>.from(map['related_paragraphs'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'referenced_in_questions': referencedInQuestions,
      'related_paragraphs': relatedParagraphs,
    };
  }
}

class ParagraphMetadata {
  final String difficulty;
  final int readingTimeSeconds;
  final QuestionPotential questionPotential;
  final String contentPriority;

  ParagraphMetadata({
    required this.difficulty,
    required this.readingTimeSeconds,
    required this.questionPotential,
    required this.contentPriority,
  });

  factory ParagraphMetadata.fromMap(Map<String, dynamic> map) {
    return ParagraphMetadata(
      difficulty: map['difficulty'] ?? 'basic',
      readingTimeSeconds: map['reading_time_seconds'] ?? 30,
      questionPotential: QuestionPotential.fromMap(
        map['question_potential'] as Map<String, dynamic>,
      ),
      contentPriority: map['content_priority'] ?? 'medium',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'difficulty': difficulty,
      'reading_time_seconds': readingTimeSeconds,
      'question_potential': questionPotential.toMap(),
      'content_priority': contentPriority,
    };
  }
}

class QuestionPotential {
  final int factsCount;
  final bool canGenerateQuestions;

  QuestionPotential({required this.factsCount, required this.canGenerateQuestions});

  factory QuestionPotential.fromMap(Map<String, dynamic> map) {
    return QuestionPotential(
      factsCount: map['facts_count'] ?? 0,
      canGenerateQuestions: map['can_generate_questions'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'facts_count': factsCount,
      'can_generate_questions': canGenerateQuestions,
    };
  }
}
