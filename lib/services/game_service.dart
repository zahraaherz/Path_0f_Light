import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_of_light/models/question.dart';
import 'package:path_of_light/models/level.dart';

class GameService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get questions by category and difficulty
  Future<List<Question>> getQuestionsByCategoryAndDifficulty({
    required QuestionCategory category,
    required DifficultyLevel difficulty,
    int limit = 10,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('questions')
          .where('category', isEqualTo: _categoryToString(category))
          .where('difficulty', isEqualTo: _difficultyToString(difficulty))
          .where('is_active', isEqualTo: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) => Question.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching questions: $e');
      return [];
    }
  }

  // Get random questions
  Future<List<Question>> getRandomQuestions({
    int limit = 10,
    DifficultyLevel? difficulty,
  }) async {
    try {
      Query query = _firestore
          .collection('questions')
          .where('is_active', isEqualTo: true);

      if (difficulty != null) {
        query = query.where('difficulty', isEqualTo: _difficultyToString(difficulty));
      }

      final snapshot = await query.limit(limit * 2).get();

      List<Question> questions = snapshot.docs
          .map((doc) => Question.fromFirestore(doc))
          .toList();

      // Shuffle and return limited results
      questions.shuffle();
      return questions.take(limit).toList();
    } catch (e) {
      print('Error fetching random questions: $e');
      return [];
    }
  }

  // Get level by ID
  Future<Level?> getLevelById(String levelId) async {
    try {
      final doc = await _firestore.collection('levels').doc(levelId).get();
      if (doc.exists) {
        return Level.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error fetching level: $e');
      return null;
    }
  }

  // Get levels by category
  Future<List<Level>> getLevelsByCategory(QuestionCategory category) async {
    try {
      final snapshot = await _firestore
          .collection('levels')
          .where('category', isEqualTo: _categoryToString(category))
          .orderBy('level_number')
          .get();

      return snapshot.docs.map((doc) => Level.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching levels: $e');
      return [];
    }
  }

  // Get all levels
  Future<List<Level>> getAllLevels() async {
    try {
      final snapshot = await _firestore
          .collection('levels')
          .orderBy('level_number')
          .get();

      return snapshot.docs.map((doc) => Level.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching all levels: $e');
      return [];
    }
  }

  // Get questions for a specific level
  Future<List<Question>> getQuestionsForLevel(Level level) async {
    try {
      if (level.questionIds.isEmpty) {
        // If no specific questions, get random questions matching criteria
        return await getQuestionsByCategoryAndDifficulty(
          category: level.category,
          difficulty: level.difficulty,
          limit: level.totalQuestions,
        );
      }

      // Get specific questions by ID
      List<Question> questions = [];
      for (String questionId in level.questionIds) {
        final doc = await _firestore.collection('questions').doc(questionId).get();
        if (doc.exists) {
          questions.add(Question.fromFirestore(doc));
        }
      }

      return questions;
    } catch (e) {
      print('Error fetching level questions: $e');
      return [];
    }
  }

  // Get question by ID
  Future<Question?> getQuestionById(String questionId) async {
    try {
      final doc = await _firestore.collection('questions').doc(questionId).get();
      if (doc.exists) {
        return Question.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error fetching question: $e');
      return null;
    }
  }

  // Verify answer
  bool verifyAnswer(Question question, String userAnswer) {
    return question.correctAnswer.toUpperCase() == userAnswer.toUpperCase();
  }

  // Calculate points based on difficulty
  int calculatePoints(DifficultyLevel difficulty, bool isCorrect) {
    if (!isCorrect) return 0;

    switch (difficulty) {
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

  // Helper methods for enum conversion
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
