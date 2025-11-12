// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) {
  return _QuizQuestion.fromJson(json);
}

/// @nodoc
mixin _$QuizQuestion {
  String get id => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  Map<String, String> get options =>
      throw _privateConstructorUsedError; // A, B, C, D
  int get points => throw _privateConstructorUsedError;
  List<String> get masoomTags =>
      throw _privateConstructorUsedError; // IDs of Masoomeen this question relates to
  List<String> get topicTags =>
      throw _privateConstructorUsedError; // Topics: 'fiqh', 'quran', 'hadith', 'history', etc.
  String? get bookSource => throw _privateConstructorUsedError;

  /// Serializes this QuizQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizQuestionCopyWith<QuizQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizQuestionCopyWith<$Res> {
  factory $QuizQuestionCopyWith(
          QuizQuestion value, $Res Function(QuizQuestion) then) =
      _$QuizQuestionCopyWithImpl<$Res, QuizQuestion>;
  @useResult
  $Res call(
      {String id,
      String category,
      String difficulty,
      String question,
      Map<String, String> options,
      int points,
      List<String> masoomTags,
      List<String> topicTags,
      String? bookSource});
}

/// @nodoc
class _$QuizQuestionCopyWithImpl<$Res, $Val extends QuizQuestion>
    implements $QuizQuestionCopyWith<$Res> {
  _$QuizQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? difficulty = null,
    Object? question = null,
    Object? options = null,
    Object? points = null,
    Object? masoomTags = null,
    Object? topicTags = null,
    Object? bookSource = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      masoomTags: null == masoomTags
          ? _value.masoomTags
          : masoomTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topicTags: null == topicTags
          ? _value.topicTags
          : topicTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bookSource: freezed == bookSource
          ? _value.bookSource
          : bookSource // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizQuestionImplCopyWith<$Res>
    implements $QuizQuestionCopyWith<$Res> {
  factory _$$QuizQuestionImplCopyWith(
          _$QuizQuestionImpl value, $Res Function(_$QuizQuestionImpl) then) =
      __$$QuizQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String category,
      String difficulty,
      String question,
      Map<String, String> options,
      int points,
      List<String> masoomTags,
      List<String> topicTags,
      String? bookSource});
}

/// @nodoc
class __$$QuizQuestionImplCopyWithImpl<$Res>
    extends _$QuizQuestionCopyWithImpl<$Res, _$QuizQuestionImpl>
    implements _$$QuizQuestionImplCopyWith<$Res> {
  __$$QuizQuestionImplCopyWithImpl(
      _$QuizQuestionImpl _value, $Res Function(_$QuizQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? difficulty = null,
    Object? question = null,
    Object? options = null,
    Object? points = null,
    Object? masoomTags = null,
    Object? topicTags = null,
    Object? bookSource = freezed,
  }) {
    return _then(_$QuizQuestionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      masoomTags: null == masoomTags
          ? _value._masoomTags
          : masoomTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topicTags: null == topicTags
          ? _value._topicTags
          : topicTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bookSource: freezed == bookSource
          ? _value.bookSource
          : bookSource // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizQuestionImpl implements _QuizQuestion {
  const _$QuizQuestionImpl(
      {required this.id,
      required this.category,
      required this.difficulty,
      required this.question,
      required final Map<String, String> options,
      required this.points,
      final List<String> masoomTags = const [],
      final List<String> topicTags = const [],
      this.bookSource})
      : _options = options,
        _masoomTags = masoomTags,
        _topicTags = topicTags;

  factory _$QuizQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String category;
  @override
  final String difficulty;
  @override
  final String question;
  final Map<String, String> _options;
  @override
  Map<String, String> get options {
    if (_options is EqualUnmodifiableMapView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_options);
  }

// A, B, C, D
  @override
  final int points;
  final List<String> _masoomTags;
  @override
  @JsonKey()
  List<String> get masoomTags {
    if (_masoomTags is EqualUnmodifiableListView) return _masoomTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_masoomTags);
  }

// IDs of Masoomeen this question relates to
  final List<String> _topicTags;
// IDs of Masoomeen this question relates to
  @override
  @JsonKey()
  List<String> get topicTags {
    if (_topicTags is EqualUnmodifiableListView) return _topicTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topicTags);
  }

// Topics: 'fiqh', 'quran', 'hadith', 'history', etc.
  @override
  final String? bookSource;

  @override
  String toString() {
    return 'QuizQuestion(id: $id, category: $category, difficulty: $difficulty, question: $question, options: $options, points: $points, masoomTags: $masoomTags, topicTags: $topicTags, bookSource: $bookSource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.points, points) || other.points == points) &&
            const DeepCollectionEquality()
                .equals(other._masoomTags, _masoomTags) &&
            const DeepCollectionEquality()
                .equals(other._topicTags, _topicTags) &&
            (identical(other.bookSource, bookSource) ||
                other.bookSource == bookSource));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      category,
      difficulty,
      question,
      const DeepCollectionEquality().hash(_options),
      points,
      const DeepCollectionEquality().hash(_masoomTags),
      const DeepCollectionEquality().hash(_topicTags),
      bookSource);

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      __$$QuizQuestionImplCopyWithImpl<_$QuizQuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizQuestionImplToJson(
      this,
    );
  }
}

