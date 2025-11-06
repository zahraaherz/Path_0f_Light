import 'package:cloud_firestore/cloud_firestore.dart';

enum QuestionDifficulty {
  basic,
  intermediate,
  advanced,
  expert,
}

enum QuestionCategory {
  prophetMuhammad,
  twelveImams,
  ladyFatimah,
  companions,
  quran,
  history,
  practices,
  ethics,
}

class QuestionOption {
  final String textAr;
  final String textEn;

  QuestionOption({
    required this.textAr,
    required this.textEn,
  });

  factory QuestionOption.fromMap(Map<String, dynamic> map) {
    return QuestionOption(
      textAr: map['text_ar'] ?? '',
      textEn: map['text_en'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text_ar': textAr,
      'text_en': textEn,
    };
  }
}

class QuestionSource {
  final String paragraphId;
  final String bookId;
  final String exactQuoteAr;
  final int pageNumber;

  QuestionSource({
    required this.paragraphId,
    required this.bookId,
    required this.exactQuoteAr,
    required this.pageNumber,
  });

  factory QuestionSource.fromMap(Map<String, dynamic> map) {
    return QuestionSource(
      paragraphId: map['paragraph_id'] ?? '',
      bookId: map['book_id'] ?? '',
      exactQuoteAr: map['exact_quote_ar'] ?? '',
      pageNumber: map['page_number'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paragraph_id': paragraphId,
      'book_id': bookId,
      'exact_quote_ar': exactQuoteAr,
      'page_number': pageNumber,
    };
  }
}

class QuestionModel {
  final String id;
  final QuestionCategory category;
  final QuestionDifficulty difficulty;
  final String questionAr;
  final String questionEn;
  final Map<String, QuestionOption> options; // A, B, C, D
  final String correctAnswer; // 'A', 'B', 'C', or 'D'
  final QuestionSource source;
  final String explanationAr;
  final String explanationEn;
  final int points;
  final List<String> tags;
  final DateTime createdAt;
  final String verifiedBy;

  QuestionModel({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.questionAr,
    required this.questionEn,
    required this.options,
    required this.correctAnswer,
    required this.source,
    required this.explanationAr,
    required this.explanationEn,
    required this.points,
    this.tags = const [],
    required this.createdAt,
    required this.verifiedBy,
  });

  factory QuestionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Parse options
    final optionsMap = <String, QuestionOption>{};
    final optionsData = data['options'] as Map<String, dynamic>;
    optionsData.forEach((key, value) {
      optionsMap[key] = QuestionOption.fromMap(value as Map<String, dynamic>);
    });

    return QuestionModel(
      id: doc.id,
      category: _parseCategoryFromString(data['category'] ?? ''),
      difficulty: _parseDifficultyFromString(data['difficulty'] ?? ''),
      questionAr: data['question_ar'] ?? '',
      questionEn: data['question_en'] ?? '',
      options: optionsMap,
      correctAnswer: data['correct_answer'] ?? 'A',
      source: QuestionSource.fromMap(data['source'] as Map<String, dynamic>),
      explanationAr: data['explanation_ar'] ?? '',
      explanationEn: data['explanation_en'] ?? '',
      points: data['points'] ?? 10,
      tags: List<String>.from(data['tags'] ?? []),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      verifiedBy: data['verified_by'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    final optionsMap = <String, dynamic>{};
    options.forEach((key, value) {
      optionsMap[key] = value.toMap();
    });

    return {
      'category': _categoryToString(category),
      'difficulty': _difficultyToString(difficulty),
      'question_ar': questionAr,
      'question_en': questionEn,
      'options': optionsMap,
      'correct_answer': correctAnswer,
      'source': source.toMap(),
      'explanation_ar': explanationAr,
      'explanation_en': explanationEn,
      'points': points,
      'tags': tags,
      'created_at': Timestamp.fromDate(createdAt),
      'verified_by': verifiedBy,
    };
  }

  // Helper methods for enum conversion
  static QuestionCategory _parseCategoryFromString(String category) {
    switch (category) {
      case 'prophet_muhammad':
        return QuestionCategory.prophetMuhammad;
      case 'twelve_imams':
        return QuestionCategory.twelveImams;
      case 'lady_fatimah':
        return QuestionCategory.ladyFatimah;
      case 'companions':
        return QuestionCategory.companions;
      case 'quran':
        return QuestionCategory.quran;
      case 'history':
        return QuestionCategory.history;
      case 'practices':
        return QuestionCategory.practices;
      case 'ethics':
        return QuestionCategory.ethics;
      default:
        return QuestionCategory.history;
    }
  }

  static String _categoryToString(QuestionCategory category) {
    switch (category) {
      case QuestionCategory.prophetMuhammad:
        return 'prophet_muhammad';
      case QuestionCategory.twelveImams:
        return 'twelve_imams';
      case QuestionCategory.ladyFatimah:
        return 'lady_fatimah';
      case QuestionCategory.companions:
        return 'companions';
      case QuestionCategory.quran:
        return 'quran';
      case QuestionCategory.history:
        return 'history';
      case QuestionCategory.practices:
        return 'practices';
      case QuestionCategory.ethics:
        return 'ethics';
    }
  }

  static QuestionDifficulty _parseDifficultyFromString(String difficulty) {
    switch (difficulty) {
      case 'basic':
        return QuestionDifficulty.basic;
      case 'intermediate':
        return QuestionDifficulty.intermediate;
      case 'advanced':
        return QuestionDifficulty.advanced;
      case 'expert':
        return QuestionDifficulty.expert;
      default:
        return QuestionDifficulty.basic;
    }
  }

  static String _difficultyToString(QuestionDifficulty difficulty) {
    switch (difficulty) {
      case QuestionDifficulty.basic:
        return 'basic';
      case QuestionDifficulty.intermediate:
        return 'intermediate';
      case QuestionDifficulty.advanced:
        return 'advanced';
      case QuestionDifficulty.expert:
        return 'expert';
    }
  }
}
