// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattlePlayer _$BattlePlayerFromJson(Map<String, dynamic> json) {
  return _BattlePlayer.fromJson(json);
}

/// @nodoc
mixin _$BattlePlayer {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get wrongAnswers => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get answeredCount => throw _privateConstructorUsedError;
  bool get isReady => throw _privateConstructorUsedError;
  bool get hasFinished => throw _privateConstructorUsedError;
  DateTime? get finishedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get lastAnswer => throw _privateConstructorUsedError;

  /// Serializes this BattlePlayer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattlePlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattlePlayerCopyWith<BattlePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattlePlayerCopyWith<$Res> {
  factory $BattlePlayerCopyWith(
          BattlePlayer value, $Res Function(BattlePlayer) then) =
      _$BattlePlayerCopyWithImpl<$Res, BattlePlayer>;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? photoURL,
      int score,
      int correctAnswers,
      int wrongAnswers,
      int currentStreak,
      int answeredCount,
      bool isReady,
      bool hasFinished,
      DateTime? finishedAt,
      Map<String, dynamic>? lastAnswer});
}

/// @nodoc
class _$BattlePlayerCopyWithImpl<$Res, $Val extends BattlePlayer>
    implements $BattlePlayerCopyWith<$Res> {
  _$BattlePlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattlePlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? score = null,
    Object? correctAnswers = null,
    Object? wrongAnswers = null,
    Object? currentStreak = null,
    Object? answeredCount = null,
    Object? isReady = null,
    Object? hasFinished = null,
    Object? finishedAt = freezed,
    Object? lastAnswer = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      wrongAnswers: null == wrongAnswers
          ? _value.wrongAnswers
          : wrongAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      answeredCount: null == answeredCount
          ? _value.answeredCount
          : answeredCount // ignore: cast_nullable_to_non_nullable
              as int,
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      hasFinished: null == hasFinished
          ? _value.hasFinished
          : hasFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAnswer: freezed == lastAnswer
          ? _value.lastAnswer
          : lastAnswer // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattlePlayerImplCopyWith<$Res>
    implements $BattlePlayerCopyWith<$Res> {
  factory _$$BattlePlayerImplCopyWith(
          _$BattlePlayerImpl value, $Res Function(_$BattlePlayerImpl) then) =
      __$$BattlePlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? photoURL,
      int score,
      int correctAnswers,
      int wrongAnswers,
      int currentStreak,
      int answeredCount,
      bool isReady,
      bool hasFinished,
      DateTime? finishedAt,
      Map<String, dynamic>? lastAnswer});
}

/// @nodoc
class __$$BattlePlayerImplCopyWithImpl<$Res>
    extends _$BattlePlayerCopyWithImpl<$Res, _$BattlePlayerImpl>
    implements _$$BattlePlayerImplCopyWith<$Res> {
  __$$BattlePlayerImplCopyWithImpl(
      _$BattlePlayerImpl _value, $Res Function(_$BattlePlayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattlePlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? score = null,
    Object? correctAnswers = null,
    Object? wrongAnswers = null,
    Object? currentStreak = null,
    Object? answeredCount = null,
    Object? isReady = null,
    Object? hasFinished = null,
    Object? finishedAt = freezed,
    Object? lastAnswer = freezed,
  }) {
    return _then(_$BattlePlayerImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      wrongAnswers: null == wrongAnswers
          ? _value.wrongAnswers
          : wrongAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      answeredCount: null == answeredCount
          ? _value.answeredCount
          : answeredCount // ignore: cast_nullable_to_non_nullable
              as int,
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
      hasFinished: null == hasFinished
          ? _value.hasFinished
          : hasFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastAnswer: freezed == lastAnswer
          ? _value._lastAnswer
          : lastAnswer // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattlePlayerImpl implements _BattlePlayer {
  const _$BattlePlayerImpl(
      {required this.userId,
      required this.displayName,
      this.photoURL,
      this.score = 0,
      this.correctAnswers = 0,
      this.wrongAnswers = 0,
      this.currentStreak = 0,
      this.answeredCount = 0,
      this.isReady = false,
      this.hasFinished = false,
      this.finishedAt,
      final Map<String, dynamic>? lastAnswer})
      : _lastAnswer = lastAnswer;

  factory _$BattlePlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattlePlayerImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? photoURL;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int correctAnswers;
  @override
  @JsonKey()
  final int wrongAnswers;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int answeredCount;
  @override
  @JsonKey()
  final bool isReady;
  @override
  @JsonKey()
  final bool hasFinished;
  @override
  final DateTime? finishedAt;
  final Map<String, dynamic>? _lastAnswer;
  @override
  Map<String, dynamic>? get lastAnswer {
    final value = _lastAnswer;
    if (value == null) return null;
    if (_lastAnswer is EqualUnmodifiableMapView) return _lastAnswer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BattlePlayer(userId: $userId, displayName: $displayName, photoURL: $photoURL, score: $score, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, currentStreak: $currentStreak, answeredCount: $answeredCount, isReady: $isReady, hasFinished: $hasFinished, finishedAt: $finishedAt, lastAnswer: $lastAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattlePlayerImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.wrongAnswers, wrongAnswers) ||
                other.wrongAnswers == wrongAnswers) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.answeredCount, answeredCount) ||
                other.answeredCount == answeredCount) &&
            (identical(other.isReady, isReady) || other.isReady == isReady) &&
            (identical(other.hasFinished, hasFinished) ||
                other.hasFinished == hasFinished) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt) &&
            const DeepCollectionEquality()
                .equals(other._lastAnswer, _lastAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      displayName,
      photoURL,
      score,
      correctAnswers,
      wrongAnswers,
      currentStreak,
      answeredCount,
      isReady,
      hasFinished,
      finishedAt,
      const DeepCollectionEquality().hash(_lastAnswer));

  /// Create a copy of BattlePlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattlePlayerImplCopyWith<_$BattlePlayerImpl> get copyWith =>
      __$$BattlePlayerImplCopyWithImpl<_$BattlePlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattlePlayerImplToJson(
      this,
    );
  }
}

abstract class _BattlePlayer implements BattlePlayer {
  const factory _BattlePlayer(
      {required final String userId,
      required final String displayName,
      final String? photoURL,
      final int score,
      final int correctAnswers,
      final int wrongAnswers,
      final int currentStreak,
      final int answeredCount,
      final bool isReady,
      final bool hasFinished,
      final DateTime? finishedAt,
      final Map<String, dynamic>? lastAnswer}) = _$BattlePlayerImpl;

  factory _BattlePlayer.fromJson(Map<String, dynamic> json) =
      _$BattlePlayerImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get photoURL;
  @override
  int get score;
  @override
  int get correctAnswers;
  @override
  int get wrongAnswers;
  @override
  int get currentStreak;
  @override
  int get answeredCount;
  @override
  bool get isReady;
  @override
  bool get hasFinished;
  @override
  DateTime? get finishedAt;
  @override
  Map<String, dynamic>? get lastAnswer;

  /// Create a copy of BattlePlayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattlePlayerImplCopyWith<_$BattlePlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattleConfig _$BattleConfigFromJson(Map<String, dynamic> json) {
  return _BattleConfig.fromJson(json);
}

/// @nodoc
mixin _$BattleConfig {
  int get questionCount => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get difficulty => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  int get timePerQuestion => throw _privateConstructorUsedError; // seconds
  int get energyCost => throw _privateConstructorUsedError;

  /// Serializes this BattleConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattleConfigCopyWith<BattleConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleConfigCopyWith<$Res> {
  factory $BattleConfigCopyWith(
          BattleConfig value, $Res Function(BattleConfig) then) =
      _$BattleConfigCopyWithImpl<$Res, BattleConfig>;
  @useResult
  $Res call(
      {int questionCount,
      String? category,
      String? difficulty,
      String language,
      int timePerQuestion,
      int energyCost});
}