abstract class _QuizQuestion implements QuizQuestion {
  const factory _QuizQuestion(
      {required final String id,
      required final String category,
      required final String difficulty,
      required final String question,
      required final Map<String, String> options,
      required final int points,
      final List<String> masoomTags,
      final List<String> topicTags,
      final String? bookSource}) = _$QuizQuestionImpl;

  factory _QuizQuestion.fromJson(Map<String, dynamic> json) =
      _$QuizQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get category;
  @override
  String get difficulty;
  @override
  String get question;
  @override
  Map<String, String> get options; // A, B, C, D
  @override
  int get points;
  @override
  List<String> get masoomTags; // IDs of Masoomeen this question relates to
  @override
  List<String>
      get topicTags; // Topics: 'fiqh', 'quran', 'hadith', 'history', etc.
  @override
  String? get bookSource;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizSession _$QuizSessionFromJson(Map<String, dynamic> json) {
  return _QuizSession.fromJson(json);
}

/// @nodoc
mixin _$QuizSession {
  String get sessionId => throw _privateConstructorUsedError;
  List<QuizQuestion> get questions => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get energyPerQuestion => throw _privateConstructorUsedError;
  int get totalEnergyNeeded => throw _privateConstructorUsedError;

  /// Serializes this QuizSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizSessionCopyWith<QuizSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizSessionCopyWith<$Res> {
  factory $QuizSessionCopyWith(
          QuizSession value, $Res Function(QuizSession) then) =
      _$QuizSessionCopyWithImpl<$Res, QuizSession>;
  @useResult
  $Res call(
      {String sessionId,
      List<QuizQuestion> questions,
      int totalQuestions,
      int energyPerQuestion,
      int totalEnergyNeeded});
}

/// @nodoc
class _$QuizSessionCopyWithImpl<$Res, $Val extends QuizSession>
    implements $QuizSessionCopyWith<$Res> {
  _$QuizSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? questions = null,
    Object? totalQuestions = null,
    Object? energyPerQuestion = null,
    Object? totalEnergyNeeded = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizQuestion>,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      energyPerQuestion: null == energyPerQuestion
          ? _value.energyPerQuestion
          : energyPerQuestion // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnergyNeeded: null == totalEnergyNeeded
          ? _value.totalEnergyNeeded
          : totalEnergyNeeded // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizSessionImplCopyWith<$Res>
    implements $QuizSessionCopyWith<$Res> {
  factory _$$QuizSessionImplCopyWith(
          _$QuizSessionImpl value, $Res Function(_$QuizSessionImpl) then) =
      __$$QuizSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      List<QuizQuestion> questions,
      int totalQuestions,
      int energyPerQuestion,
      int totalEnergyNeeded});
}

