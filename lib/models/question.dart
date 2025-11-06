import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionOption {
  final String textAr;
  final String textEn;

  QuestionOption({
    required this.textAr,
    required this.textEn,
  });

  factory QuestionOption.fromMap(Map<String, dynamic> data) {
    return QuestionOption(
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

  factory QuestionSource.fromMap(Map<String, dynamic> data) {
    return QuestionSource(
      paragraphId: data['paragraph_id'] ?? '',
      bookId: data['book_id'] ?? '',
      exactQuoteAr: data['exact_quote_ar'] ?? '',
      pageNumber: data['page_number'] ?? 0,
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

enum QuestionType {
  multipleChoice,
  trueFalse,
  fillInBlank,
  matching,
  ordering
}

enum QuestionCategory {
  prophetMuhammad,
  imam1Ali,
  imam2Hassan,
  imam3Hussain,
  imam4Sajjad,
  imam5Baqir,
  imam6Sadiq,
  imam7Kadhim,
  imam8Ridha,
  imam9Jawad,
  imam10Hadi,
  imam11Askari,
  imam12Mahdi,
  ladyFatimah,
  companions,
  islamicPractices,
  quranHistory,
  ethics
}

enum DifficultyLevel {
  basic,
  intermediate,
  advanced,
  expert
}

class Question {
  final String id;
  final QuestionCategory category;
  final DifficultyLevel difficulty;
  final QuestionType type;
  final String questionAr;
  final String questionEn;
  final Map<String, QuestionOption> options;
  final String correctAnswer;
  final QuestionSource source;
  final String explanationAr;
  final String explanationEn;
  final int points;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  Question({
    required this.id,
    required this.category,
    required this.difficulty,
    this.type = QuestionType.multipleChoice,
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
    required this.updatedAt,
    this.isActive = true,
  });

  factory Question.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Map<String, QuestionOption> optionsMap = {};
    (data['options'] as Map<String, dynamic>).forEach((key, value) {
      optionsMap[key] = QuestionOption.fromMap(value as Map<String, dynamic>);
    });

    return Question(
      id: doc.id,
      category: _categoryFromString(data['category'] ?? ''),
      difficulty: _difficultyFromString(data['difficulty'] ?? 'basic'),
      type: _typeFromString(data['type'] ?? 'multiple_choice'),
      questionAr: data['question_ar'] ?? '',
      questionEn: data['question_en'] ?? '',
      options: optionsMap,
      correctAnswer: data['correct_answer'] ?? '',
      source: QuestionSource.fromMap(data['source'] ?? {}),
      explanationAr: data['explanation_ar'] ?? '',
      explanationEn: data['explanation_en'] ?? '',
      points: data['points'] ?? 10,
      tags: List<String>.from(data['tags'] ?? []),
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: data['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> optionsMap = {};
    options.forEach((key, value) {
      optionsMap[key] = value.toMap();
    });

    return {
      'category': _categoryToString(category),
      'difficulty': _difficultyToString(difficulty),
      'type': _typeToString(type),
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
      'updated_at': Timestamp.fromDate(updatedAt),
      'is_active': isActive,
    };
  }

  static QuestionCategory _categoryFromString(String value) {
    switch (value) {
      case 'prophet_muhammad':
        return QuestionCategory.prophetMuhammad;
      case 'imam_1_ali':
        return QuestionCategory.imam1Ali;
      case 'imam_2_hassan':
        return QuestionCategory.imam2Hassan;
      case 'imam_3_hussain':
        return QuestionCategory.imam3Hussain;
      case 'imam_4_sajjad':
        return QuestionCategory.imam4Sajjad;
      case 'imam_5_baqir':
        return QuestionCategory.imam5Baqir;
      case 'imam_6_sadiq':
        return QuestionCategory.imam6Sadiq;
      case 'imam_7_kadhim':
        return QuestionCategory.imam7Kadhim;
      case 'imam_8_ridha':
        return QuestionCategory.imam8Ridha;
      case 'imam_9_jawad':
        return QuestionCategory.imam9Jawad;
      case 'imam_10_hadi':
        return QuestionCategory.imam10Hadi;
      case 'imam_11_askari':
        return QuestionCategory.imam11Askari;
      case 'imam_12_mahdi':
        return QuestionCategory.imam12Mahdi;
      case 'lady_fatimah':
        return QuestionCategory.ladyFatimah;
      case 'companions':
        return QuestionCategory.companions;
      case 'islamic_practices':
        return QuestionCategory.islamicPractices;
      case 'quran_history':
        return QuestionCategory.quranHistory;
      case 'ethics':
        return QuestionCategory.ethics;
      default:
        return QuestionCategory.prophetMuhammad;
    }
  }

  static String _categoryToString(QuestionCategory category) {
    switch (category) {
      case QuestionCategory.prophetMuhammad:
        return 'prophet_muhammad';
      case QuestionCategory.imam1Ali:
        return 'imam_1_ali';
      case QuestionCategory.imam2Hassan:
        return 'imam_2_hassan';
      case QuestionCategory.imam3Hussain:
        return 'imam_3_hussain';
      case QuestionCategory.imam4Sajjad:
        return 'imam_4_sajjad';
      case QuestionCategory.imam5Baqir:
        return 'imam_5_baqir';
      case QuestionCategory.imam6Sadiq:
        return 'imam_6_sadiq';
      case QuestionCategory.imam7Kadhim:
        return 'imam_7_kadhim';
      case QuestionCategory.imam8Ridha:
        return 'imam_8_ridha';
      case QuestionCategory.imam9Jawad:
        return 'imam_9_jawad';
      case QuestionCategory.imam10Hadi:
        return 'imam_10_hadi';
      case QuestionCategory.imam11Askari:
        return 'imam_11_askari';
      case QuestionCategory.imam12Mahdi:
        return 'imam_12_mahdi';
      case QuestionCategory.ladyFatimah:
        return 'lady_fatimah';
      case QuestionCategory.companions:
        return 'companions';
      case QuestionCategory.islamicPractices:
        return 'islamic_practices';
      case QuestionCategory.quranHistory:
        return 'quran_history';
      case QuestionCategory.ethics:
        return 'ethics';
    }
  }

  static DifficultyLevel _difficultyFromString(String value) {
    switch (value) {
      case 'basic':
        return DifficultyLevel.basic;
      case 'intermediate':
        return DifficultyLevel.intermediate;
      case 'advanced':
        return DifficultyLevel.advanced;
      case 'expert':
        return DifficultyLevel.expert;
      default:
        return DifficultyLevel.basic;
    }
  }

  static String _difficultyToString(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.basic:
        return 'basic';
      case DifficultyLevel.intermediate:
        return 'intermediate';
      case DifficultyLevel.advanced:
        return 'advanced';
      case DifficultyLevel.expert:
        return 'expert';
    }
  }

  static QuestionType _typeFromString(String value) {
    switch (value) {
      case 'multiple_choice':
        return QuestionType.multipleChoice;
      case 'true_false':
        return QuestionType.trueFalse;
      case 'fill_in_blank':
        return QuestionType.fillInBlank;
      case 'matching':
        return QuestionType.matching;
      case 'ordering':
        return QuestionType.ordering;
      default:
        return QuestionType.multipleChoice;
    }
  }

  static String _typeToString(QuestionType type) {
    switch (type) {
      case QuestionType.multipleChoice:
        return 'multiple_choice';
      case QuestionType.trueFalse:
        return 'true_false';
      case QuestionType.fillInBlank:
        return 'fill_in_blank';
      case QuestionType.matching:
        return 'matching';
      case QuestionType.ordering:
        return 'ordering';
    }
  }
}
