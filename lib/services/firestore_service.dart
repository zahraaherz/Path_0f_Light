import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/question_model.dart';
import '../models/book_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ===== USER OPERATIONS =====

  // Get user data
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw 'Failed to fetch user data';
    }
  }

  // Update user data
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      throw 'Failed to update user data';
    }
  }

  // Stream user data
  Stream<UserModel?> streamUser(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);
  }

  // Update user hearts
  Future<void> updateUserHearts(String uid, int hearts) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'heartsRemaining': hearts,
        'lastHeartRefill': Timestamp.now(),
      });
    } catch (e) {
      throw 'Failed to update hearts';
    }
  }

  // Update quiz statistics
  Future<void> updateQuizStats(
    String uid, {
    required int pointsEarned,
    required bool isCorrect,
  }) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        final totalPoints = (userData['totalPoints'] ?? 0) + pointsEarned;
        final questionsAnswered = (userData['questionsAnswered'] ?? 0) + 1;
        final correctAnswers = isCorrect
            ? (userData['correctAnswers'] ?? 0) + 1
            : (userData['correctAnswers'] ?? 0);
        final currentStreak = isCorrect
            ? (userData['currentStreak'] ?? 0) + 1
            : 0;
        final longestStreak = currentStreak > (userData['longestStreak'] ?? 0)
            ? currentStreak
            : (userData['longestStreak'] ?? 0);

        await _firestore.collection('users').doc(uid).update({
          'totalPoints': totalPoints,
          'questionsAnswered': questionsAnswered,
          'correctAnswers': correctAnswers,
          'currentStreak': currentStreak,
          'longestStreak': longestStreak,
        });
      }
    } catch (e) {
      throw 'Failed to update quiz statistics';
    }
  }

  // ===== QUESTION OPERATIONS =====

  // Get questions by category and difficulty
  Future<List<QuestionModel>> getQuestions({
    QuestionCategory? category,
    QuestionDifficulty? difficulty,
    int limit = 10,
  }) async {
    try {
      Query query = _firestore.collection('questions');

      if (category != null) {
        query = query.where('category',
            isEqualTo: _categoryToString(category));
      }

      if (difficulty != null) {
        query = query.where('difficulty',
            isEqualTo: _difficultyToString(difficulty));
      }

      final snapshot = await query.limit(limit).get();

      return snapshot.docs
          .map((doc) => QuestionModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw 'Failed to fetch questions';
    }
  }

  // Get random questions
  Future<List<QuestionModel>> getRandomQuestions({
    QuestionCategory? category,
    QuestionDifficulty? difficulty,
    int count = 10,
  }) async {
    try {
      // Get all matching questions
      final allQuestions = await getQuestions(
        category: category,
        difficulty: difficulty,
        limit: 100,
      );

      // Shuffle and return requested count
      allQuestions.shuffle();
      return allQuestions.take(count).toList();
    } catch (e) {
      throw 'Failed to fetch random questions';
    }
  }

  // Get single question by ID
  Future<QuestionModel?> getQuestion(String questionId) async {
    try {
      final doc = await _firestore.collection('questions').doc(questionId).get();
      if (doc.exists) {
        return QuestionModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw 'Failed to fetch question';
    }
  }

  // ===== BOOK OPERATIONS =====

  // Get all books
  Future<List<BookModel>> getAllBooks() async {
    try {
      final snapshot = await _firestore
          .collection('books')
          .where('content_status', isEqualTo: 'verified')
          .get();

      return snapshot.docs.map((doc) => BookModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw 'Failed to fetch books';
    }
  }

  // Get single book
  Future<BookModel?> getBook(String bookId) async {
    try {
      final doc = await _firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return BookModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw 'Failed to fetch book';
    }
  }

  // Get sections for a book
  Future<List<SectionModel>> getBookSections(String bookId) async {
    try {
      final snapshot = await _firestore
          .collection('sections')
          .where('book_id', isEqualTo: bookId)
          .orderBy('section_number')
          .get();

      return snapshot.docs.map((doc) => SectionModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw 'Failed to fetch book sections';
    }
  }

  // Get paragraphs for a section
  Future<List<ParagraphModel>> getSectionParagraphs(String sectionId) async {
    try {
      final snapshot = await _firestore
          .collection('paragraphs')
          .where('section_id', isEqualTo: sectionId)
          .orderBy('paragraph_number')
          .get();

      return snapshot.docs
          .map((doc) => ParagraphModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw 'Failed to fetch paragraphs';
    }
  }

  // ===== LEADERBOARD OPERATIONS =====

  // Get top users by points
  Future<List<UserModel>> getLeaderboard({int limit = 50}) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .orderBy('totalPoints', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw 'Failed to fetch leaderboard';
    }
  }

  // ===== HELPER METHODS =====

  String _categoryToString(QuestionCategory category) {
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

  String _difficultyToString(QuestionDifficulty difficulty) {
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
