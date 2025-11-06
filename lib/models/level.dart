import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_of_light/models/question.dart';

class Level {
  final String id;
  final int levelNumber;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final QuestionCategory category;
  final DifficultyLevel difficulty;
  final int requiredPoints;
  final int totalQuestions;
  final int passingScore;
  final List<String> questionIds;
  final String? rewardDescription;
  final bool isLocked;
  final DateTime createdAt;

  Level({
    required this.id,
    required this.levelNumber,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.category,
    required this.difficulty,
    required this.requiredPoints,
    required this.totalQuestions,
    required this.passingScore,
    required this.questionIds,
    this.rewardDescription,
    this.isLocked = true,
    required this.createdAt,
  });

  factory Level.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Level(
      id: doc.id,
      levelNumber: data['level_number'] ?? 0,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      descriptionAr: data['description_ar'] ?? '',
      descriptionEn: data['description_en'] ?? '',
      category: _categoryFromString(data['category'] ?? ''),
      difficulty: _difficultyFromString(data['difficulty'] ?? 'basic'),
      requiredPoints: data['required_points'] ?? 0,
      totalQuestions: data['total_questions'] ?? 0,
      passingScore: data['passing_score'] ?? 0,
      questionIds: List<String>.from(data['question_ids'] ?? []),
      rewardDescription: data['reward_description'],
      isLocked: data['is_locked'] ?? true,
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'level_number': levelNumber,
      'title_ar': titleAr,
      'title_en': titleEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'category': _categoryToString(category),
      'difficulty': _difficultyToString(difficulty),
      'required_points': requiredPoints,
      'total_questions': totalQuestions,
      'passing_score': passingScore,
      'question_ids': questionIds,
      'reward_description': rewardDescription,
      'is_locked': isLocked,
      'created_at': Timestamp.fromDate(createdAt),
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
}
