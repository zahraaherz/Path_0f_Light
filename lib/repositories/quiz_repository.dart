import 'package:cloud_functions/cloud_functions.dart';
import '../models/quiz/quiz_models.dart';

/// Exception class for quiz repository errors
class QuizRepositoryException implements Exception {
  final String message;
  final String code;

  QuizRepositoryException(this.message, this.code);

  @override
  String toString() => message;
}

/// Repository for managing quiz operations
class QuizRepository {
  final FirebaseFunctions _functions;

  QuizRepository({
    FirebaseFunctions? functions,
  }) : _functions = functions ?? FirebaseFunctions.instance;

  /// Get random quiz questions
  /// Checks energy availability before starting
  Future<QuizSession> getQuizQuestions({
    String? category,
    String? difficulty,
    String language = 'en',
    int count = 10,
  }) async {
    try {
      final callable = _functions.httpsCallable('getQuizQuestions');
      final result = await callable.call({
        if (category != null) 'category': category,
        if (difficulty != null) 'difficulty': difficulty,
        'language': language,
        'count': count,
      });

      return QuizSession.fromJson(Map<String, dynamic>.from(result.data));
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'failed-precondition') {
        throw QuizRepositoryException(
          e.message ?? 'Insufficient energy',
          'insufficient-energy',
        );
      }
      throw QuizRepositoryException(
        'Failed to get quiz questions: ${e.message}',
        e.code,
      );
    } catch (e) {
      throw QuizRepositoryException(
        'Failed to get quiz questions: ${e.toString()}',
        'get-questions-failed',
      );
    }
  }

  /// Submit answer for a question
  /// Consumes energy and updates progress
  Future<AnswerResult> submitQuizAnswer({
    required String questionId,
    required String answer,
    required String sessionId,
    String language = 'en',
  }) async {
    try {
      final callable = _functions.httpsCallable('submitQuizAnswer');
      final result = await callable.call({
        'questionId': questionId,
        'answer': answer,
        'sessionId': sessionId,
        'language': language,
      });

      return AnswerResult.fromJson(Map<String, dynamic>.from(result.data));
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'failed-precondition') {
        throw QuizRepositoryException(
          e.message ?? 'Insufficient energy',
          'insufficient-energy',
        );
      }
      throw QuizRepositoryException(
        'Failed to submit answer: ${e.message}',
        e.code,
      );
    } catch (e) {
      throw QuizRepositoryException(
        'Failed to submit answer: ${e.toString()}',
        'submit-answer-failed',
      );
    }
  }

  /// Get user's quiz progress and statistics
  Future<Map<String, dynamic>> getUserQuizProgress() async {
    try {
      final callable = _functions.httpsCallable('getUserQuizProgress');
      final result = await callable.call();

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw QuizRepositoryException(
        'Failed to get quiz progress: ${e.toString()}',
        'get-progress-failed',
      );
    }
  }

  /// Get available quiz categories
  Future<List<String>> getQuizCategories() async {
    try {
      final callable = _functions.httpsCallable('getQuizCategories');
      final result = await callable.call();

      final categories = result.data['categories'] as List;
      return categories.map((c) => c.toString()).toList();
    } catch (e) {
      // Return default categories if function doesn't exist
      return [
        'Islamic History',
        'Quran',
        'Hadith',
        'Fiqh',
        'Seerah',
        'Islamic Sciences',
      ];
    }
  }

  /// Complete quiz session and get summary
  Future<QuizSummary> completeQuizSession(String sessionId) async {
    try {
      final callable = _functions.httpsCallable('completeQuizSession');
      final result = await callable.call({'sessionId': sessionId});

      return QuizSummary.fromJson(Map<String, dynamic>.from(result.data));
    } catch (e) {
      throw QuizRepositoryException(
        'Failed to complete quiz session: ${e.toString()}',
        'complete-session-failed',
      );
    }
  }

  /// Dispose resources
  void dispose() {
    // Nothing to dispose for now
  }
}
