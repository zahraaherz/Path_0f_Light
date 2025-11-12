// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizQuestionImpl _$$QuizQuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuizQuestionImpl(
      id: json['id'] as String,
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      question: json['question'] as String,
      options: Map<String, String>.from(json['options'] as Map),
      points: (json['points'] as num).toInt(),
      masoomTags: (json['masoomTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      topicTags: (json['topicTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bookSource: json['bookSource'] as String?,
    );

Map<String, dynamic> _$$QuizQuestionImplToJson(_$QuizQuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'question': instance.question,
      'options': instance.options,
      'points': instance.points,
      'masoomTags': instance.masoomTags,
      'topicTags': instance.topicTags,
      'bookSource': instance.bookSource,
    };

_$QuizSessionImpl _$$QuizSessionImplFromJson(Map<String, dynamic> json) =>
    _$QuizSessionImpl(
      sessionId: json['sessionId'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      energyPerQuestion: (json['energyPerQuestion'] as num).toInt(),
      totalEnergyNeeded: (json['totalEnergyNeeded'] as num).toInt(),
    );

Map<String, dynamic> _$$QuizSessionImplToJson(_$QuizSessionImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'questions': instance.questions,
      'totalQuestions': instance.totalQuestions,
      'energyPerQuestion': instance.energyPerQuestion,
      'totalEnergyNeeded': instance.totalEnergyNeeded,
    };

_$AnswerResultImpl _$$AnswerResultImplFromJson(Map<String, dynamic> json) =>
    _$AnswerResultImpl(
      isCorrect: json['isCorrect'] as bool,
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
      pointsEarned: (json['pointsEarned'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      energyConsumed: (json['energyConsumed'] as num).toInt(),
      energyRemaining: (json['energyRemaining'] as num).toInt(),
      source: AnswerSource.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AnswerResultImplToJson(_$AnswerResultImpl instance) =>
    <String, dynamic>{
      'isCorrect': instance.isCorrect,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'pointsEarned': instance.pointsEarned,
      'currentStreak': instance.currentStreak,
      'energyConsumed': instance.energyConsumed,
      'energyRemaining': instance.energyRemaining,
      'source': instance.source,
    };

_$AnswerSourceImpl _$$AnswerSourceImplFromJson(Map<String, dynamic> json) =>
    _$AnswerSourceImpl(
      bookId: json['bookId'] as String,
      paragraphId: json['paragraphId'] as String,
      pageNumber: (json['pageNumber'] as num).toInt(),
      quote: json['quote'] as String,
    );

Map<String, dynamic> _$$AnswerSourceImplToJson(_$AnswerSourceImpl instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'paragraphId': instance.paragraphId,
      'pageNumber': instance.pageNumber,
      'quote': instance.quote,
    };

_$QuizSummaryImpl _$$QuizSummaryImplFromJson(Map<String, dynamic> json) =>
    _$QuizSummaryImpl(
      sessionId: json['sessionId'] as String,
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      wrongAnswers: (json['wrongAnswers'] as num).toInt(),
      totalPoints: (json['totalPoints'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
      energyConsumed: (json['energyConsumed'] as num).toInt(),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$$QuizSummaryImplToJson(_$QuizSummaryImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
      'wrongAnswers': instance.wrongAnswers,
      'totalPoints': instance.totalPoints,
      'accuracy': instance.accuracy,
      'energyConsumed': instance.energyConsumed,
      'durationSeconds': instance.durationSeconds,
    };