/// @nodoc
class _$BattleConfigCopyWithImpl<$Res, $Val extends BattleConfig>
    implements $BattleConfigCopyWith<$Res> {
  _$BattleConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionCount = null,
    Object? category = freezed,
    Object? difficulty = freezed,
    Object? language = null,
    Object? timePerQuestion = null,
    Object? energyCost = null,
  }) {
    return _then(_value.copyWith(
      questionCount: null == questionCount
          ? _value.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      timePerQuestion: null == timePerQuestion
          ? _value.timePerQuestion
          : timePerQuestion // ignore: cast_nullable_to_non_nullable
              as int,
      energyCost: null == energyCost
          ? _value.energyCost
          : energyCost // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleConfigImplCopyWith<$Res>
    implements $BattleConfigCopyWith<$Res> {
  factory _$$BattleConfigImplCopyWith(
          _$BattleConfigImpl value, $Res Function(_$BattleConfigImpl) then) =
      __$$BattleConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int questionCount,
      String? category,
      String? difficulty,
      String language,
      int timePerQuestion,
      int energyCost});
}

/// @nodoc
class __$$BattleConfigImplCopyWithImpl<$Res>
    extends _$BattleConfigCopyWithImpl<$Res, _$BattleConfigImpl>
    implements _$$BattleConfigImplCopyWith<$Res> {
  __$$BattleConfigImplCopyWithImpl(
      _$BattleConfigImpl _value, $Res Function(_$BattleConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattleConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionCount = null,
    Object? category = freezed,
    Object? difficulty = freezed,
    Object? language = null,
    Object? timePerQuestion = null,
    Object? energyCost = null,
  }) {
    return _then(_$BattleConfigImpl(
      questionCount: null == questionCount
          ? _value.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String?,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      timePerQuestion: null == timePerQuestion
          ? _value.timePerQuestion
          : timePerQuestion // ignore: cast_nullable_to_non_nullable
              as int,
      energyCost: null == energyCost
          ? _value.energyCost
          : energyCost // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleConfigImpl implements _BattleConfig {
  const _$BattleConfigImpl(
      {this.questionCount = 10,
      this.category,
      this.difficulty,
      this.language = 'en',
      this.timePerQuestion = 30,
      this.energyCost = 5});

  factory _$BattleConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleConfigImplFromJson(json);

  @override
  @JsonKey()
  final int questionCount;
  @override
  final String? category;
  @override
  final String? difficulty;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final int timePerQuestion;
// seconds
  @override
  @JsonKey()
  final int energyCost;

  @override
  String toString() {
    return 'BattleConfig(questionCount: $questionCount, category: $category, difficulty: $difficulty, language: $language, timePerQuestion: $timePerQuestion, energyCost: $energyCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleConfigImpl &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.timePerQuestion, timePerQuestion) ||
                other.timePerQuestion == timePerQuestion) &&
            (identical(other.energyCost, energyCost) ||
                other.energyCost == energyCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, questionCount, category,
      difficulty, language, timePerQuestion, energyCost);

  /// Create a copy of BattleConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleConfigImplCopyWith<_$BattleConfigImpl> get copyWith =>
      __$$BattleConfigImplCopyWithImpl<_$BattleConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleConfigImplToJson(
      this,
    );
  }
}

abstract class _BattleConfig implements BattleConfig {
  const factory _BattleConfig(
      {final int questionCount,
      final String? category,
      final String? difficulty,
      final String language,
      final int timePerQuestion,
      final int energyCost}) = _$BattleConfigImpl;

  factory _BattleConfig.fromJson(Map<String, dynamic> json) =
      _$BattleConfigImpl.fromJson;

  @override
  int get questionCount;
  @override
  String? get category;
  @override
  String? get difficulty;
  @override
  String get language;
  @override
  int get timePerQuestion; // seconds
  @override
  int get energyCost;

  /// Create a copy of BattleConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattleConfigImplCopyWith<_$BattleConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Battle _$BattleFromJson(Map<String, dynamic> json) {
  return _Battle.fromJson(json);
}

/// @nodoc
mixin _$Battle {
  String get id => throw _privateConstructorUsedError;
  BattleType get type => throw _privateConstructorUsedError;
  BattleStatus get status => throw _privateConstructorUsedError;
  BattlePlayer get player1 => throw _privateConstructorUsedError;
  BattlePlayer? get player2 => throw _privateConstructorUsedError;
  BattleConfig get config => throw _privateConstructorUsedError;
  List<String> get questionIds =>
      throw _privateConstructorUsedError; // Questions for this battle
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get winnerId =>
      throw _privateConstructorUsedError; // User ID of winner
  String? get tournamentId =>
      throw _privateConstructorUsedError; // If part of tournament
  bool get isRanked =>
      throw _privateConstructorUsedError; // Affects leaderboard
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this Battle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattleCopyWith<Battle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleCopyWith<$Res> {
  factory $BattleCopyWith(Battle value, $Res Function(Battle) then) =
      _$BattleCopyWithImpl<$Res, Battle>;
  @useResult
  $Res call(
      {String id,
      BattleType type,
      BattleStatus status,
      BattlePlayer player1,
      BattlePlayer? player2,
      BattleConfig config,
      List<String> questionIds,
      DateTime createdAt,
      DateTime? startedAt,
      DateTime? completedAt,
      String? winnerId,
      String? tournamentId,
      bool isRanked,
      Map<String, dynamic>? metadata});

  $BattlePlayerCopyWith<$Res> get player1;
  $BattlePlayerCopyWith<$Res>? get player2;
  $BattleConfigCopyWith<$Res> get config;
}

/// @nodoc
class _$BattleCopyWithImpl<$Res, $Val extends Battle>
    implements $BattleCopyWith<$Res> {
  _$BattleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? player1 = null,
    Object? player2 = freezed,
    Object? config = null,
    Object? questionIds = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? winnerId = freezed,
    Object? tournamentId = freezed,
    Object? isRanked = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BattleType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BattleStatus,
      player1: null == player1
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer,
      player2: freezed == player2
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer?,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      questionIds: null == questionIds
          ? _value.questionIds
          : questionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRanked: null == isRanked
          ? _value.isRanked
          : isRanked // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattlePlayerCopyWith<$Res> get player1 {
    return $BattlePlayerCopyWith<$Res>(_value.player1, (value) {
      return _then(_value.copyWith(player1: value) as $Val);
    });
  }

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattlePlayerCopyWith<$Res>? get player2 {
    if (_value.player2 == null) {
      return null;
    }

    return $BattlePlayerCopyWith<$Res>(_value.player2!, (value) {
      return _then(_value.copyWith(player2: value) as $Val);
    });
  }

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattleConfigCopyWith<$Res> get config {
    return $BattleConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattleImplCopyWith<$Res> implements $BattleCopyWith<$Res> {
  factory _$$BattleImplCopyWith(
          _$BattleImpl value, $Res Function(_$BattleImpl) then) =
      __$$BattleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      BattleType type,
      BattleStatus status,
      BattlePlayer player1,
      BattlePlayer? player2,
      BattleConfig config,
      List<String> questionIds,
      DateTime createdAt,
      DateTime? startedAt,
      DateTime? completedAt,
      String? winnerId,
      String? tournamentId,
      bool isRanked,
      Map<String, dynamic>? metadata});

  @override
  $BattlePlayerCopyWith<$Res> get player1;
  @override
  $BattlePlayerCopyWith<$Res>? get player2;
  @override
  $BattleConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$BattleImplCopyWithImpl<$Res>
    extends _$BattleCopyWithImpl<$Res, _$BattleImpl>
    implements _$$BattleImplCopyWith<$Res> {
  __$$BattleImplCopyWithImpl(
      _$BattleImpl _value, $Res Function(_$BattleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? player1 = null,
    Object? player2 = freezed,
    Object? config = null,
    Object? questionIds = null,
    Object? createdAt = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? winnerId = freezed,
    Object? tournamentId = freezed,
    Object? isRanked = null,
    Object? metadata = freezed,
  }) {
    return _then(_$BattleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BattleType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BattleStatus,
      player1: null == player1
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer,
      player2: freezed == player2
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer?,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      questionIds: null == questionIds
          ? _value._questionIds
          : questionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRanked: null == isRanked
          ? _value.isRanked
          : isRanked // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleImpl implements _Battle {
  const _$BattleImpl(
      {required this.id,
      required this.type,
      required this.status,
      required this.player1,
      this.player2,
      required this.config,
      required final List<String> questionIds,
      required this.createdAt,
      this.startedAt,
      this.completedAt,
      this.winnerId,
      this.tournamentId,
      this.isRanked = false,
      final Map<String, dynamic>? metadata})
      : _questionIds = questionIds,
        _metadata = metadata;

  factory _$BattleImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleImplFromJson(json);

  @override
  final String id;
  @override
  final BattleType type;
  @override
  final BattleStatus status;
  @override
  final BattlePlayer player1;
  @override
  final BattlePlayer? player2;
  @override
  final BattleConfig config;
  final List<String> _questionIds;
  @override
  List<String> get questionIds {
    if (_questionIds is EqualUnmodifiableListView) return _questionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionIds);
  }

// Questions for this battle
  @override
  final DateTime createdAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String? winnerId;
// User ID of winner
  @override
  final String? tournamentId;
// If part of tournament
  @override
  @JsonKey()
  final bool isRanked;
// Affects leaderboard
  final Map<String, dynamic>? _metadata;
// Affects leaderboard
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Battle(id: $id, type: $type, status: $status, player1: $player1, player2: $player2, config: $config, questionIds: $questionIds, createdAt: $createdAt, startedAt: $startedAt, completedAt: $completedAt, winnerId: $winnerId, tournamentId: $tournamentId, isRanked: $isRanked, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.player1, player1) || other.player1 == player1) &&
            (identical(other.player2, player2) || other.player2 == player2) &&
            (identical(other.config, config) || other.config == config) &&
            const DeepCollectionEquality()
                .equals(other._questionIds, _questionIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.isRanked, isRanked) ||
                other.isRanked == isRanked) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      status,
      player1,
      player2,
      config,
      const DeepCollectionEquality().hash(_questionIds),
      createdAt,
      startedAt,
      completedAt,
      winnerId,
      tournamentId,
      isRanked,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleImplCopyWith<_$BattleImpl> get copyWith =>
      __$$BattleImplCopyWithImpl<_$BattleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleImplToJson(
      this,
    );
  }
}

abstract class _Battle implements Battle {
  const factory _Battle(
      {required final String id,
      required final BattleType type,
      required final BattleStatus status,
      required final BattlePlayer player1,
      final BattlePlayer? player2,
      required final BattleConfig config,
      required final List<String> questionIds,
      required final DateTime createdAt,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final String? winnerId,
      final String? tournamentId,
      final bool isRanked,
      final Map<String, dynamic>? metadata}) = _$BattleImpl;

  factory _Battle.fromJson(Map<String, dynamic> json) = _$BattleImpl.fromJson;

  @override
  String get id;
  @override
  BattleType get type;
  @override
  BattleStatus get status;
  @override
  BattlePlayer get player1;
  @override
  BattlePlayer? get player2;
  @override
  BattleConfig get config;
  @override
  List<String> get questionIds; // Questions for this battle
  @override
  DateTime get createdAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  String? get winnerId; // User ID of winner
  @override
  String? get tournamentId; // If part of tournament
  @override
  bool get isRanked; // Affects leaderboard
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of Battle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattleImplCopyWith<_$BattleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattleInvitation _$BattleInvitationFromJson(Map<String, dynamic> json) {
  return _BattleInvitation.fromJson(json);
}

/// @nodoc
mixin _$BattleInvitation {
  String get id => throw _privateConstructorUsedError;
  String get battleId => throw _privateConstructorUsedError;
  String get fromUserId => throw _privateConstructorUsedError;
  String get fromUserName => throw _privateConstructorUsedError;
  String? get fromUserPhoto => throw _privateConstructorUsedError;
  String get toUserId => throw _privateConstructorUsedError;
  BattleConfig get config => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // pending, accepted, rejected, expired
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get respondedAt => throw _privateConstructorUsedError;
  int get expirySeconds => throw _privateConstructorUsedError;

  /// Serializes this BattleInvitation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattleInvitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattleInvitationCopyWith<BattleInvitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleInvitationCopyWith<$Res> {
  factory $BattleInvitationCopyWith(
          BattleInvitation value, $Res Function(BattleInvitation) then) =
      _$BattleInvitationCopyWithImpl<$Res, BattleInvitation>;
  @useResult
  $Res call(
      {String id,
      String battleId,
      String fromUserId,
      String fromUserName,
      String? fromUserPhoto,
      String toUserId,
      BattleConfig config,
      String status,
      DateTime createdAt,
      DateTime? respondedAt,
      int expirySeconds});

  $BattleConfigCopyWith<$Res> get config;
}

/// @nodoc
class _$BattleInvitationCopyWithImpl<$Res, $Val extends BattleInvitation>
    implements $BattleInvitationCopyWith<$Res> {
  _$BattleInvitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattleInvitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? battleId = null,
    Object? fromUserId = null,
    Object? fromUserName = null,
    Object? fromUserPhoto = freezed,
    Object? toUserId = null,
    Object? config = null,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
    Object? expirySeconds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserName: null == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserPhoto: freezed == fromUserPhoto
          ? _value.fromUserPhoto
          : fromUserPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expirySeconds: null == expirySeconds
          ? _value.expirySeconds
          : expirySeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of BattleInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattleConfigCopyWith<$Res> get config {
    return $BattleConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattleInvitationImplCopyWith<$Res>
    implements $BattleInvitationCopyWith<$Res> {
  factory _$$BattleInvitationImplCopyWith(_$BattleInvitationImpl value,
          $Res Function(_$BattleInvitationImpl) then) =
      __$$BattleInvitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String battleId,
      String fromUserId,
      String fromUserName,
      String? fromUserPhoto,
      String toUserId,
      BattleConfig config,
      String status,
      DateTime createdAt,
      DateTime? respondedAt,
      int expirySeconds});

  @override
  $BattleConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$BattleInvitationImplCopyWithImpl<$Res>
    extends _$BattleInvitationCopyWithImpl<$Res, _$BattleInvitationImpl>
    implements _$$BattleInvitationImplCopyWith<$Res> {
  __$$BattleInvitationImplCopyWithImpl(_$BattleInvitationImpl _value,
      $Res Function(_$BattleInvitationImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattleInvitation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? battleId = null,
    Object? fromUserId = null,
    Object? fromUserName = null,
    Object? fromUserPhoto = freezed,
    Object? toUserId = null,
    Object? config = null,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
    Object? expirySeconds = null,
  }) {
    return _then(_$BattleInvitationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserName: null == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserPhoto: freezed == fromUserPhoto
          ? _value.fromUserPhoto
          : fromUserPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      respondedAt: freezed == respondedAt
          ? _value.respondedAt
          : respondedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expirySeconds: null == expirySeconds
          ? _value.expirySeconds
          : expirySeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleInvitationImpl implements _BattleInvitation {
  const _$BattleInvitationImpl(
      {required this.id,
      required this.battleId,
      required this.fromUserId,
      required this.fromUserName,
      this.fromUserPhoto,
      required this.toUserId,
      required this.config,
      this.status = 'pending',
      required this.createdAt,
      this.respondedAt,
      this.expirySeconds = 300});

  factory _$BattleInvitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleInvitationImplFromJson(json);

  @override
  final String id;
  @override
  final String battleId;
  @override
  final String fromUserId;
  @override
  final String fromUserName;
  @override
  final String? fromUserPhoto;
  @override
  final String toUserId;
  @override
  final BattleConfig config;
  @override
  @JsonKey()
  final String status;
// pending, accepted, rejected, expired
  @override
  final DateTime createdAt;
  @override
  final DateTime? respondedAt;
  @override
  @JsonKey()
  final int expirySeconds;

  @override
  String toString() {
    return 'BattleInvitation(id: $id, battleId: $battleId, fromUserId: $fromUserId, fromUserName: $fromUserName, fromUserPhoto: $fromUserPhoto, toUserId: $toUserId, config: $config, status: $status, createdAt: $createdAt, respondedAt: $respondedAt, expirySeconds: $expirySeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleInvitationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.battleId, battleId) ||
                other.battleId == battleId) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.fromUserName, fromUserName) ||
                other.fromUserName == fromUserName) &&
            (identical(other.fromUserPhoto, fromUserPhoto) ||
                other.fromUserPhoto == fromUserPhoto) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            (identical(other.expirySeconds, expirySeconds) ||
                other.expirySeconds == expirySeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      battleId,
      fromUserId,
      fromUserName,
      fromUserPhoto,
      toUserId,
      config,
      status,
      createdAt,
      respondedAt,
      expirySeconds);

  /// Create a copy of BattleInvitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleInvitationImplCopyWith<_$BattleInvitationImpl> get copyWith =>
      __$$BattleInvitationImplCopyWithImpl<_$BattleInvitationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleInvitationImplToJson(
      this,
    );
  }
}

abstract class _BattleInvitation implements BattleInvitation {
  const factory _BattleInvitation(
      {required final String id,
      required final String battleId,
      required final String fromUserId,
      required final String fromUserName,
      final String? fromUserPhoto,
      required final String toUserId,
      required final BattleConfig config,
      final String status,
      required final DateTime createdAt,
      final DateTime? respondedAt,
      final int expirySeconds}) = _$BattleInvitationImpl;

  factory _BattleInvitation.fromJson(Map<String, dynamic> json) =
      _$BattleInvitationImpl.fromJson;

  @override
  String get id;
  @override
  String get battleId;
  @override
  String get fromUserId;
  @override
  String get fromUserName;
  @override
  String? get fromUserPhoto;
  @override
  String get toUserId;
  @override
  BattleConfig get config;
  @override
  String get status; // pending, accepted, rejected, expired
  @override
  DateTime get createdAt;
  @override
  DateTime? get respondedAt;
  @override
  int get expirySeconds;

  /// Create a copy of BattleInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattleInvitationImplCopyWith<_$BattleInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchmakingEntry _$MatchmakingEntryFromJson(Map<String, dynamic> json) {
  return _MatchmakingEntry.fromJson(json);
}

/// @nodoc
mixin _$MatchmakingEntry {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  BattleConfig get config => throw _privateConstructorUsedError;
  int get userRating => throw _privateConstructorUsedError; // ELO or similar
  DateTime get joinedAt => throw _privateConstructorUsedError;
  int get timeoutSeconds => throw _privateConstructorUsedError;

  /// Serializes this MatchmakingEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchmakingEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchmakingEntryCopyWith<MatchmakingEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchmakingEntryCopyWith<$Res> {
  factory $MatchmakingEntryCopyWith(
          MatchmakingEntry value, $Res Function(MatchmakingEntry) then) =
      _$MatchmakingEntryCopyWithImpl<$Res, MatchmakingEntry>;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? photoURL,
      BattleConfig config,
      int userRating,
      DateTime joinedAt,
      int timeoutSeconds});

  $BattleConfigCopyWith<$Res> get config;
}

/// @nodoc
class _$MatchmakingEntryCopyWithImpl<$Res, $Val extends MatchmakingEntry>
    implements $MatchmakingEntryCopyWith<$Res> {
  _$MatchmakingEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchmakingEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? config = null,
    Object? userRating = null,
    Object? joinedAt = null,
    Object? timeoutSeconds = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      userRating: null == userRating
          ? _value.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as int,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeoutSeconds: null == timeoutSeconds
          ? _value.timeoutSeconds
          : timeoutSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of MatchmakingEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattleConfigCopyWith<$Res> get config {
    return $BattleConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchmakingEntryImplCopyWith<$Res>
    implements $MatchmakingEntryCopyWith<$Res> {
  factory _$$MatchmakingEntryImplCopyWith(_$MatchmakingEntryImpl value,
          $Res Function(_$MatchmakingEntryImpl) then) =
      __$$MatchmakingEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? photoURL,
      BattleConfig config,
      int userRating,
      DateTime joinedAt,
      int timeoutSeconds});

  @override
  $BattleConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$MatchmakingEntryImplCopyWithImpl<$Res>
    extends _$MatchmakingEntryCopyWithImpl<$Res, _$MatchmakingEntryImpl>
    implements _$$MatchmakingEntryImplCopyWith<$Res> {
  __$$MatchmakingEntryImplCopyWithImpl(_$MatchmakingEntryImpl _value,
      $Res Function(_$MatchmakingEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MatchmakingEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? config = null,
    Object? userRating = null,
    Object? joinedAt = null,
    Object? timeoutSeconds = null,
  }) {
    return _then(_$MatchmakingEntryImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      userRating: null == userRating
          ? _value.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as int,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeoutSeconds: null == timeoutSeconds
          ? _value.timeoutSeconds
          : timeoutSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchmakingEntryImpl implements _MatchmakingEntry {
  const _$MatchmakingEntryImpl(
      {required this.userId,
      required this.displayName,
      this.photoURL,
      required this.config,
      required this.userRating,
      required this.joinedAt,
      this.timeoutSeconds = 60});

  factory _$MatchmakingEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchmakingEntryImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? photoURL;
  @override
  final BattleConfig config;
  @override
  final int userRating;
// ELO or similar
  @override
  final DateTime joinedAt;
  @override
  @JsonKey()
  final int timeoutSeconds;

  @override
  String toString() {
    return 'MatchmakingEntry(userId: $userId, displayName: $displayName, photoURL: $photoURL, config: $config, userRating: $userRating, joinedAt: $joinedAt, timeoutSeconds: $timeoutSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchmakingEntryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.config, config) || other.config == config) &&
            (identical(other.userRating, userRating) ||
                other.userRating == userRating) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.timeoutSeconds, timeoutSeconds) ||
                other.timeoutSeconds == timeoutSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, displayName, photoURL,
      config, userRating, joinedAt, timeoutSeconds);

  /// Create a copy of MatchmakingEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchmakingEntryImplCopyWith<_$MatchmakingEntryImpl> get copyWith =>
      __$$MatchmakingEntryImplCopyWithImpl<_$MatchmakingEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchmakingEntryImplToJson(
      this,
    );
  }
}

abstract class _MatchmakingEntry implements MatchmakingEntry {
  const factory _MatchmakingEntry(
      {required final String userId,
      required final String displayName,
      final String? photoURL,
      required final BattleConfig config,
      required final int userRating,
      required final DateTime joinedAt,
      final int timeoutSeconds}) = _$MatchmakingEntryImpl;

  factory _MatchmakingEntry.fromJson(Map<String, dynamic> json) =
      _$MatchmakingEntryImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get photoURL;
  @override
  BattleConfig get config;
  @override
  int get userRating; // ELO or similar
  @override
  DateTime get joinedAt;
  @override
  int get timeoutSeconds;

  /// Create a copy of MatchmakingEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchmakingEntryImplCopyWith<_$MatchmakingEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattleStats _$BattleStatsFromJson(Map<String, dynamic> json) {
  return _BattleStats.fromJson(json);
}

/// @nodoc
mixin _$BattleStats {
  int get totalBattles => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  int get draws => throw _privateConstructorUsedError;
  int get winStreak => throw _privateConstructorUsedError;
  int get longestWinStreak => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError; // ELO rating
  int get totalPointsEarned => throw _privateConstructorUsedError;
  DateTime? get lastBattleAt => throw _privateConstructorUsedError;

  /// Serializes this BattleStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattleStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattleStatsCopyWith<BattleStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleStatsCopyWith<$Res> {
  factory $BattleStatsCopyWith(
          BattleStats value, $Res Function(BattleStats) then) =
      _$BattleStatsCopyWithImpl<$Res, BattleStats>;
  @useResult
  $Res call(
      {int totalBattles,
      int wins,
      int losses,
      int draws,
      int winStreak,
      int longestWinStreak,
      int rating,
      int totalPointsEarned,
      DateTime? lastBattleAt});
}

/// @nodoc
class _$BattleStatsCopyWithImpl<$Res, $Val extends BattleStats>
    implements $BattleStatsCopyWith<$Res> {
  _$BattleStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattleStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBattles = null,
    Object? wins = null,
    Object? losses = null,
    Object? draws = null,
    Object? winStreak = null,
    Object? longestWinStreak = null,
    Object? rating = null,
    Object? totalPointsEarned = null,
    Object? lastBattleAt = freezed,
  }) {
    return _then(_value.copyWith(
      totalBattles: null == totalBattles
          ? _value.totalBattles
          : totalBattles // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      draws: null == draws
          ? _value.draws
          : draws // ignore: cast_nullable_to_non_nullable
              as int,
      winStreak: null == winStreak
          ? _value.winStreak
          : winStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestWinStreak: null == longestWinStreak
          ? _value.longestWinStreak
          : longestWinStreak // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      totalPointsEarned: null == totalPointsEarned
          ? _value.totalPointsEarned
          : totalPointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      lastBattleAt: freezed == lastBattleAt
          ? _value.lastBattleAt
          : lastBattleAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleStatsImplCopyWith<$Res>
    implements $BattleStatsCopyWith<$Res> {
  factory _$$BattleStatsImplCopyWith(
          _$BattleStatsImpl value, $Res Function(_$BattleStatsImpl) then) =
      __$$BattleStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalBattles,
      int wins,
      int losses,
      int draws,
      int winStreak,
      int longestWinStreak,
      int rating,
      int totalPointsEarned,
      DateTime? lastBattleAt});
}

/// @nodoc
class __$$BattleStatsImplCopyWithImpl<$Res>
    extends _$BattleStatsCopyWithImpl<$Res, _$BattleStatsImpl>
    implements _$$BattleStatsImplCopyWith<$Res> {
  __$$BattleStatsImplCopyWithImpl(
      _$BattleStatsImpl _value, $Res Function(_$BattleStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattleStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBattles = null,
    Object? wins = null,
    Object? losses = null,
    Object? draws = null,
    Object? winStreak = null,
    Object? longestWinStreak = null,
    Object? rating = null,
    Object? totalPointsEarned = null,
    Object? lastBattleAt = freezed,
  }) {
    return _then(_$BattleStatsImpl(
      totalBattles: null == totalBattles
          ? _value.totalBattles
          : totalBattles // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      draws: null == draws
          ? _value.draws
          : draws // ignore: cast_nullable_to_non_nullable
              as int,
      winStreak: null == winStreak
          ? _value.winStreak
          : winStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestWinStreak: null == longestWinStreak
          ? _value.longestWinStreak
          : longestWinStreak // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      totalPointsEarned: null == totalPointsEarned
          ? _value.totalPointsEarned
          : totalPointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      lastBattleAt: freezed == lastBattleAt
          ? _value.lastBattleAt
          : lastBattleAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleStatsImpl implements _BattleStats {
  const _$BattleStatsImpl(
      {this.totalBattles = 0,
      this.wins = 0,
      this.losses = 0,
      this.draws = 0,
      this.winStreak = 0,
      this.longestWinStreak = 0,
      this.rating = 1000,
      this.totalPointsEarned = 0,
      this.lastBattleAt});

  factory _$BattleStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleStatsImplFromJson(json);

  @override
  @JsonKey()
  final int totalBattles;
  @override
  @JsonKey()
  final int wins;
  @override
  @JsonKey()
  final int losses;
  @override
  @JsonKey()
  final int draws;
  @override
  @JsonKey()
  final int winStreak;
  @override
  @JsonKey()
  final int longestWinStreak;
  @override
  @JsonKey()
  final int rating;
// ELO rating
  @override
  @JsonKey()
  final int totalPointsEarned;
  @override
  final DateTime? lastBattleAt;

  @override
  String toString() {
    return 'BattleStats(totalBattles: $totalBattles, wins: $wins, losses: $losses, draws: $draws, winStreak: $winStreak, longestWinStreak: $longestWinStreak, rating: $rating, totalPointsEarned: $totalPointsEarned, lastBattleAt: $lastBattleAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleStatsImpl &&
            (identical(other.totalBattles, totalBattles) ||
                other.totalBattles == totalBattles) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.draws, draws) || other.draws == draws) &&
            (identical(other.winStreak, winStreak) ||
                other.winStreak == winStreak) &&
            (identical(other.longestWinStreak, longestWinStreak) ||
                other.longestWinStreak == longestWinStreak) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.totalPointsEarned, totalPointsEarned) ||
                other.totalPointsEarned == totalPointsEarned) &&
            (identical(other.lastBattleAt, lastBattleAt) ||
                other.lastBattleAt == lastBattleAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalBattles,
      wins,
      losses,
      draws,
      winStreak,
      longestWinStreak,
      rating,
      totalPointsEarned,
      lastBattleAt);

  /// Create a copy of BattleStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleStatsImplCopyWith<_$BattleStatsImpl> get copyWith =>
      __$$BattleStatsImplCopyWithImpl<_$BattleStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleStatsImplToJson(
      this,
    );
  }
}

abstract class _BattleStats implements BattleStats {
  const factory _BattleStats(
      {final int totalBattles,
      final int wins,
      final int losses,
      final int draws,
      final int winStreak,
      final int longestWinStreak,
      final int rating,
      final int totalPointsEarned,
      final DateTime? lastBattleAt}) = _$BattleStatsImpl;

  factory _BattleStats.fromJson(Map<String, dynamic> json) =
      _$BattleStatsImpl.fromJson;

  @override
  int get totalBattles;
  @override
  int get wins;
  @override
  int get losses;
  @override
  int get draws;
  @override
  int get winStreak;
  @override
  int get longestWinStreak;
  @override
  int get rating; // ELO rating
  @override
  int get totalPointsEarned;
  @override
  DateTime? get lastBattleAt;

  /// Create a copy of BattleStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattleStatsImplCopyWith<_$BattleStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattleResult _$BattleResultFromJson(Map<String, dynamic> json) {
  return _BattleResult.fromJson(json);
}

/// @nodoc
mixin _$BattleResult {
  String get battleId => throw _privateConstructorUsedError;
  BattlePlayer get player1 => throw _privateConstructorUsedError;
  BattlePlayer get player2 => throw _privateConstructorUsedError;
  String get winnerId => throw _privateConstructorUsedError;
  String get loserId => throw _privateConstructorUsedError;
  int get winnerScore => throw _privateConstructorUsedError;
  int get loserScore => throw _privateConstructorUsedError;
  int get scoreDifference => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  String? get battleType => throw _privateConstructorUsedError;

  /// Serializes this BattleResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattleResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattleResultCopyWith<BattleResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleResultCopyWith<$Res> {
  factory $BattleResultCopyWith(
          BattleResult value, $Res Function(BattleResult) then) =
      _$BattleResultCopyWithImpl<$Res, BattleResult>;
  @useResult
  $Res call(
      {String battleId,
      BattlePlayer player1,
      BattlePlayer player2,
      String winnerId,
      String loserId,
      int winnerScore,
      int loserScore,
      int scoreDifference,
      DateTime completedAt,
      int durationSeconds,
      String? battleType});

  $BattlePlayerCopyWith<$Res> get player1;
  $BattlePlayerCopyWith<$Res> get player2;
}

/// @nodoc
class _$BattleResultCopyWithImpl<$Res, $Val extends BattleResult>
    implements $BattleResultCopyWith<$Res> {
  _$BattleResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattleResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? player1 = null,
    Object? player2 = null,
    Object? winnerId = null,
    Object? loserId = null,
    Object? winnerScore = null,
    Object? loserScore = null,
    Object? scoreDifference = null,
    Object? completedAt = null,
    Object? durationSeconds = null,
    Object? battleType = freezed,
  }) {
    return _then(_value.copyWith(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      player1: null == player1
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer,
      player2: null == player2
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer,
      winnerId: null == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String,
      loserId: null == loserId
          ? _value.loserId
          : loserId // ignore: cast_nullable_to_non_nullable
              as String,
      winnerScore: null == winnerScore
          ? _value.winnerScore
          : winnerScore // ignore: cast_nullable_to_non_nullable
              as int,
      loserScore: null == loserScore
          ? _value.loserScore
          : loserScore // ignore: cast_nullable_to_non_nullable
              as int,
      scoreDifference: null == scoreDifference
          ? _value.scoreDifference
          : scoreDifference // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      battleType: freezed == battleType
          ? _value.battleType
          : battleType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of BattleResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattlePlayerCopyWith<$Res> get player1 {
    return $BattlePlayerCopyWith<$Res>(_value.player1, (value) {
      return _then(_value.copyWith(player1: value) as $Val);
    });
  }

  /// Create a copy of BattleResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattlePlayerCopyWith<$Res> get player2 {
    return $BattlePlayerCopyWith<$Res>(_value.player2, (value) {
      return _then(_value.copyWith(player2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BattleResultImplCopyWith<$Res>
    implements $BattleResultCopyWith<$Res> {
  factory _$$BattleResultImplCopyWith(
          _$BattleResultImpl value, $Res Function(_$BattleResultImpl) then) =
      __$$BattleResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String battleId,
      BattlePlayer player1,
      BattlePlayer player2,
      String winnerId,
      String loserId,
      int winnerScore,
      int loserScore,
      int scoreDifference,
      DateTime completedAt,
      int durationSeconds,
      String? battleType});

  @override
  $BattlePlayerCopyWith<$Res> get player1;
  @override
  $BattlePlayerCopyWith<$Res> get player2;
}

/// @nodoc
class __$$BattleResultImplCopyWithImpl<$Res>
    extends _$BattleResultCopyWithImpl<$Res, _$BattleResultImpl>
    implements _$$BattleResultImplCopyWith<$Res> {
  __$$BattleResultImplCopyWithImpl(
      _$BattleResultImpl _value, $Res Function(_$BattleResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattleResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? player1 = null,
    Object? player2 = null,
    Object? winnerId = null,
    Object? loserId = null,
    Object? winnerScore = null,
    Object? loserScore = null,
    Object? scoreDifference = null,
    Object? completedAt = null,
    Object? durationSeconds = null,
    Object? battleType = freezed,
  }) {
    return _then(_$BattleResultImpl(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      player1: null == player1
          ? _value.player1
          : player1 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer,
      player2: null == player2
          ? _value.player2
          : player2 // ignore: cast_nullable_to_non_nullable
              as BattlePlayer,
      winnerId: null == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String,
      loserId: null == loserId
          ? _value.loserId
          : loserId // ignore: cast_nullable_to_non_nullable
              as String,
      winnerScore: null == winnerScore
          ? _value.winnerScore
          : winnerScore // ignore: cast_nullable_to_non_nullable
              as int,
      loserScore: null == loserScore
          ? _value.loserScore
          : loserScore // ignore: cast_nullable_to_non_nullable
              as int,
      scoreDifference: null == scoreDifference
          ? _value.scoreDifference
          : scoreDifference // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      battleType: freezed == battleType
          ? _value.battleType
          : battleType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleResultImpl implements _BattleResult {
  const _$BattleResultImpl(
      {required this.battleId,
      required this.player1,
      required this.player2,
      required this.winnerId,
      required this.loserId,
      required this.winnerScore,
      required this.loserScore,
      required this.scoreDifference,
      required this.completedAt,
      required this.durationSeconds,
      this.battleType});

  factory _$BattleResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleResultImplFromJson(json);

  @override
  final String battleId;
  @override
  final BattlePlayer player1;
  @override
  final BattlePlayer player2;
  @override
  final String winnerId;
  @override
  final String loserId;
  @override
  final int winnerScore;
  @override
  final int loserScore;
  @override
  final int scoreDifference;
  @override
  final DateTime completedAt;
  @override
  final int durationSeconds;
  @override
  final String? battleType;

  @override
  String toString() {
    return 'BattleResult(battleId: $battleId, player1: $player1, player2: $player2, winnerId: $winnerId, loserId: $loserId, winnerScore: $winnerScore, loserScore: $loserScore, scoreDifference: $scoreDifference, completedAt: $completedAt, durationSeconds: $durationSeconds, battleType: $battleType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleResultImpl &&
            (identical(other.battleId, battleId) ||
                other.battleId == battleId) &&
            (identical(other.player1, player1) || other.player1 == player1) &&
            (identical(other.player2, player2) || other.player2 == player2) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.loserId, loserId) || other.loserId == loserId) &&
            (identical(other.winnerScore, winnerScore) ||
                other.winnerScore == winnerScore) &&
            (identical(other.loserScore, loserScore) ||
                other.loserScore == loserScore) &&
            (identical(other.scoreDifference, scoreDifference) ||
                other.scoreDifference == scoreDifference) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.battleType, battleType) ||
                other.battleType == battleType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      battleId,
      player1,
      player2,
      winnerId,
      loserId,
      winnerScore,
      loserScore,
      scoreDifference,
      completedAt,
      durationSeconds,
      battleType);

  /// Create a copy of BattleResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleResultImplCopyWith<_$BattleResultImpl> get copyWith =>
      __$$BattleResultImplCopyWithImpl<_$BattleResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleResultImplToJson(
      this,
    );
  }
}

abstract class _BattleResult implements BattleResult {
  const factory _BattleResult(
      {required final String battleId,
      required final BattlePlayer player1,
      required final BattlePlayer player2,
      required final String winnerId,
      required final String loserId,
      required final int winnerScore,
      required final int loserScore,
      required final int scoreDifference,
      required final DateTime completedAt,
      required final int durationSeconds,
      final String? battleType}) = _$BattleResultImpl;

  factory _BattleResult.fromJson(Map<String, dynamic> json) =
      _$BattleResultImpl.fromJson;

  @override
  String get battleId;
  @override
  BattlePlayer get player1;
  @override
  BattlePlayer get player2;
  @override
  String get winnerId;
  @override
  String get loserId;
  @override
  int get winnerScore;
  @override
  int get loserScore;
  @override
  int get scoreDifference;
  @override
  DateTime get completedAt;
  @override
  int get durationSeconds;
  @override
  String? get battleType;

  /// Create a copy of BattleResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattleResultImplCopyWith<_$BattleResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattleUpdate _$BattleUpdateFromJson(Map<String, dynamic> json) {
  return _BattleUpdate.fromJson(json);
}

/// @nodoc
mixin _$BattleUpdate {
  String get battleId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get updateType =>
      throw _privateConstructorUsedError; // answer_submitted, player_joined, battle_started, battle_ended
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// Serializes this BattleUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattleUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattleUpdateCopyWith<BattleUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleUpdateCopyWith<$Res> {
  factory $BattleUpdateCopyWith(
          BattleUpdate value, $Res Function(BattleUpdate) then) =
      _$BattleUpdateCopyWithImpl<$Res, BattleUpdate>;
  @useResult
  $Res call(
      {String battleId,
      String userId,
      String updateType,
      DateTime timestamp,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$BattleUpdateCopyWithImpl<$Res, $Val extends BattleUpdate>
    implements $BattleUpdateCopyWith<$Res> {
  _$BattleUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattleUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? userId = null,
    Object? updateType = null,
    Object? timestamp = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      updateType: null == updateType
          ? _value.updateType
          : updateType // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleUpdateImplCopyWith<$Res>
    implements $BattleUpdateCopyWith<$Res> {
  factory _$$BattleUpdateImplCopyWith(
          _$BattleUpdateImpl value, $Res Function(_$BattleUpdateImpl) then) =
      __$$BattleUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String battleId,
      String userId,
      String updateType,
      DateTime timestamp,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$BattleUpdateImplCopyWithImpl<$Res>
    extends _$BattleUpdateCopyWithImpl<$Res, _$BattleUpdateImpl>
    implements _$$BattleUpdateImplCopyWith<$Res> {
  __$$BattleUpdateImplCopyWithImpl(
      _$BattleUpdateImpl _value, $Res Function(_$BattleUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattleUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? userId = null,
    Object? updateType = null,
    Object? timestamp = null,
    Object? data = freezed,
  }) {
    return _then(_$BattleUpdateImpl(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      updateType: null == updateType
          ? _value.updateType
          : updateType // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleUpdateImpl implements _BattleUpdate {
  const _$BattleUpdateImpl(
      {required this.battleId,
      required this.userId,
      required this.updateType,
      required this.timestamp,
      final Map<String, dynamic>? data})
      : _data = data;

  factory _$BattleUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleUpdateImplFromJson(json);

  @override
  final String battleId;
  @override
  final String userId;
  @override
  final String updateType;
// answer_submitted, player_joined, battle_started, battle_ended
  @override
  final DateTime timestamp;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BattleUpdate(battleId: $battleId, userId: $userId, updateType: $updateType, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleUpdateImpl &&
            (identical(other.battleId, battleId) ||
                other.battleId == battleId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.updateType, updateType) ||
                other.updateType == updateType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, battleId, userId, updateType,
      timestamp, const DeepCollectionEquality().hash(_data));

  /// Create a copy of BattleUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleUpdateImplCopyWith<_$BattleUpdateImpl> get copyWith =>
      __$$BattleUpdateImplCopyWithImpl<_$BattleUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleUpdateImplToJson(
      this,
    );
  }
}

abstract class _BattleUpdate implements BattleUpdate {
  const factory _BattleUpdate(
      {required final String battleId,
      required final String userId,
      required final String updateType,
      required final DateTime timestamp,
      final Map<String, dynamic>? data}) = _$BattleUpdateImpl;

  factory _BattleUpdate.fromJson(Map<String, dynamic> json) =
      _$BattleUpdateImpl.fromJson;

  @override
  String get battleId;
  @override
  String get userId;
  @override
  String
      get updateType; // answer_submitted, player_joined, battle_started, battle_ended
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic>? get data;

  /// Create a copy of BattleUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattleUpdateImplCopyWith<_$BattleUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TournamentParticipant _$TournamentParticipantFromJson(
    Map<String, dynamic> json) {
  return _TournamentParticipant.fromJson(json);
}

/// @nodoc
mixin _$TournamentParticipant {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;
  int get seed => throw _privateConstructorUsedError; // Tournament seeding
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  bool get isEliminated => throw _privateConstructorUsedError;
  DateTime? get eliminatedAt => throw _privateConstructorUsedError;

  /// Serializes this TournamentParticipant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TournamentParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentParticipantCopyWith<TournamentParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentParticipantCopyWith<$Res> {
  factory $TournamentParticipantCopyWith(TournamentParticipant value,
          $Res Function(TournamentParticipant) then) =
      _$TournamentParticipantCopyWithImpl<$Res, TournamentParticipant>;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? photoURL,
      DateTime joinedAt,
      int seed,
      int wins,
      int losses,
      int totalScore,
      bool isEliminated,
      DateTime? eliminatedAt});
}

/// @nodoc
class _$TournamentParticipantCopyWithImpl<$Res,
        $Val extends TournamentParticipant>
    implements $TournamentParticipantCopyWith<$Res> {
  _$TournamentParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? joinedAt = null,
    Object? seed = null,
    Object? wins = null,
    Object? losses = null,
    Object? totalScore = null,
    Object? isEliminated = null,
    Object? eliminatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      isEliminated: null == isEliminated
          ? _value.isEliminated
          : isEliminated // ignore: cast_nullable_to_non_nullable
              as bool,
      eliminatedAt: freezed == eliminatedAt
          ? _value.eliminatedAt
          : eliminatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentParticipantImplCopyWith<$Res>
    implements $TournamentParticipantCopyWith<$Res> {
  factory _$$TournamentParticipantImplCopyWith(
          _$TournamentParticipantImpl value,
          $Res Function(_$TournamentParticipantImpl) then) =
      __$$TournamentParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? photoURL,
      DateTime joinedAt,
      int seed,
      int wins,
      int losses,
      int totalScore,
      bool isEliminated,
      DateTime? eliminatedAt});
}

/// @nodoc
class __$$TournamentParticipantImplCopyWithImpl<$Res>
    extends _$TournamentParticipantCopyWithImpl<$Res,
        _$TournamentParticipantImpl>
    implements _$$TournamentParticipantImplCopyWith<$Res> {
  __$$TournamentParticipantImplCopyWithImpl(_$TournamentParticipantImpl _value,
      $Res Function(_$TournamentParticipantImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? joinedAt = null,
    Object? seed = null,
    Object? wins = null,
    Object? losses = null,
    Object? totalScore = null,
    Object? isEliminated = null,
    Object? eliminatedAt = freezed,
  }) {
    return _then(_$TournamentParticipantImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as int,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      isEliminated: null == isEliminated
          ? _value.isEliminated
          : isEliminated // ignore: cast_nullable_to_non_nullable
              as bool,
      eliminatedAt: freezed == eliminatedAt
          ? _value.eliminatedAt
          : eliminatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentParticipantImpl implements _TournamentParticipant {
  const _$TournamentParticipantImpl(
      {required this.userId,
      required this.displayName,
      this.photoURL,
      required this.joinedAt,
      this.seed = 0,
      this.wins = 0,
      this.losses = 0,
      this.totalScore = 0,
      this.isEliminated = false,
      this.eliminatedAt});

  factory _$TournamentParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentParticipantImplFromJson(json);

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? photoURL;
  @override
  final DateTime joinedAt;
  @override
  @JsonKey()
  final int seed;
// Tournament seeding
  @override
  @JsonKey()
  final int wins;
  @override
  @JsonKey()
  final int losses;
  @override
  @JsonKey()
  final int totalScore;
  @override
  @JsonKey()
  final bool isEliminated;
  @override
  final DateTime? eliminatedAt;

  @override
  String toString() {
    return 'TournamentParticipant(userId: $userId, displayName: $displayName, photoURL: $photoURL, joinedAt: $joinedAt, seed: $seed, wins: $wins, losses: $losses, totalScore: $totalScore, isEliminated: $isEliminated, eliminatedAt: $eliminatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentParticipantImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.isEliminated, isEliminated) ||
                other.isEliminated == isEliminated) &&
            (identical(other.eliminatedAt, eliminatedAt) ||
                other.eliminatedAt == eliminatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, displayName, photoURL,
      joinedAt, seed, wins, losses, totalScore, isEliminated, eliminatedAt);

  /// Create a copy of TournamentParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentParticipantImplCopyWith<_$TournamentParticipantImpl>
      get copyWith => __$$TournamentParticipantImplCopyWithImpl<
          _$TournamentParticipantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentParticipantImplToJson(
      this,
    );
  }
}

abstract class _TournamentParticipant implements TournamentParticipant {
  const factory _TournamentParticipant(
      {required final String userId,
      required final String displayName,
      final String? photoURL,
      required final DateTime joinedAt,
      final int seed,
      final int wins,
      final int losses,
      final int totalScore,
      final bool isEliminated,
      final DateTime? eliminatedAt}) = _$TournamentParticipantImpl;

  factory _TournamentParticipant.fromJson(Map<String, dynamic> json) =
      _$TournamentParticipantImpl.fromJson;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get photoURL;
  @override
  DateTime get joinedAt;
  @override
  int get seed; // Tournament seeding
  @override
  int get wins;
  @override
  int get losses;
  @override
  int get totalScore;
  @override
  bool get isEliminated;
  @override
  DateTime? get eliminatedAt;

  /// Create a copy of TournamentParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentParticipantImplCopyWith<_$TournamentParticipantImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TournamentRound _$TournamentRoundFromJson(Map<String, dynamic> json) {
  return _TournamentRound.fromJson(json);
}

/// @nodoc
mixin _$TournamentRound {
  int get roundNumber => throw _privateConstructorUsedError;
  String get roundName =>
      throw _privateConstructorUsedError; // Quarterfinals, Semifinals, Finals
  List<String> get battleIds => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // pending, in_progress, completed
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this TournamentRound to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TournamentRound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentRoundCopyWith<TournamentRound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentRoundCopyWith<$Res> {
  factory $TournamentRoundCopyWith(
          TournamentRound value, $Res Function(TournamentRound) then) =
      _$TournamentRoundCopyWithImpl<$Res, TournamentRound>;
  @useResult
  $Res call(
      {int roundNumber,
      String roundName,
      List<String> battleIds,
      String status,
      DateTime? startedAt,
      DateTime? completedAt});
}

/// @nodoc
class _$TournamentRoundCopyWithImpl<$Res, $Val extends TournamentRound>
    implements $TournamentRoundCopyWith<$Res> {
  _$TournamentRoundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentRound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundNumber = null,
    Object? roundName = null,
    Object? battleIds = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      roundNumber: null == roundNumber
          ? _value.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      roundName: null == roundName
          ? _value.roundName
          : roundName // ignore: cast_nullable_to_non_nullable
              as String,
      battleIds: null == battleIds
          ? _value.battleIds
          : battleIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentRoundImplCopyWith<$Res>
    implements $TournamentRoundCopyWith<$Res> {
  factory _$$TournamentRoundImplCopyWith(_$TournamentRoundImpl value,
          $Res Function(_$TournamentRoundImpl) then) =
      __$$TournamentRoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int roundNumber,
      String roundName,
      List<String> battleIds,
      String status,
      DateTime? startedAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$TournamentRoundImplCopyWithImpl<$Res>
    extends _$TournamentRoundCopyWithImpl<$Res, _$TournamentRoundImpl>
    implements _$$TournamentRoundImplCopyWith<$Res> {
  __$$TournamentRoundImplCopyWithImpl(
      _$TournamentRoundImpl _value, $Res Function(_$TournamentRoundImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentRound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundNumber = null,
    Object? roundName = null,
    Object? battleIds = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$TournamentRoundImpl(
      roundNumber: null == roundNumber
          ? _value.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      roundName: null == roundName
          ? _value.roundName
          : roundName // ignore: cast_nullable_to_non_nullable
              as String,
      battleIds: null == battleIds
          ? _value._battleIds
          : battleIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentRoundImpl implements _TournamentRound {
  const _$TournamentRoundImpl(
      {required this.roundNumber,
      required this.roundName,
      required final List<String> battleIds,
      this.status = 'pending',
      this.startedAt,
      this.completedAt})
      : _battleIds = battleIds;

  factory _$TournamentRoundImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentRoundImplFromJson(json);

  @override
  final int roundNumber;
  @override
  final String roundName;
// Quarterfinals, Semifinals, Finals
  final List<String> _battleIds;
// Quarterfinals, Semifinals, Finals
  @override
  List<String> get battleIds {
    if (_battleIds is EqualUnmodifiableListView) return _battleIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_battleIds);
  }

  @override
  @JsonKey()
  final String status;
// pending, in_progress, completed
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'TournamentRound(roundNumber: $roundNumber, roundName: $roundName, battleIds: $battleIds, status: $status, startedAt: $startedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentRoundImpl &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.roundName, roundName) ||
                other.roundName == roundName) &&
            const DeepCollectionEquality()
                .equals(other._battleIds, _battleIds) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      roundNumber,
      roundName,
      const DeepCollectionEquality().hash(_battleIds),
      status,
      startedAt,
      completedAt);

  /// Create a copy of TournamentRound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentRoundImplCopyWith<_$TournamentRoundImpl> get copyWith =>
      __$$TournamentRoundImplCopyWithImpl<_$TournamentRoundImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentRoundImplToJson(
      this,
    );
  }
}

abstract class _TournamentRound implements TournamentRound {
  const factory _TournamentRound(
      {required final int roundNumber,
      required final String roundName,
      required final List<String> battleIds,
      final String status,
      final DateTime? startedAt,
      final DateTime? completedAt}) = _$TournamentRoundImpl;

  factory _TournamentRound.fromJson(Map<String, dynamic> json) =
      _$TournamentRoundImpl.fromJson;

  @override
  int get roundNumber;
  @override
  String get roundName; // Quarterfinals, Semifinals, Finals
  @override
  List<String> get battleIds;
  @override
  String get status; // pending, in_progress, completed
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of TournamentRound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentRoundImplCopyWith<_$TournamentRoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Tournament _$TournamentFromJson(Map<String, dynamic> json) {
  return _Tournament.fromJson(json);
}

/// @nodoc
mixin _$Tournament {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get titleAr => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get descriptionAr => throw _privateConstructorUsedError;
  TournamentStatus get status => throw _privateConstructorUsedError;
  BracketType get bracketType => throw _privateConstructorUsedError;
  BattleConfig get battleConfig => throw _privateConstructorUsedError;
  int get maxParticipants =>
      throw _privateConstructorUsedError; // 4, 8, 16, 32, etc.
  int get minParticipants => throw _privateConstructorUsedError;
  List<TournamentParticipant> get participants =>
      throw _privateConstructorUsedError;
  List<TournamentRound> get rounds => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get registrationDeadline => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get winnerId => throw _privateConstructorUsedError;
  String? get createdBy =>
      throw _privateConstructorUsedError; // Admin/organizer
  int get entryEnergyCost => throw _privateConstructorUsedError;
  bool get isPremiumOnly => throw _privateConstructorUsedError;
  Map<String, dynamic>? get prizes => throw _privateConstructorUsedError;

  /// Serializes this Tournament to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentCopyWith<Tournament> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentCopyWith<$Res> {
  factory $TournamentCopyWith(
          Tournament value, $Res Function(Tournament) then) =
      _$TournamentCopyWithImpl<$Res, Tournament>;
  @useResult
  $Res call(
      {String id,
      String title,
      String titleAr,
      String? description,
      String? descriptionAr,
      TournamentStatus status,
      BracketType bracketType,
      BattleConfig battleConfig,
      int maxParticipants,
      int minParticipants,
      List<TournamentParticipant> participants,
      List<TournamentRound> rounds,
      DateTime createdAt,
      DateTime registrationDeadline,
      DateTime? startedAt,
      DateTime? completedAt,
      String? winnerId,
      String? createdBy,
      int entryEnergyCost,
      bool isPremiumOnly,
      Map<String, dynamic>? prizes});

  $BattleConfigCopyWith<$Res> get battleConfig;
}

/// @nodoc
class _$TournamentCopyWithImpl<$Res, $Val extends Tournament>
    implements $TournamentCopyWith<$Res> {
  _$TournamentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? titleAr = null,
    Object? description = freezed,
    Object? descriptionAr = freezed,
    Object? status = null,
    Object? bracketType = null,
    Object? battleConfig = null,
    Object? maxParticipants = null,
    Object? minParticipants = null,
    Object? participants = null,
    Object? rounds = null,
    Object? createdAt = null,
    Object? registrationDeadline = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? winnerId = freezed,
    Object? createdBy = freezed,
    Object? entryEnergyCost = null,
    Object? isPremiumOnly = null,
    Object? prizes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionAr: freezed == descriptionAr
          ? _value.descriptionAr
          : descriptionAr // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
      bracketType: null == bracketType
          ? _value.bracketType
          : bracketType // ignore: cast_nullable_to_non_nullable
              as BracketType,
      battleConfig: null == battleConfig
          ? _value.battleConfig
          : battleConfig // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      maxParticipants: null == maxParticipants
          ? _value.maxParticipants
          : maxParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      minParticipants: null == minParticipants
          ? _value.minParticipants
          : minParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<TournamentParticipant>,
      rounds: null == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<TournamentRound>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      registrationDeadline: null == registrationDeadline
          ? _value.registrationDeadline
          : registrationDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      entryEnergyCost: null == entryEnergyCost
          ? _value.entryEnergyCost
          : entryEnergyCost // ignore: cast_nullable_to_non_nullable
              as int,
      isPremiumOnly: null == isPremiumOnly
          ? _value.isPremiumOnly
          : isPremiumOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      prizes: freezed == prizes
          ? _value.prizes
          : prizes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BattleConfigCopyWith<$Res> get battleConfig {
    return $BattleConfigCopyWith<$Res>(_value.battleConfig, (value) {
      return _then(_value.copyWith(battleConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TournamentImplCopyWith<$Res>
    implements $TournamentCopyWith<$Res> {
  factory _$$TournamentImplCopyWith(
          _$TournamentImpl value, $Res Function(_$TournamentImpl) then) =
      __$$TournamentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String titleAr,
      String? description,
      String? descriptionAr,
      TournamentStatus status,
      BracketType bracketType,
      BattleConfig battleConfig,
      int maxParticipants,
      int minParticipants,
      List<TournamentParticipant> participants,
      List<TournamentRound> rounds,
      DateTime createdAt,
      DateTime registrationDeadline,
      DateTime? startedAt,
      DateTime? completedAt,
      String? winnerId,
      String? createdBy,
      int entryEnergyCost,
      bool isPremiumOnly,
      Map<String, dynamic>? prizes});

  @override
  $BattleConfigCopyWith<$Res> get battleConfig;
}

/// @nodoc
class __$$TournamentImplCopyWithImpl<$Res>
    extends _$TournamentCopyWithImpl<$Res, _$TournamentImpl>
    implements _$$TournamentImplCopyWith<$Res> {
  __$$TournamentImplCopyWithImpl(
      _$TournamentImpl _value, $Res Function(_$TournamentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? titleAr = null,
    Object? description = freezed,
    Object? descriptionAr = freezed,
    Object? status = null,
    Object? bracketType = null,
    Object? battleConfig = null,
    Object? maxParticipants = null,
    Object? minParticipants = null,
    Object? participants = null,
    Object? rounds = null,
    Object? createdAt = null,
    Object? registrationDeadline = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? winnerId = freezed,
    Object? createdBy = freezed,
    Object? entryEnergyCost = null,
    Object? isPremiumOnly = null,
    Object? prizes = freezed,
  }) {
    return _then(_$TournamentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      titleAr: null == titleAr
          ? _value.titleAr
          : titleAr // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      descriptionAr: freezed == descriptionAr
          ? _value.descriptionAr
          : descriptionAr // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TournamentStatus,
      bracketType: null == bracketType
          ? _value.bracketType
          : bracketType // ignore: cast_nullable_to_non_nullable
              as BracketType,
      battleConfig: null == battleConfig
          ? _value.battleConfig
          : battleConfig // ignore: cast_nullable_to_non_nullable
              as BattleConfig,
      maxParticipants: null == maxParticipants
          ? _value.maxParticipants
          : maxParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      minParticipants: null == minParticipants
          ? _value.minParticipants
          : minParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<TournamentParticipant>,
      rounds: null == rounds
          ? _value._rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as List<TournamentRound>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      registrationDeadline: null == registrationDeadline
          ? _value.registrationDeadline
          : registrationDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      entryEnergyCost: null == entryEnergyCost
          ? _value.entryEnergyCost
          : entryEnergyCost // ignore: cast_nullable_to_non_nullable
              as int,
      isPremiumOnly: null == isPremiumOnly
          ? _value.isPremiumOnly
          : isPremiumOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      prizes: freezed == prizes
          ? _value._prizes
          : prizes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TournamentImpl implements _Tournament {
  const _$TournamentImpl(
      {required this.id,
      required this.title,
      required this.titleAr,
      this.description,
      this.descriptionAr,
      required this.status,
      required this.bracketType,
      required this.battleConfig,
      required this.maxParticipants,
      required this.minParticipants,
      required final List<TournamentParticipant> participants,
      required final List<TournamentRound> rounds,
      required this.createdAt,
      required this.registrationDeadline,
      this.startedAt,
      this.completedAt,
      this.winnerId,
      this.createdBy,
      this.entryEnergyCost = 0,
      this.isPremiumOnly = false,
      final Map<String, dynamic>? prizes})
      : _participants = participants,
        _rounds = rounds,
        _prizes = prizes;

  factory _$TournamentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TournamentImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String titleAr;
  @override
  final String? description;
  @override
  final String? descriptionAr;
  @override
  final TournamentStatus status;
  @override
  final BracketType bracketType;
  @override
  final BattleConfig battleConfig;
  @override
  final int maxParticipants;
// 4, 8, 16, 32, etc.
  @override
  final int minParticipants;
  final List<TournamentParticipant> _participants;
  @override
  List<TournamentParticipant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  final List<TournamentRound> _rounds;
  @override
  List<TournamentRound> get rounds {
    if (_rounds is EqualUnmodifiableListView) return _rounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rounds);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime registrationDeadline;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String? winnerId;
  @override
  final String? createdBy;
// Admin/organizer
  @override
  @JsonKey()
  final int entryEnergyCost;
  @override
  @JsonKey()
  final bool isPremiumOnly;
  final Map<String, dynamic>? _prizes;
  @override
  Map<String, dynamic>? get prizes {
    final value = _prizes;
    if (value == null) return null;
    if (_prizes is EqualUnmodifiableMapView) return _prizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Tournament(id: $id, title: $title, titleAr: $titleAr, description: $description, descriptionAr: $descriptionAr, status: $status, bracketType: $bracketType, battleConfig: $battleConfig, maxParticipants: $maxParticipants, minParticipants: $minParticipants, participants: $participants, rounds: $rounds, createdAt: $createdAt, registrationDeadline: $registrationDeadline, startedAt: $startedAt, completedAt: $completedAt, winnerId: $winnerId, createdBy: $createdBy, entryEnergyCost: $entryEnergyCost, isPremiumOnly: $isPremiumOnly, prizes: $prizes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionAr, descriptionAr) ||
                other.descriptionAr == descriptionAr) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.bracketType, bracketType) ||
                other.bracketType == bracketType) &&
            (identical(other.battleConfig, battleConfig) ||
                other.battleConfig == battleConfig) &&
            (identical(other.maxParticipants, maxParticipants) ||
                other.maxParticipants == maxParticipants) &&
            (identical(other.minParticipants, minParticipants) ||
                other.minParticipants == minParticipants) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            const DeepCollectionEquality().equals(other._rounds, _rounds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.registrationDeadline, registrationDeadline) ||
                other.registrationDeadline == registrationDeadline) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.entryEnergyCost, entryEnergyCost) ||
                other.entryEnergyCost == entryEnergyCost) &&
            (identical(other.isPremiumOnly, isPremiumOnly) ||
                other.isPremiumOnly == isPremiumOnly) &&
            const DeepCollectionEquality().equals(other._prizes, _prizes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        titleAr,
        description,
        descriptionAr,
        status,
        bracketType,
        battleConfig,
        maxParticipants,
        minParticipants,
        const DeepCollectionEquality().hash(_participants),
        const DeepCollectionEquality().hash(_rounds),
        createdAt,
        registrationDeadline,
        startedAt,
        completedAt,
        winnerId,
        createdBy,
        entryEnergyCost,
        isPremiumOnly,
        const DeepCollectionEquality().hash(_prizes)
      ]);

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentImplCopyWith<_$TournamentImpl> get copyWith =>
      __$$TournamentImplCopyWithImpl<_$TournamentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TournamentImplToJson(
      this,
    );
  }
}

abstract class _Tournament implements Tournament {
  const factory _Tournament(
      {required final String id,
      required final String title,
      required final String titleAr,
      final String? description,
      final String? descriptionAr,
      required final TournamentStatus status,
      required final BracketType bracketType,
      required final BattleConfig battleConfig,
      required final int maxParticipants,
      required final int minParticipants,
      required final List<TournamentParticipant> participants,
      required final List<TournamentRound> rounds,
      required final DateTime createdAt,
      required final DateTime registrationDeadline,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final String? winnerId,
      final String? createdBy,
      final int entryEnergyCost,
      final bool isPremiumOnly,
      final Map<String, dynamic>? prizes}) = _$TournamentImpl;

  factory _Tournament.fromJson(Map<String, dynamic> json) =
      _$TournamentImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get titleAr;
  @override
  String? get description;
  @override
  String? get descriptionAr;
  @override
  TournamentStatus get status;
  @override
  BracketType get bracketType;
  @override
  BattleConfig get battleConfig;
  @override
  int get maxParticipants; // 4, 8, 16, 32, etc.
  @override
  int get minParticipants;
  @override
  List<TournamentParticipant> get participants;
  @override
  List<TournamentRound> get rounds;
  @override
  DateTime get createdAt;
  @override
  DateTime get registrationDeadline;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  String? get winnerId;
  @override
  String? get createdBy; // Admin/organizer
  @override
  int get entryEnergyCost;
  @override
  bool get isPremiumOnly;
  @override
  Map<String, dynamic>? get prizes;

  /// Create a copy of Tournament
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentImplCopyWith<_$TournamentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattleHistoryEntry _$BattleHistoryEntryFromJson(Map<String, dynamic> json) {
  return _BattleHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$BattleHistoryEntry {
  String get battleId => throw _privateConstructorUsedError;
  String get opponentId => throw _privateConstructorUsedError;
  String get opponentName => throw _privateConstructorUsedError;
  String? get opponentPhoto => throw _privateConstructorUsedError;
  bool get isWinner => throw _privateConstructorUsedError;
  int get myScore => throw _privateConstructorUsedError;
  int get opponentScore => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;
  String get battleType => throw _privateConstructorUsedError;
  int get pointsEarned => throw _privateConstructorUsedError;
  int get ratingChange => throw _privateConstructorUsedError;

  /// Serializes this BattleHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BattleHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BattleHistoryEntryCopyWith<BattleHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleHistoryEntryCopyWith<$Res> {
  factory $BattleHistoryEntryCopyWith(
          BattleHistoryEntry value, $Res Function(BattleHistoryEntry) then) =
      _$BattleHistoryEntryCopyWithImpl<$Res, BattleHistoryEntry>;
  @useResult
  $Res call(
      {String battleId,
      String opponentId,
      String opponentName,
      String? opponentPhoto,
      bool isWinner,
      int myScore,
      int opponentScore,
      DateTime completedAt,
      String battleType,
      int pointsEarned,
      int ratingChange});
}

/// @nodoc
class _$BattleHistoryEntryCopyWithImpl<$Res, $Val extends BattleHistoryEntry>
    implements $BattleHistoryEntryCopyWith<$Res> {
  _$BattleHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BattleHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? opponentId = null,
    Object? opponentName = null,
    Object? opponentPhoto = freezed,
    Object? isWinner = null,
    Object? myScore = null,
    Object? opponentScore = null,
    Object? completedAt = null,
    Object? battleType = null,
    Object? pointsEarned = null,
    Object? ratingChange = null,
  }) {
    return _then(_value.copyWith(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      opponentId: null == opponentId
          ? _value.opponentId
          : opponentId // ignore: cast_nullable_to_non_nullable
              as String,
      opponentName: null == opponentName
          ? _value.opponentName
          : opponentName // ignore: cast_nullable_to_non_nullable
              as String,
      opponentPhoto: freezed == opponentPhoto
          ? _value.opponentPhoto
          : opponentPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      isWinner: null == isWinner
          ? _value.isWinner
          : isWinner // ignore: cast_nullable_to_non_nullable
              as bool,
      myScore: null == myScore
          ? _value.myScore
          : myScore // ignore: cast_nullable_to_non_nullable
              as int,
      opponentScore: null == opponentScore
          ? _value.opponentScore
          : opponentScore // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      battleType: null == battleType
          ? _value.battleType
          : battleType // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      ratingChange: null == ratingChange
          ? _value.ratingChange
          : ratingChange // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleHistoryEntryImplCopyWith<$Res>
    implements $BattleHistoryEntryCopyWith<$Res> {
  factory _$$BattleHistoryEntryImplCopyWith(_$BattleHistoryEntryImpl value,
          $Res Function(_$BattleHistoryEntryImpl) then) =
      __$$BattleHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String battleId,
      String opponentId,
      String opponentName,
      String? opponentPhoto,
      bool isWinner,
      int myScore,
      int opponentScore,
      DateTime completedAt,
      String battleType,
      int pointsEarned,
      int ratingChange});
}

/// @nodoc
class __$$BattleHistoryEntryImplCopyWithImpl<$Res>
    extends _$BattleHistoryEntryCopyWithImpl<$Res, _$BattleHistoryEntryImpl>
    implements _$$BattleHistoryEntryImplCopyWith<$Res> {
  __$$BattleHistoryEntryImplCopyWithImpl(_$BattleHistoryEntryImpl _value,
      $Res Function(_$BattleHistoryEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BattleHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? opponentId = null,
    Object? opponentName = null,
    Object? opponentPhoto = freezed,
    Object? isWinner = null,
    Object? myScore = null,
    Object? opponentScore = null,
    Object? completedAt = null,
    Object? battleType = null,
    Object? pointsEarned = null,
    Object? ratingChange = null,
  }) {
    return _then(_$BattleHistoryEntryImpl(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      opponentId: null == opponentId
          ? _value.opponentId
          : opponentId // ignore: cast_nullable_to_non_nullable
              as String,
      opponentName: null == opponentName
          ? _value.opponentName
          : opponentName // ignore: cast_nullable_to_non_nullable
              as String,
      opponentPhoto: freezed == opponentPhoto
          ? _value.opponentPhoto
          : opponentPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      isWinner: null == isWinner
          ? _value.isWinner
          : isWinner // ignore: cast_nullable_to_non_nullable
              as bool,
      myScore: null == myScore
          ? _value.myScore
          : myScore // ignore: cast_nullable_to_non_nullable
              as int,
      opponentScore: null == opponentScore
          ? _value.opponentScore
          : opponentScore // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      battleType: null == battleType
          ? _value.battleType
          : battleType // ignore: cast_nullable_to_non_nullable
              as String,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      ratingChange: null == ratingChange
          ? _value.ratingChange
          : ratingChange // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleHistoryEntryImpl implements _BattleHistoryEntry {
  const _$BattleHistoryEntryImpl(
      {required this.battleId,
      required this.opponentId,
      required this.opponentName,
      this.opponentPhoto,
      required this.isWinner,
      required this.myScore,
      required this.opponentScore,
      required this.completedAt,
      required this.battleType,
      this.pointsEarned = 0,
      this.ratingChange = 0});

  factory _$BattleHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleHistoryEntryImplFromJson(json);

  @override
  final String battleId;
  @override
  final String opponentId;
  @override
  final String opponentName;
  @override
  final String? opponentPhoto;
  @override
  final bool isWinner;
  @override
  final int myScore;
  @override
  final int opponentScore;
  @override
  final DateTime completedAt;
  @override
  final String battleType;
  @override
  @JsonKey()
  final int pointsEarned;
  @override
  @JsonKey()
  final int ratingChange;

  @override
  String toString() {
    return 'BattleHistoryEntry(battleId: $battleId, opponentId: $opponentId, opponentName: $opponentName, opponentPhoto: $opponentPhoto, isWinner: $isWinner, myScore: $myScore, opponentScore: $opponentScore, completedAt: $completedAt, battleType: $battleType, pointsEarned: $pointsEarned, ratingChange: $ratingChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleHistoryEntryImpl &&
            (identical(other.battleId, battleId) ||
                other.battleId == battleId) &&
            (identical(other.opponentId, opponentId) ||
                other.opponentId == opponentId) &&
            (identical(other.opponentName, opponentName) ||
                other.opponentName == opponentName) &&
            (identical(other.opponentPhoto, opponentPhoto) ||
                other.opponentPhoto == opponentPhoto) &&
            (identical(other.isWinner, isWinner) ||
                other.isWinner == isWinner) &&
            (identical(other.myScore, myScore) || other.myScore == myScore) &&
            (identical(other.opponentScore, opponentScore) ||
                other.opponentScore == opponentScore) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.battleType, battleType) ||
                other.battleType == battleType) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned) &&
            (identical(other.ratingChange, ratingChange) ||
                other.ratingChange == ratingChange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      battleId,
      opponentId,
      opponentName,
      opponentPhoto,
      isWinner,
      myScore,
      opponentScore,
      completedAt,
      battleType,
      pointsEarned,
      ratingChange);

  /// Create a copy of BattleHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleHistoryEntryImplCopyWith<_$BattleHistoryEntryImpl> get copyWith =>
      __$$BattleHistoryEntryImplCopyWithImpl<_$BattleHistoryEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _BattleHistoryEntry implements BattleHistoryEntry {
  const factory _BattleHistoryEntry(
      {required final String battleId,
      required final String opponentId,
      required final String opponentName,
      final String? opponentPhoto,
      required final bool isWinner,
      required final int myScore,
      required final int opponentScore,
      required final DateTime completedAt,
      required final String battleType,
      final int pointsEarned,
      final int ratingChange}) = _$BattleHistoryEntryImpl;

  factory _BattleHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$BattleHistoryEntryImpl.fromJson;

  @override
  String get battleId;
  @override
  String get opponentId;
  @override
  String get opponentName;
  @override
  String? get opponentPhoto;
  @override
  bool get isWinner;
  @override
  int get myScore;
  @override
  int get opponentScore;
  @override
  DateTime get completedAt;
  @override
  String get battleType;
  @override
  int get pointsEarned;
  @override
  int get ratingChange;

  /// Create a copy of BattleHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BattleHistoryEntryImplCopyWith<_$BattleHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
