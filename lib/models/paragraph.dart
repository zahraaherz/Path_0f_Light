import 'package:cloud_firestore/cloud_firestore.dart';

class ParagraphContent {
  final String textAr;
  final String textEn;

  ParagraphContent({
    required this.textAr,
    required this.textEn,
  });

  factory ParagraphContent.fromMap(Map<String, dynamic> data) {
    return ParagraphContent(
      textAr: data['text_ar'] ?? '',
      textEn: data['text_en'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text_ar': textAr,
      'text_en': textEn,
    };
  }
}

class ParagraphEntities {
  final List<String> people;
  final List<String> places;
  final List<String> events;
  final List<String> dates;

  ParagraphEntities({
    required this.people,
    required this.places,
    required this.events,
    required this.dates,
  });

  factory ParagraphEntities.fromMap(Map<String, dynamic> data) {
    return ParagraphEntities(
      people: List<String>.from(data['people'] ?? []),
      places: List<String>.from(data['places'] ?? []),
      events: List<String>.from(data['events'] ?? []),
      dates: List<String>.from(data['dates'] ?? []),
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

  SearchData({
    required this.keywordsAr,
    required this.keywordsEn,
  });

  factory SearchData.fromMap(Map<String, dynamic> data) {
    return SearchData(
      keywordsAr: List<String>.from(data['keywords_ar'] ?? []),
      keywordsEn: List<String>.from(data['keywords_en'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keywords_ar': keywordsAr,
      'keywords_en': keywordsEn,
    };
  }
}

class Paragraph {
  final String id;
  final String bookId;
  final String sectionId;
  final String sectionTitleAr;
  final int paragraphNumber;
  final int pageNumber;
  final ParagraphContent content;
  final ParagraphEntities entities;
  final SearchData searchData;
  final List<String> referencedInQuestions;
  final List<String> relatedParagraphs;
  final String difficulty;
  final int readingTimeSeconds;
  final bool canGenerateQuestions;
  final String contentPriority;

  Paragraph({
    required this.id,
    required this.bookId,
    required this.sectionId,
    required this.sectionTitleAr,
    required this.paragraphNumber,
    required this.pageNumber,
    required this.content,
    required this.entities,
    required this.searchData,
    required this.referencedInQuestions,
    required this.relatedParagraphs,
    required this.difficulty,
    required this.readingTimeSeconds,
    required this.canGenerateQuestions,
    required this.contentPriority,
  });

  factory Paragraph.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Paragraph(
      id: doc.id,
      bookId: data['book_id'] ?? '',
      sectionId: data['section_id'] ?? '',
      sectionTitleAr: data['section_title_ar'] ?? '',
      paragraphNumber: data['paragraph_number'] ?? 0,
      pageNumber: data['page_number'] ?? 0,
      content: ParagraphContent.fromMap(data['content'] ?? {}),
      entities: ParagraphEntities.fromMap(data['entities'] ?? {}),
      searchData: SearchData.fromMap(data['search_data'] ?? {}),
      referencedInQuestions: List<String>.from(
          (data['references'] ?? {})['referenced_in_questions'] ?? []),
      relatedParagraphs: List<String>.from(
          (data['references'] ?? {})['related_paragraphs'] ?? []),
      difficulty: (data['metadata'] ?? {})['difficulty'] ?? 'basic',
      readingTimeSeconds: (data['metadata'] ?? {})['reading_time_seconds'] ?? 30,
      canGenerateQuestions:
          (data['metadata'] ?? {})['question_potential']?['can_generate_questions'] ?? false,
      contentPriority: (data['metadata'] ?? {})['content_priority'] ?? 'medium',
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
      'references': {
        'referenced_in_questions': referencedInQuestions,
        'related_paragraphs': relatedParagraphs,
      },
      'metadata': {
        'difficulty': difficulty,
        'reading_time_seconds': readingTimeSeconds,
        'question_potential': {
          'can_generate_questions': canGenerateQuestions,
        },
        'content_priority': contentPriority,
      },
    };
  }
}