/// @nodoc
class __$$QuizSessionImplCopyWithImpl<$Res>
    extends _$QuizSessionCopyWithImpl<$Res, _$QuizSessionImpl>
    implements _$$QuizSessionImplCopyWith<$Res> {
  __$$QuizSessionImplCopyWithImpl(
      _$QuizSessionImpl _value, $Res Function(_$QuizSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? questions = null,
    Object? totalQuestions = null,
    Object? energyPerQuestion = null,
    Object? totalEnergyNeeded = null,
  }) {
    return _then(_$QuizSessionImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizQuestion>,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      energyPerQuestion: null == energyPerQuestion
          ? _value.energyPerQuestion
          : energyPerQuestion // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnergyNeeded: null == totalEnergyNeeded
          ? _value.totalEnergyNeeded
          : totalEnergyNeeded // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizSessionImpl implements _QuizSession {
  const _$QuizSessionImpl(
      {required this.sessionId,
      required final List<QuizQuestion> questions,
      required this.totalQuestions,
      required this.energyPerQuestion,
      required this.totalEnergyNeeded})
      : _questions = questions;

  factory _$QuizSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizSessionImplFromJson(json);

  @override
  final String sessionId;
  final List<QuizQuestion> _questions;
  @override
  List<QuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final int totalQuestions;
  @override
  final int energyPerQuestion;
  @override
  final int totalEnergyNeeded;

  @override
  String toString() {
    return 'QuizSession(sessionId: $sessionId, questions: $questions, totalQuestions: $totalQuestions, energyPerQuestion: $energyPerQuestion, totalEnergyNeeded: $totalEnergyNeeded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizSessionImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.energyPerQuestion, energyPerQuestion) ||
                other.energyPerQuestion == energyPerQuestion) &&
            (identical(other.totalEnergyNeeded, totalEnergyNeeded) ||
                other.totalEnergyNeeded == totalEnergyNeeded));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      const DeepCollectionEquality().hash(_questions),
      totalQuestions,
      energyPerQuestion,
      totalEnergyNeeded);

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizSessionImplCopyWith<_$QuizSessionImpl> get copyWith =>
      __$$QuizSessionImplCopyWithImpl<_$QuizSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizSessionImplToJson(
      this,
    );
  }
}

abstract class _QuizSession implements QuizSession {
  const factory _QuizSession(
      {required final String sessionId,
      required final List<QuizQuestion> questions,
      required final int totalQuestions,
      required final int energyPerQuestion,
      required final int totalEnergyNeeded}) = _$QuizSessionImpl;

  factory _QuizSession.fromJson(Map<String, dynamic> json) =
      _$QuizSessionImpl.fromJson;

  @override
  String get sessionId;
  @override
  List<QuizQuestion> get questions;
  @override
  int get totalQuestions;
  @override
  int get energyPerQuestion;
  @override
  int get totalEnergyNeeded;

  /// Create a copy of QuizSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizSessionImplCopyWith<_$QuizSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnswerResult _$AnswerResultFromJson(Map<String, dynamic> json) {
  return _AnswerResult.fromJson(json);
}

/// @nodoc
mixin _$AnswerResult {
  bool get isCorrect => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  int get pointsEarned => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get energyConsumed => throw _privateConstructorUsedError;
  int get energyRemaining => throw _privateConstructorUsedError;
  AnswerSource get source => throw _privateConstructorUsedError;

  /// Serializes this AnswerResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerResultCopyWith<AnswerResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerResultCopyWith<$Res> {
  factory $AnswerResultCopyWith(
          AnswerResult value, $Res Function(AnswerResult) then) =
      _$AnswerResultCopyWithImpl<$Res, AnswerResult>;
  @useResult
  $Res call(
      {bool isCorrect,
      String correctAnswer,
      String explanation,
      int pointsEarned,
      int currentStreak,
      int energyConsumed,
      int energyRemaining,
      AnswerSource source});

  $AnswerSourceCopyWith<$Res> get source;
}

/// @nodoc
class _$AnswerResultCopyWithImpl<$Res, $Val extends AnswerResult>
    implements $AnswerResultCopyWith<$Res> {
  _$AnswerResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCorrect = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? pointsEarned = null,
    Object? currentStreak = null,
    Object? energyConsumed = null,
    Object? energyRemaining = null,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      energyConsumed: null == energyConsumed
          ? _value.energyConsumed
          : energyConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      energyRemaining: null == energyRemaining
          ? _value.energyRemaining
          : energyRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as AnswerSource,
    ) as $Val);
  }

  /// Create a copy of AnswerResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnswerSourceCopyWith<$Res> get source {
    return $AnswerSourceCopyWith<$Res>(_value.source, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnswerResultImplCopyWith<$Res>
    implements $AnswerResultCopyWith<$Res> {
  factory _$$AnswerResultImplCopyWith(
          _$AnswerResultImpl value, $Res Function(_$AnswerResultImpl) then) =
      __$$AnswerResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isCorrect,
      String correctAnswer,
      String explanation,
      int pointsEarned,
      int currentStreak,
      int energyConsumed,
      int energyRemaining,
      AnswerSource source});

  @override
  $AnswerSourceCopyWith<$Res> get source;
}

