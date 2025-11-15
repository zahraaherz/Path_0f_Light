import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/quiz/quiz_models.dart';
import '../repositories/enhanced_quiz_repository.dart';

/// Enhanced Quiz Repository Provider
final enhancedQuizRepositoryProvider = Provider((ref) {
  return EnhancedQuizRepository(
    firestore: FirebaseFirestore.instance,
    functions: FirebaseFunctions.instance,
  );
});

/// Current Quiz Session State
class EnhancedQuizState {
  final String? sessionId;
  final List<EnhancedQuestion> questions;
  final int currentIndex;
  final Map<int, String> answers;
  final Map<int, AnswerResult> results;
  final int totalPoints;
  final int currentStreak;
  final bool isLoading;
  final String? error;
  final bool isCompleted;

  EnhancedQuizState({
    this.sessionId,
    this.questions = const [],
    this.currentIndex = 0,
    this.answers = const {},
    this.results = const {},
    this.totalPoints = 0,
    this.currentStreak = 0,
    this.isLoading = false,
    this.error,
    this.isCompleted = false,
  });

  EnhancedQuizState copyWith({
    String? sessionId,
    List<EnhancedQuestion>? questions,
    int? currentIndex,
    Map<int, String>? answers,
    Map<int, AnswerResult>? results,
    int? totalPoints,
    int? currentStreak,
    bool? isLoading,
    String? error,
    bool? isCompleted,
  }) {
    return EnhancedQuizState(
      sessionId: sessionId ?? this.sessionId,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      results: results ?? this.results,
      totalPoints: totalPoints ?? this.totalPoints,
      currentStreak: currentStreak ?? this.currentStreak,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  EnhancedQuestion? get currentQuestion {
    if (currentIndex < questions.length) {
      return questions[currentIndex];
    }
    return null;
  }

  String? get currentAnswer => answers[currentIndex];
  AnswerResult? get currentResult => results[currentIndex];
  int get questionsAnswered => answers.length;
  int get correctAnswers => results.values.where((r) => r.isCorrect).length;
  double get accuracy {
    if (questionsAnswered == 0) return 0.0;
    return (correctAnswers / questionsAnswered) * 100;
  }
}

/// Enhanced Quiz Session Notifier
class EnhancedQuizNotifier extends StateNotifier<EnhancedQuizState> {
  final EnhancedQuizRepository _repository;
  final Ref _ref;

  EnhancedQuizNotifier(this._repository, this._ref) : super(EnhancedQuizState());

  /// Start a new quiz session
  Future<void> startQuiz({
    String? category,
    String? difficulty,
    int totalQuestions = 10,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Create session
      final session = await _repository.createSession(
        category: category,
        difficulty: difficulty,
        totalQuestions: totalQuestions,
      );

      // Fetch questions
      final questions = await _repository.getQuestions(
        category: category,
        difficulty: difficulty,
        limit: totalQuestions,
      );

      state = state.copyWith(
        sessionId: session['sessionId'],
        questions: questions,
        currentIndex: 0,
        answers: {},
        results: {},
        totalPoints: 0,
        currentStreak: 0,
        isLoading: false,
        isCompleted: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Submit answer for current question
  Future<AnswerResult?> submitAnswer(String answer, {int? timeSpent}) async {
    if (state.currentQuestion == null || state.sessionId == null) {
      return null;
    }

    state = state.copyWith(isLoading: true);

    try {
      final result = await _repository.submitAnswer(
        sessionId: state.sessionId!,
        questionId: state.currentQuestion!.id,
        selectedAnswer: answer,
        timeSpent: timeSpent,
      );

      // Update state with answer and result
      final newAnswers = Map<int, String>.from(state.answers);
      newAnswers[state.currentIndex] = answer;

      final newResults = Map<int, AnswerResult>.from(state.results);
      newResults[state.currentIndex] = result;

      state = state.copyWith(
        answers: newAnswers,
        results: newResults,
        totalPoints: state.totalPoints + result.pointsEarned,
        currentStreak: result.currentStreak,
        isLoading: false,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return null;
    }
  }

  /// Move to next question
  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    } else {
      // Quiz completed
      state = state.copyWith(isCompleted: true);
    }
  }

  /// Complete the quiz session
  Future<QuizSummary?> completeQuiz(int durationSeconds) async {
    if (state.sessionId == null) return null;

    try {
      final summary = await _repository.completeSession(
        sessionId: state.sessionId!,
        durationSeconds: durationSeconds,
      );

      return summary;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  /// Reset quiz
  void reset() {
    state = EnhancedQuizState();
  }
}

/// Enhanced Quiz Session Provider
final enhancedQuizProvider =
    StateNotifierProvider<EnhancedQuizNotifier, EnhancedQuizState>((ref) {
  final repository = ref.watch(enhancedQuizRepositoryProvider);
  return EnhancedQuizNotifier(repository, ref);
});

/// Challenge State
class ChallengeState {
  final String? challengeId;
  final String? opponentId;
  final String? opponentName;
  final String? opponentAvatar;
  final int opponentLevel;
  final int myScore;
  final int opponentScore;
  final int myProgress;
  final int opponentProgress;
  final String status; // pending, active, completed
  final String? winnerId;
  final bool isLoading;
  final String? error;

  ChallengeState({
    this.challengeId,
    this.opponentId,
    this.opponentName,
    this.opponentAvatar,
    this.opponentLevel = 0,
    this.myScore = 0,
    this.opponentScore = 0,
    this.myProgress = 0,
    this.opponentProgress = 0,
    this.status = 'pending',
    this.winnerId,
    this.isLoading = false,
    this.error,
  });

  ChallengeState copyWith({
    String? challengeId,
    String? opponentId,
    String? opponentName,
    String? opponentAvatar,
    int? opponentLevel,
    int? myScore,
    int? opponentScore,
    int? myProgress,
    int? opponentProgress,
    String? status,
    String? winnerId,
    bool? isLoading,
    String? error,
  }) {
    return ChallengeState(
      challengeId: challengeId ?? this.challengeId,
      opponentId: opponentId ?? this.opponentId,
      opponentName: opponentName ?? this.opponentName,
      opponentAvatar: opponentAvatar ?? this.opponentAvatar,
      opponentLevel: opponentLevel ?? this.opponentLevel,
      myScore: myScore ?? this.myScore,
      opponentScore: opponentScore ?? this.opponentScore,
      myProgress: myProgress ?? this.myProgress,
      opponentProgress: opponentProgress ?? this.opponentProgress,
      status: status ?? this.status,
      winnerId: winnerId ?? this.winnerId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get isMyTurn => myProgress <= opponentProgress;
  bool get hasWinner => winnerId != null;
  bool get didIWin => winnerId != null && winnerId == 'me';
}

/// Challenge Notifier
class ChallengeNotifier extends StateNotifier<ChallengeState> {
  final EnhancedQuizRepository _repository;
  final String _userId;

  ChallengeNotifier(this._repository, this._userId) : super(ChallengeState());

  /// Find random opponent
  Future<void> findRandomMatch({String? category, String? difficulty}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final opponent = await _repository.findRandomMatch(
        category: category,
        difficulty: difficulty,
      );

      state = state.copyWith(
        opponentId: opponent['id'],
        opponentName: opponent['name'],
        opponentAvatar: opponent['avatar'],
        opponentLevel: opponent['level'],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Create challenge
  Future<void> createChallenge({
    required String opponentId,
    String? category,
    String? difficulty,
    int totalQuestions = 10,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final challenge = await _repository.createChallenge(
        opponentId: opponentId,
        category: category,
        difficulty: difficulty,
        totalQuestions: totalQuestions,
      );

      state = state.copyWith(
        challengeId: challenge['challengeId'],
        opponentId: opponentId,
        status: 'pending',
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Update my progress
  Future<void> updateProgress(int score, int progress) async {
    if (state.challengeId == null) return;

    try {
      await _repository.updateChallengeProgress(
        challengeId: state.challengeId!,
        score: score,
        progress: progress,
      );

      state = state.copyWith(
        myScore: score,
        myProgress: progress,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Complete challenge
  Future<void> completeChallenge() async {
    if (state.challengeId == null) return;

    try {
      final result = await _repository.completeChallenge(
        challengeId: state.challengeId!,
      );

      state = state.copyWith(
        status: 'completed',
        winnerId: result['winner'],
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Listen to challenge updates (real-time)
  Stream<ChallengeState> watchChallenge(String challengeId) {
    return FirebaseFirestore.instance
        .collection('challenges')
        .doc(challengeId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return state;
      }

      final data = snapshot.data()!;
      final isChallenger = data['challenger_id'] == _userId;

      return state.copyWith(
        opponentScore: isChallenger ? data['opponent_score'] : data['challenger_score'],
        opponentProgress: isChallenger ? data['opponent_progress'] : data['challenger_progress'],
        status: data['status'],
        winnerId: data['winner_id'],
      );
    });
  }

  /// Reset challenge
  void reset() {
    state = ChallengeState();
  }
}

/// Challenge Provider
final challengeProvider =
    StateNotifierProvider<ChallengeNotifier, ChallengeState>((ref) {
  final repository = ref.watch(enhancedQuizRepositoryProvider);
  // TODO: Get actual user ID from auth provider
  const userId = 'current_user_id';
  return ChallengeNotifier(repository, userId);
});

/// Stream provider for real-time challenge updates
final challengeStreamProvider = StreamProvider.family<ChallengeState, String>(
  (ref, challengeId) {
    final notifier = ref.watch(challengeProvider.notifier);
    return notifier.watchChallenge(challengeId);
  },
);

/// Timer provider for quiz questions
final questionTimerProvider = StateNotifierProvider.autoDispose<QuestionTimerNotifier, int>((ref) {
  return QuestionTimerNotifier();
});

class QuestionTimerNotifier extends StateNotifier<int> {
  QuestionTimerNotifier() : super(30); // 30 seconds default

  void start(int seconds) {
    state = seconds;
    _countdown();
  }

  void _countdown() async {
    while (state > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        state = state - 1;
      }
    }
  }

  void reset(int seconds) {
    state = seconds;
  }

  void stop() {
    state = 0;
  }
}

/// Book Collection Provider
final savedBooksProvider = StreamProvider<List<String>>((ref) {
  // TODO: Get actual user ID from auth provider
  const userId = 'current_user_id';

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('saved_books')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
});

/// Check if book is saved
final isBookSavedProvider = Provider.family<bool, String>((ref, bookId) {
  final savedBooks = ref.watch(savedBooksProvider);
  return savedBooks.when(
    data: (books) => books.contains(bookId),
    loading: () => false,
    error: (_, __) => false,
  );
});
