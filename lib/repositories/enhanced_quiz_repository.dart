import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/quiz/quiz_models.dart';

class EnhancedQuizRepository {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;

  EnhancedQuizRepository({
    required this.firestore,
    required this.functions,
  });

  /// Create a new quiz session
  Future<Map<String, dynamic>> createSession({
    String? category,
    String? difficulty,
    int totalQuestions = 10,
  }) async {
    try {
      final callable = functions.httpsCallable('createQuizSession');
      final result = await callable.call({
        'category': category,
        'difficulty': difficulty,
        'totalQuestions': totalQuestions,
      });

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw Exception('Failed to create session: $e');
    }
  }

  /// Get quiz questions
  Future<List<EnhancedQuestion>> getQuestions({
    String? category,
    String? difficulty,
    String? questionType,
    int limit = 10,
    List<String> excludeIds = const [],
  }) async {
    try {
      final callable = functions.httpsCallable('getEnhancedQuestions');
      final result = await callable.call({
        'category': category,
        'difficulty': difficulty,
        'questionType': questionType,
        'limit': limit,
        'excludeIds': excludeIds,
      });

      final data = result.data as Map<String, dynamic>;
      final questionsData = data['questions'] as List<dynamic>;

      return questionsData
          .map((q) => EnhancedQuestion.fromJson(Map<String, dynamic>.from(q)))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch questions: $e');
    }
  }

  /// Submit answer
  Future<AnswerResult> submitAnswer({
    required String sessionId,
    required String questionId,
    required String selectedAnswer,
    int? timeSpent,
  }) async {
    try {
      final callable = functions.httpsCallable('submitAnswer');
      final result = await callable.call({
        'sessionId': sessionId,
        'questionId': questionId,
        'selectedAnswer': selectedAnswer,
        'timeSpent': timeSpent,
      });

      final data = result.data as Map<String, dynamic>;
      final resultData = data['result'] as Map<String, dynamic>;

      return AnswerResult.fromJson(resultData);
    } catch (e) {
      throw Exception('Failed to submit answer: $e');
    }
  }

  /// Complete session
  Future<QuizSummary> completeSession({
    required String sessionId,
    required int durationSeconds,
  }) async {
    try {
      final callable = functions.httpsCallable('completeQuizSession');
      final result = await callable.call({
        'sessionId': sessionId,
        'durationSeconds': durationSeconds,
      });

      final data = result.data as Map<String, dynamic>;
      final summaryData = data['summary'] as Map<String, dynamic>;

      return QuizSummary.fromJson(summaryData);
    } catch (e) {
      throw Exception('Failed to complete session: $e');
    }
  }

  /// Find random match
  Future<Map<String, dynamic>> findRandomMatch({
    String? category,
    String? difficulty,
  }) async {
    try {
      final callable = functions.httpsCallable('findRandomMatch');
      final result = await callable.call({
        'category': category,
        'difficulty': difficulty,
      });

      final data = result.data as Map<String, dynamic>;
      return Map<String, dynamic>.from(data['opponent']);
    } catch (e) {
      throw Exception('Failed to find match: $e');
    }
  }

  /// Create challenge
  Future<Map<String, dynamic>> createChallenge({
    required String opponentId,
    String? category,
    String? difficulty,
    int totalQuestions = 10,
  }) async {
    try {
      final callable = functions.httpsCallable('createChallenge');
      final result = await callable.call({
        'opponentId': opponentId,
        'category': category,
        'difficulty': difficulty,
        'totalQuestions': totalQuestions,
      });

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw Exception('Failed to create challenge: $e');
    }
  }

  /// Accept challenge
  Future<void> acceptChallenge({required String challengeId}) async {
    try {
      final callable = functions.httpsCallable('acceptChallenge');
      await callable.call({'challengeId': challengeId});
    } catch (e) {
      throw Exception('Failed to accept challenge: $e');
    }
  }

  /// Update challenge progress
  Future<void> updateChallengeProgress({
    required String challengeId,
    required int score,
    required int progress,
  }) async {
    try {
      final callable = functions.httpsCallable('updateChallengeProgress');
      await callable.call({
        'challengeId': challengeId,
        'score': score,
        'progress': progress,
      });
    } catch (e) {
      throw Exception('Failed to update progress: $e');
    }
  }

  /// Complete challenge
  Future<Map<String, dynamic>> completeChallenge({
    required String challengeId,
  }) async {
    try {
      final callable = functions.httpsCallable('completeChallenge');
      final result = await callable.call({'challengeId': challengeId});

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw Exception('Failed to complete challenge: $e');
    }
  }

  /// Save book to collection
  Future<void> saveBook({required String bookId}) async {
    try {
      final callable = functions.httpsCallable('saveBookToCollection');
      await callable.call({'bookId': bookId});
    } catch (e) {
      throw Exception('Failed to save book: $e');
    }
  }

  /// Get user's saved books
  Stream<List<String>> watchSavedBooks(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('saved_books')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  /// Get challenge updates in real-time
  Stream<Map<String, dynamic>> watchChallenge(String challengeId) {
    return firestore
        .collection('challenges')
        .doc(challengeId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return {};
      }
      return snapshot.data() as Map<String, dynamic>;
    });
  }
}