/// @nodoc
class __$$AnswerResultImplCopyWithImpl<$Res>
    extends _$AnswerResultCopyWithImpl<$Res, _$AnswerResultImpl>
    implements _$$AnswerResultImplCopyWith<$Res> {
  __$$AnswerResultImplCopyWithImpl(
      _$AnswerResultImpl _value, $Res Function(_$AnswerResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnswerResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCorrect = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? pointsEarned = null,
    Object? currentStreak = null,
    Object? energyConsumed = null,
    Object? energyRemaining = null,
    Object? source = null,
  }) {
    return _then(_$AnswerResultImpl(
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      energyConsumed: null == energyConsumed
          ? _value.energyConsumed
          : energyConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      energyRemaining: null == energyRemaining
          ? _value.energyRemaining
          : energyRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as AnswerSource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerResultImpl implements _AnswerResult {
  const _$AnswerResultImpl(
      {required this.isCorrect,
      required this.correctAnswer,
      required this.explanation,
      required this.pointsEarned,
      required this.currentStreak,
      required this.energyConsumed,
      required this.energyRemaining,
      required this.source});

  factory _$AnswerResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerResultImplFromJson(json);

  @override
  final bool isCorrect;
  @override
  final String correctAnswer;
  @override
  final String explanation;
  @override
  final int pointsEarned;
  @override
  final int currentStreak;
  @override
  final int energyConsumed;
  @override
  final int energyRemaining;
  @override
  final AnswerSource source;

  @override
  String toString() {
    return 'AnswerResult(isCorrect: $isCorrect, correctAnswer: $correctAnswer, explanation: $explanation, pointsEarned: $pointsEarned, currentStreak: $currentStreak, energyConsumed: $energyConsumed, energyRemaining: $energyRemaining, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerResultImpl &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.energyConsumed, energyConsumed) ||
                other.energyConsumed == energyConsumed) &&
            (identical(other.energyRemaining, energyRemaining) ||
                other.energyRemaining == energyRemaining) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isCorrect,
      correctAnswer,
      explanation,
      pointsEarned,
      currentStreak,
      energyConsumed,
      energyRemaining,
      source);

  /// Create a copy of AnswerResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerResultImplCopyWith<_$AnswerResultImpl> get copyWith =>
      __$$AnswerResultImplCopyWithImpl<_$AnswerResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerResultImplToJson(
      this,
    );
  }
}

abstract class _AnswerResult implements AnswerResult {
  const factory _AnswerResult(
      {required final bool isCorrect,
      required final String correctAnswer,
      required final String explanation,
      required final int pointsEarned,
      required final int currentStreak,
      required final int energyConsumed,
      required final int energyRemaining,
      required final AnswerSource source}) = _$AnswerResultImpl;

  factory _AnswerResult.fromJson(Map<String, dynamic> json) =
      _$AnswerResultImpl.fromJson;

  @override
  bool get isCorrect;
  @override
  String get correctAnswer;
  @override
  String get explanation;
  @override
  int get pointsEarned;
  @override
  int get currentStreak;
  @override
  int get energyConsumed;
  @override
  int get energyRemaining;
  @override
  AnswerSource get source;

  /// Create a copy of AnswerResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerResultImplCopyWith<_$AnswerResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnswerSource _$AnswerSourceFromJson(Map<String, dynamic> json) {
  return _AnswerSource.fromJson(json);
}

/// @nodoc
mixin _$AnswerSource {
  String get bookId => throw _privateConstructorUsedError;
  String get paragraphId => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  String get quote => throw _privateConstructorUsedError;

  /// Serializes this AnswerSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerSourceCopyWith<AnswerSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerSourceCopyWith<$Res> {
  factory $AnswerSourceCopyWith(
          AnswerSource value, $Res Function(AnswerSource) then) =
      _$AnswerSourceCopyWithImpl<$Res, AnswerSource>;
  @useResult
  $Res call({String bookId, String paragraphId, int pageNumber, String quote});
}

/// @nodoc
class _$AnswerSourceCopyWithImpl<$Res, $Val extends AnswerSource>
    implements $AnswerSourceCopyWith<$Res> {
  _$AnswerSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? paragraphId = null,
    Object? pageNumber = null,
    Object? quote = null,
  }) {
    return _then(_value.copyWith(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnswerSourceImplCopyWith<$Res>
    implements $AnswerSourceCopyWith<$Res> {
  factory _$$AnswerSourceImplCopyWith(
          _$AnswerSourceImpl value, $Res Function(_$AnswerSourceImpl) then) =
      __$$AnswerSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String bookId, String paragraphId, int pageNumber, String quote});
}

/// @nodoc
class __$$AnswerSourceImplCopyWithImpl<$Res>
    extends _$AnswerSourceCopyWithImpl<$Res, _$AnswerSourceImpl>
    implements _$$AnswerSourceImplCopyWith<$Res> {
  __$$AnswerSourceImplCopyWithImpl(
      _$AnswerSourceImpl _value, $Res Function(_$AnswerSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnswerSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookId = null,
    Object? paragraphId = null,
    Object? pageNumber = null,
    Object? quote = null,
  }) {
    return _then(_$AnswerSourceImpl(
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphId: null == paragraphId
          ? _value.paragraphId
          : paragraphId // ignore: cast_nullable_to_non_nullable
              as String,
      pageNumber: null == pageNumber
          ? _value.pageNumber
          : pageNumber // ignore: cast_nullable_to_non_nullable
              as int,
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerSourceImpl implements _AnswerSource {
  const _$AnswerSourceImpl(
      {required this.bookId,
      required this.paragraphId,
      required this.pageNumber,
      required this.quote});

  factory _$AnswerSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerSourceImplFromJson(json);

  @override
  final String bookId;
  @override
  final String paragraphId;
  @override
  final int pageNumber;
  @override
  final String quote;

  @override
  String toString() {
    return 'AnswerSource(bookId: $bookId, paragraphId: $paragraphId, pageNumber: $pageNumber, quote: $quote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerSourceImpl &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.paragraphId, paragraphId) ||
                other.paragraphId == paragraphId) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.quote, quote) || other.quote == quote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bookId, paragraphId, pageNumber, quote);

  /// Create a copy of AnswerSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerSourceImplCopyWith<_$AnswerSourceImpl> get copyWith =>
      __$$AnswerSourceImplCopyWithImpl<_$AnswerSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerSourceImplToJson(
      this,
    );
  }
}

abstract class _AnswerSource implements AnswerSource {
  const factory _AnswerSource(
      {required final String bookId,
      required final String paragraphId,
      required final int pageNumber,
      required final String quote}) = _$AnswerSourceImpl;

  factory _AnswerSource.fromJson(Map<String, dynamic> json) =
      _$AnswerSourceImpl.fromJson;

  @override
  String get bookId;
  @override
  String get paragraphId;
  @override
  int get pageNumber;
  @override
  String get quote;

  /// Create a copy of AnswerSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerSourceImplCopyWith<_$AnswerSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizSummary _$QuizSummaryFromJson(Map<String, dynamic> json) {
  return _QuizSummary.fromJson(json);
}

/// @nodoc
mixin _$QuizSummary {
  String get sessionId => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get wrongAnswers => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  int get energyConsumed => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;

  /// Serializes this QuizSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizSummaryCopyWith<QuizSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizSummaryCopyWith<$Res> {
  factory $QuizSummaryCopyWith(
          QuizSummary value, $Res Function(QuizSummary) then) =
      _$QuizSummaryCopyWithImpl<$Res, QuizSummary>;
  @useResult
  $Res call(
      {String sessionId,
      int totalQuestions,
      int correctAnswers,
      int wrongAnswers,
      int totalPoints,
      double accuracy,
      int energyConsumed,
      int durationSeconds});
}

/// @nodoc
class _$QuizSummaryCopyWithImpl<$Res, $Val extends QuizSummary>
    implements $QuizSummaryCopyWith<$Res> {
  _$QuizSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? wrongAnswers = null,
    Object? totalPoints = null,
    Object? accuracy = null,
    Object? energyConsumed = null,
    Object? durationSeconds = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      wrongAnswers: null == wrongAnswers
          ? _value.wrongAnswers
          : wrongAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      energyConsumed: null == energyConsumed
          ? _value.energyConsumed
          : energyConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizSummaryImplCopyWith<$Res>
    implements $QuizSummaryCopyWith<$Res> {
  factory _$$QuizSummaryImplCopyWith(
          _$QuizSummaryImpl value, $Res Function(_$QuizSummaryImpl) then) =
      __$$QuizSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId,
      int totalQuestions,
      int correctAnswers,
      int wrongAnswers,
      int totalPoints,
      double accuracy,
      int energyConsumed,
      int durationSeconds});
}

/// @nodoc
class __$$QuizSummaryImplCopyWithImpl<$Res>
    extends _$QuizSummaryCopyWithImpl<$Res, _$QuizSummaryImpl>
    implements _$$QuizSummaryImplCopyWith<$Res> {
  __$$QuizSummaryImplCopyWithImpl(
      _$QuizSummaryImpl _value, $Res Function(_$QuizSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuizSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? wrongAnswers = null,
    Object? totalPoints = null,
    Object? accuracy = null,
    Object? energyConsumed = null,
    Object? durationSeconds = null,
  }) {
    return _then(_$QuizSummaryImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      wrongAnswers: null == wrongAnswers
          ? _value.wrongAnswers
          : wrongAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as double,
      energyConsumed: null == energyConsumed
          ? _value.energyConsumed
          : energyConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizSummaryImpl implements _QuizSummary {
  const _$QuizSummaryImpl(
      {required this.sessionId,
      required this.totalQuestions,
      required this.correctAnswers,
      required this.wrongAnswers,
      required this.totalPoints,
      required this.accuracy,
      required this.energyConsumed,
      required this.durationSeconds});

  factory _$QuizSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizSummaryImplFromJson(json);

  @override
  final String sessionId;
  @override
  final int totalQuestions;
  @override
  final int correctAnswers;
  @override
  final int wrongAnswers;
  @override
  final int totalPoints;
  @override
  final double accuracy;
  @override
  final int energyConsumed;
  @override
  final int durationSeconds;

  @override
  String toString() {
    return 'QuizSummary(sessionId: $sessionId, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, totalPoints: $totalPoints, accuracy: $accuracy, energyConsumed: $energyConsumed, durationSeconds: $durationSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizSummaryImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.wrongAnswers, wrongAnswers) ||
                other.wrongAnswers == wrongAnswers) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.energyConsumed, energyConsumed) ||
                other.energyConsumed == energyConsumed) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sessionId,
      totalQuestions,
      correctAnswers,
      wrongAnswers,
      totalPoints,
      accuracy,
      energyConsumed,
      durationSeconds);

  /// Create a copy of QuizSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizSummaryImplCopyWith<_$QuizSummaryImpl> get copyWith =>
      __$$QuizSummaryImplCopyWithImpl<_$QuizSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizSummaryImplToJson(
      this,
    );
  }
}

abstract class _QuizSummary implements QuizSummary {
  const factory _QuizSummary(
      {required final String sessionId,
      required final int totalQuestions,
      required final int correctAnswers,
      required final int wrongAnswers,
      required final int totalPoints,
      required final double accuracy,
      required final int energyConsumed,
      required final int durationSeconds}) = _$QuizSummaryImpl;

  factory _QuizSummary.fromJson(Map<String, dynamic> json) =
      _$QuizSummaryImpl.fromJson;

  @override
  String get sessionId;
  @override
  int get totalQuestions;
  @override
  int get correctAnswers;
  @override
  int get wrongAnswers;
  @override
  int get totalPoints;
  @override
  double get accuracy;
  @override
  int get energyConsumed;
  @override
  int get durationSeconds;

  /// Create a copy of QuizSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizSummaryImplCopyWith<_$QuizSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
