// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattlePlayerImpl _$$BattlePlayerImplFromJson(Map<String, dynamic> json) =>
    _$BattlePlayerImpl(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      photoURL: json['photoURL'] as String?,
      score: (json['score'] as num?)?.toInt() ?? 0,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
      wrongAnswers: (json['wrongAnswers'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      answeredCount: (json['answeredCount'] as num?)?.toInt() ?? 0,
      isReady: json['isReady'] as bool? ?? false,
      hasFinished: json['hasFinished'] as bool? ?? false,
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      lastAnswer: json['lastAnswer'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$BattlePlayerImplToJson(_$BattlePlayerImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'score': instance.score,
      'correctAnswers': instance.correctAnswers,
      'wrongAnswers': instance.wrongAnswers,
      'currentStreak': instance.currentStreak,
      'answeredCount': instance.answeredCount,
      'isReady': instance.isReady,
      'hasFinished': instance.hasFinished,
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'lastAnswer': instance.lastAnswer,
    };

_$BattleConfigImpl _$$BattleConfigImplFromJson(Map<String, dynamic> json) =>
    _$BattleConfigImpl(
      questionCount: (json['questionCount'] as num?)?.toInt() ?? 10,
      category: json['category'] as String?,
      difficulty: json['difficulty'] as String?,
      language: json['language'] as String? ?? 'en',
      timePerQuestion: (json['timePerQuestion'] as num?)?.toInt() ?? 30,
      energyCost: (json['energyCost'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$$BattleConfigImplToJson(_$BattleConfigImpl instance) =>
    <String, dynamic>{
      'questionCount': instance.questionCount,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'language': instance.language,
      'timePerQuestion': instance.timePerQuestion,
      'energyCost': instance.energyCost,
    };

_$BattleImpl _$$BattleImplFromJson(Map<String, dynamic> json) => _$BattleImpl(
      id: json['id'] as String,
      type: $enumDecode(_$BattleTypeEnumMap, json['type']),
      status: $enumDecode(_$BattleStatusEnumMap, json['status']),
      player1: BattlePlayer.fromJson(json['player1'] as Map<String, dynamic>),
      player2: json['player2'] == null
          ? null
          : BattlePlayer.fromJson(json['player2'] as Map<String, dynamic>),
      config: BattleConfig.fromJson(json['config'] as Map<String, dynamic>),
      questionIds: (json['questionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      winnerId: json['winnerId'] as String?,
      tournamentId: json['tournamentId'] as String?,
      isRanked: json['isRanked'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$BattleImplToJson(_$BattleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$BattleTypeEnumMap[instance.type]!,
      'status': _$BattleStatusEnumMap[instance.status]!,
      'player1': instance.player1,
      'player2': instance.player2,
      'config': instance.config,
      'questionIds': instance.questionIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'winnerId': instance.winnerId,
      'tournamentId': instance.tournamentId,
      'isRanked': instance.isRanked,
      'metadata': instance.metadata,
    };

const _$BattleTypeEnumMap = {
  BattleType.quick: 'quick',
  BattleType.friend: 'friend',
  BattleType.tournament: 'tournament',
};

const _$BattleStatusEnumMap = {
  BattleStatus.waiting: 'waiting',
  BattleStatus.ready: 'ready',
  BattleStatus.inProgress: 'inProgress',
  BattleStatus.completed: 'completed',
  BattleStatus.cancelled: 'cancelled',
  BattleStatus.abandoned: 'abandoned',
};

_$BattleInvitationImpl _$$BattleInvitationImplFromJson(
        Map<String, dynamic> json) =>
    _$BattleInvitationImpl(
      id: json['id'] as String,
      battleId: json['battleId'] as String,
      fromUserId: json['fromUserId'] as String,
      fromUserName: json['fromUserName'] as String,
      fromUserPhoto: json['fromUserPhoto'] as String?,
      toUserId: json['toUserId'] as String,
      config: BattleConfig.fromJson(json['config'] as Map<String, dynamic>),
      status: json['status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['createdAt'] as String),
      respondedAt: json['respondedAt'] == null
          ? null
          : DateTime.parse(json['respondedAt'] as String),
      expirySeconds: (json['expirySeconds'] as num?)?.toInt() ?? 300,
    );

Map<String, dynamic> _$$BattleInvitationImplToJson(
        _$BattleInvitationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'battleId': instance.battleId,
      'fromUserId': instance.fromUserId,
      'fromUserName': instance.fromUserName,
      'fromUserPhoto': instance.fromUserPhoto,
      'toUserId': instance.toUserId,
      'config': instance.config,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'expirySeconds': instance.expirySeconds,
    };

_$MatchmakingEntryImpl _$$MatchmakingEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchmakingEntryImpl(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      photoURL: json['photoURL'] as String?,
      config: BattleConfig.fromJson(json['config'] as Map<String, dynamic>),
      userRating: (json['userRating'] as num).toInt(),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      timeoutSeconds: (json['timeoutSeconds'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$$MatchmakingEntryImplToJson(
        _$MatchmakingEntryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'config': instance.config,
      'userRating': instance.userRating,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'timeoutSeconds': instance.timeoutSeconds,
    };

_$BattleStatsImpl _$$BattleStatsImplFromJson(Map<String, dynamic> json) =>
    _$BattleStatsImpl(
      totalBattles: (json['totalBattles'] as num?)?.toInt() ?? 0,
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      draws: (json['draws'] as num?)?.toInt() ?? 0,
      winStreak: (json['winStreak'] as num?)?.toInt() ?? 0,
      longestWinStreak: (json['longestWinStreak'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toInt() ?? 1000,
      totalPointsEarned: (json['totalPointsEarned'] as num?)?.toInt() ?? 0,
      lastBattleAt: json['lastBattleAt'] == null
          ? null
          : DateTime.parse(json['lastBattleAt'] as String),
    );

Map<String, dynamic> _$$BattleStatsImplToJson(_$BattleStatsImpl instance) =>
    <String, dynamic>{
      'totalBattles': instance.totalBattles,
      'wins': instance.wins,
      'losses': instance.losses,
      'draws': instance.draws,
      'winStreak': instance.winStreak,
      'longestWinStreak': instance.longestWinStreak,
      'rating': instance.rating,
      'totalPointsEarned': instance.totalPointsEarned,
      'lastBattleAt': instance.lastBattleAt?.toIso8601String(),
    };

_$BattleResultImpl _$$BattleResultImplFromJson(Map<String, dynamic> json) =>
    _$BattleResultImpl(
      battleId: json['battleId'] as String,
      player1: BattlePlayer.fromJson(json['player1'] as Map<String, dynamic>),
      player2: BattlePlayer.fromJson(json['player2'] as Map<String, dynamic>),
      winnerId: json['winnerId'] as String,
      loserId: json['loserId'] as String,
      winnerScore: (json['winnerScore'] as num).toInt(),
      loserScore: (json['loserScore'] as num).toInt(),
      scoreDifference: (json['scoreDifference'] as num).toInt(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      battleType: json['battleType'] as String?,
    );

Map<String, dynamic> _$$BattleResultImplToJson(_$BattleResultImpl instance) =>
    <String, dynamic>{
      'battleId': instance.battleId,
      'player1': instance.player1,
      'player2': instance.player2,
      'winnerId': instance.winnerId,
      'loserId': instance.loserId,
      'winnerScore': instance.winnerScore,
      'loserScore': instance.loserScore,
      'scoreDifference': instance.scoreDifference,
      'completedAt': instance.completedAt.toIso8601String(),
      'durationSeconds': instance.durationSeconds,
      'battleType': instance.battleType,
    };

_$BattleUpdateImpl _$$BattleUpdateImplFromJson(Map<String, dynamic> json) =>
    _$BattleUpdateImpl(
      battleId: json['battleId'] as String,
      userId: json['userId'] as String,
      updateType: json['updateType'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$BattleUpdateImplToJson(_$BattleUpdateImpl instance) =>
    <String, dynamic>{
      'battleId': instance.battleId,
      'userId': instance.userId,
      'updateType': instance.updateType,
      'timestamp': instance.timestamp.toIso8601String(),
      'data': instance.data,
    };

_$TournamentParticipantImpl _$$TournamentParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentParticipantImpl(
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      photoURL: json['photoURL'] as String?,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      seed: (json['seed'] as num?)?.toInt() ?? 0,
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      totalScore: (json['totalScore'] as num?)?.toInt() ?? 0,
      isEliminated: json['isEliminated'] as bool? ?? false,
      eliminatedAt: json['eliminatedAt'] == null
          ? null
          : DateTime.parse(json['eliminatedAt'] as String),
    );

Map<String, dynamic> _$$TournamentParticipantImplToJson(
        _$TournamentParticipantImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'seed': instance.seed,
      'wins': instance.wins,
      'losses': instance.losses,
      'totalScore': instance.totalScore,
      'isEliminated': instance.isEliminated,
      'eliminatedAt': instance.eliminatedAt?.toIso8601String(),
    };

_$TournamentRoundImpl _$$TournamentRoundImplFromJson(
        Map<String, dynamic> json) =>
    _$TournamentRoundImpl(
      roundNumber: (json['roundNumber'] as num).toInt(),
      roundName: json['roundName'] as String,
      battleIds:
          (json['battleIds'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as String? ?? 'pending',
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$TournamentRoundImplToJson(
        _$TournamentRoundImpl instance) =>
    <String, dynamic>{
      'roundNumber': instance.roundNumber,
      'roundName': instance.roundName,
      'battleIds': instance.battleIds,
      'status': instance.status,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

_$TournamentImpl _$$TournamentImplFromJson(Map<String, dynamic> json) =>
    _$TournamentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      titleAr: json['titleAr'] as String,
      description: json['description'] as String?,
      descriptionAr: json['descriptionAr'] as String?,
      status: $enumDecode(_$TournamentStatusEnumMap, json['status']),
      bracketType: $enumDecode(_$BracketTypeEnumMap, json['bracketType']),
      battleConfig:
          BattleConfig.fromJson(json['battleConfig'] as Map<String, dynamic>),
      maxParticipants: (json['maxParticipants'] as num).toInt(),
      minParticipants: (json['minParticipants'] as num).toInt(),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => TournamentParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
      rounds: (json['rounds'] as List<dynamic>)
          .map((e) => TournamentRound.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      registrationDeadline:
          DateTime.parse(json['registrationDeadline'] as String),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      winnerId: json['winnerId'] as String?,
      createdBy: json['createdBy'] as String?,
      entryEnergyCost: (json['entryEnergyCost'] as num?)?.toInt() ?? 0,
      isPremiumOnly: json['isPremiumOnly'] as bool? ?? false,
      prizes: json['prizes'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$TournamentImplToJson(_$TournamentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleAr': instance.titleAr,
      'description': instance.description,
      'descriptionAr': instance.descriptionAr,
      'status': _$TournamentStatusEnumMap[instance.status]!,
      'bracketType': _$BracketTypeEnumMap[instance.bracketType]!,
      'battleConfig': instance.battleConfig,
      'maxParticipants': instance.maxParticipants,
      'minParticipants': instance.minParticipants,
      'participants': instance.participants,
      'rounds': instance.rounds,
      'createdAt': instance.createdAt.toIso8601String(),
      'registrationDeadline': instance.registrationDeadline.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'winnerId': instance.winnerId,
      'createdBy': instance.createdBy,
      'entryEnergyCost': instance.entryEnergyCost,
      'isPremiumOnly': instance.isPremiumOnly,
      'prizes': instance.prizes,
    };

const _$TournamentStatusEnumMap = {
  TournamentStatus.registration: 'registration',
  TournamentStatus.ready: 'ready',
  TournamentStatus.inProgress: 'inProgress',
  TournamentStatus.completed: 'completed',
  TournamentStatus.cancelled: 'cancelled',
};

const _$BracketTypeEnumMap = {
  BracketType.singleElimination: 'singleElimination',
  BracketType.doubleElimination: 'doubleElimination',
  BracketType.roundRobin: 'roundRobin',
};

_$BattleHistoryEntryImpl _$$BattleHistoryEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$BattleHistoryEntryImpl(
      battleId: json['battleId'] as String,
      opponentId: json['opponentId'] as String,
      opponentName: json['opponentName'] as String,
      opponentPhoto: json['opponentPhoto'] as String?,
      isWinner: json['isWinner'] as bool,
      myScore: (json['myScore'] as num).toInt(),
      opponentScore: (json['opponentScore'] as num).toInt(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      battleType: json['battleType'] as String,
      pointsEarned: (json['pointsEarned'] as num?)?.toInt() ?? 0,
      ratingChange: (json['ratingChange'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BattleHistoryEntryImplToJson(
        _$BattleHistoryEntryImpl instance) =>
    <String, dynamic>{
      'battleId': instance.battleId,
      'opponentId': instance.opponentId,
      'opponentName': instance.opponentName,
      'opponentPhoto': instance.opponentPhoto,
      'isWinner': instance.isWinner,
      'myScore': instance.myScore,
      'opponentScore': instance.opponentScore,
      'completedAt': instance.completedAt.toIso8601String(),
      'battleType': instance.battleType,
      'pointsEarned': instance.pointsEarned,
      'ratingChange': instance.ratingChange,
    };
