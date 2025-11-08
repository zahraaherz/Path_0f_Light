import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quiz/quiz_models.dart';
import '../repositories/quiz_repository.dart';

/// Provider for QuizRepository
final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepository();
});

/// Provider for available quiz categories
final quizCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(quizRepositoryProvider);
  return await repository.getQuizCategories();
});

/// State notifier for quiz session management
class QuizSessionState {
  final QuizSession? session;
  final int currentQuestionIndex;
  final List<AnswerResult> answers;
  final bool isLoading;
  final String? error;
  final DateTime? startTime;

  const QuizSessionState({
    this.session,
    this.currentQuestionIndex = 0,
    this.answers = const [],
    this.isLoading = false,
    this.error,
    this.startTime,
  });

  QuizSessionState copyWith({
    QuizSession? session,
    int? currentQuestionIndex,
    List<AnswerResult>? answers,
    bool? isLoading,
    String? error,
    DateTime? startTime,
  }) {
    return QuizSessionState(
      session: session ?? this.session,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      answers: answers ?? this.answers,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      startTime: startTime ?? this.startTime,
    );
  }

  QuizQuestion? get currentQuestion {
    if (session == null ||
        currentQuestionIndex >= session!.questions.length) {
      return null;
    }
    return session!.questions[currentQuestionIndex];
  }

  bool get isCompleted =>
      session != null && currentQuestionIndex >= session!.questions.length;

  int get correctAnswersCount =>
      answers.where((a) => a.isCorrect).length;

  int get totalPoints =>
      answers.fold(0, (sum, a) => sum + a.pointsEarned);

  double get accuracy =>
      answers.isEmpty ? 0.0 : (correctAnswersCount / answers.length) * 100;
}

class QuizSessionNotifier extends StateNotifier<QuizSessionState> {
  final QuizRepository _repository;
  final Ref _ref;

  QuizSessionNotifier(this._repository, this._ref)
      : super(const QuizSessionState());

  /// Start a new quiz session
  Future<bool> startQuiz({
    String? category,
    String? difficulty,
    String language = 'en',
    int count = 10,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final session = await _repository.getQuizQuestions(
        category: category,
        difficulty: difficulty,
        language: language,
        count: count,
      );

      state = QuizSessionState(
        session: session,
        currentQuestionIndex: 0,
        answers: [],
        isLoading: false,
        startTime: DateTime.now(),
      );

      return true;
    } on QuizRepositoryException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to start quiz: ${e.toString()}',
      );
      return false;
    }
  }

  /// Submit an answer for the current question
  Future<AnswerResult?> submitAnswer(String answer) async {
    if (state.session == null || state.currentQuestion == null) {
      return null;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.submitQuizAnswer(
        questionId: state.currentQuestion!.id,
        answer: answer,
        sessionId: state.session!.sessionId,
      );

      // Add answer to list and move to next question
      final updatedAnswers = [...state.answers, result];

      state = state.copyWith(
        answers: updatedAnswers,
        currentQuestionIndex: state.currentQuestionIndex + 1,
        isLoading: false,
      );

      // Refresh energy status after consuming energy
      _ref.invalidate(energyStatusProvider);

      return result;
    } on QuizRepositoryException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return null;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to submit answer: ${e.toString()}',
      );
      return null;
    }
  }

  /// Complete the quiz session
  Future<QuizSummary?> completeQuiz() async {
    if (state.session == null) return null;

    state = state.copyWith(isLoading: true);

    try {
      final summary = await _repository.completeQuizSession(
        state.session!.sessionId,
      );

      // Refresh energy status (quiz completion bonus)
      _ref.invalidate(energyStatusProvider);

      // Refresh user profile (updated stats)
      _ref.invalidate(currentUserProfileProvider);

      return summary;
    } catch (e) {
      // Even if completion fails, we can create a summary from current state
      final duration = state.startTime != null
          ? DateTime.now().difference(state.startTime!).inSeconds
          : 0;

      return QuizSummary(
        sessionId: state.session!.sessionId,
        totalQuestions: state.session!.totalQuestions,
        correctAnswers: state.correctAnswersCount,
        wrongAnswers: state.answers.length - state.correctAnswersCount,
        totalPoints: state.totalPoints,
        accuracy: state.accuracy,
        energyConsumed: state.answers.length *
            state.session!.energyPerQuestion,
        durationSeconds: duration,
      );
    }
  }

  /// Reset quiz session
  void resetQuiz() {
    state = const QuizSessionState();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for quiz session management
final quizSessionProvider =
    StateNotifierProvider<QuizSessionNotifier, QuizSessionState>((ref) {
  final repository = ref.watch(quizRepositoryProvider);
  return QuizSessionNotifier(repository, ref);
});

/// Provider for current quiz session
final currentQuizSessionProvider = Provider<QuizSession?>((ref) {
  return ref.watch(quizSessionProvider).session;
});

/// Provider for current question
final currentQuestionProvider = Provider<QuizQuestion?>((ref) {
  return ref.watch(quizSessionProvider).currentQuestion;
});

/// Provider for quiz progress
final quizProgressProvider = Provider<double>((ref) {
  final state = ref.watch(quizSessionProvider);
  if (state.session == null) return 0.0;
  return state.currentQuestionIndex / state.session!.totalQuestions;
});

/// Provider for quiz completion status
final isQuizCompletedProvider = Provider<bool>((ref) {
  return ref.watch(quizSessionProvider).isCompleted;
});

// Import energy provider for invalidation
import '../providers/energy_providers.dart';
import '../providers/auth_providers.dart';
