import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_models.freezed.dart';
part 'quiz_models.g.dart';

/// Difficulty levels for questions
enum DifficultyLevel {
  basic('basic', 'Basic', 10),
  intermediate('intermediate', 'Intermediate', 15),
  advanced('advanced', 'Advanced', 20),
  expert('expert', 'Expert', 25);

  final String value;
  final String displayName;
  final int basePoints;

  const DifficultyLevel(this.value, this.displayName, this.basePoints);

  static DifficultyLevel fromString(String value) {
    return DifficultyLevel.values.firstWhere(
      (level) => level.value == value,
      orElse: () => DifficultyLevel.basic,
    );
  }
}

/// Answer options (A, B, C, D)
enum AnswerOption {
  A('A'),
  B('B'),
  C('C'),
  D('D');

  final String value;
  const AnswerOption(this.value);

  static AnswerOption fromString(String value) {
    return AnswerOption.values.firstWhere(
      (option) => option.value == value.toUpperCase(),
      orElse: () => AnswerOption.A,
    );
  }
}

/// Quiz question model (without correct answer)
@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String id,
    required String category,
    required String difficulty,
    required String question,
    required Map<String, String> options, // A, B, C, D
    required int points,
    @Default([]) List<String> masoomTags, // IDs of Masoomeen this question relates to
    @Default([]) List<String> topicTags, // Topics: 'fiqh', 'quran', 'hadith', 'history', etc.
    String? bookSource, // Book ID where this question comes from
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}

/// Quiz session data
@freezed
class QuizSession with _$QuizSession {
  const factory QuizSession({
    required String sessionId,
    required List<QuizQuestion> questions,
    required int totalQuestions,
    required int energyPerQuestion,
    required int totalEnergyNeeded,
  }) = _QuizSession;

  factory QuizSession.fromJson(Map<String, dynamic> json) =>
      _$QuizSessionFromJson(json);
}

/// Answer submission result
@freezed
class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required bool isCorrect,
    required String correctAnswer,
    required String explanation,
    required int pointsEarned,
    required int currentStreak,
    required int energyConsumed,
    required int energyRemaining,
    required AnswerSource source,
    String? explanationAr,
    String? bookTitleAr,
    String? bookTitleEn,
  }) = _AnswerResult;

  factory AnswerResult.fromJson(Map<String, dynamic> json) =>
      _$AnswerResultFromJson(json);
}

/// Source information for the answer
@freezed
class AnswerSource with _$AnswerSource {
  const factory AnswerSource({
    required String bookId,
    required String paragraphId,
    required int pageNumber,
    required String quote,
    String? exactQuoteAr,
    String? bookTitle,
  }) = _AnswerSource;

  factory AnswerSource.fromJson(Map<String, dynamic> json) =>
      _$AnswerSourceFromJson(json);
}

/// Question type enum
enum QuestionType {
  multipleChoice,
  trueFalse,
  fillInBlank,
  matching,
}

/// Enhanced question model matching the JSON structure
@freezed
class EnhancedQuestion with _$EnhancedQuestion {
  const factory EnhancedQuestion({
    required String id,
    required String category,
    required String difficulty,
    required String questionAr,
    required String questionEn,
    required Map<String, Map<String, String>> options, // {"A": {"text_ar": "", "text_en": ""}}
    required String correctAnswer,
    required QuestionSource source,
    required String explanationAr,
    required String explanationEn,
    required int points,
    @Default(QuestionType.multipleChoice) QuestionType questionType,
    @Default(false) bool verified,
  }) = _EnhancedQuestion;

  factory EnhancedQuestion.fromJson(Map<String, dynamic> json) =>
      _$EnhancedQuestionFromJson(json);
}

/// Question source information
@freezed
class QuestionSource with _$QuestionSource {
  const factory QuestionSource({
    required String paragraphId,
    required String bookId,
    required String exactQuoteAr,
    required int pageNumber,
    String? bookTitleAr,
    String? bookTitleEn,
  }) = _QuestionSource;

  factory QuestionSource.fromJson(Map<String, dynamic> json) =>
      _$QuestionSourceFromJson(json);
}

/// Quiz completion summary
@freezed
class QuizSummary with _$QuizSummary {
  const factory QuizSummary({
    required String sessionId,
    required int totalQuestions,
    required int correctAnswers,
    required int wrongAnswers,
    required int totalPoints,
    required double accuracy,
    required int energyConsumed,
    required int durationSeconds,
  }) = _QuizSummary;

  factory QuizSummary.fromJson(Map<String, dynamic> json) =>
      _$QuizSummaryFromJson(json);
}

/// Quiz configuration constants
class QuizConfig {
  static const int questionsPerSession = 10;
  static const double streakBonusMultiplier = 1.1;
  static const double maxStreakBonus = 2.0;

  static const Map<String, int> points = {
    'basic': 10,
    'intermediate': 15,
    'advanced': 20,
    'expert': 25,
  };
}
