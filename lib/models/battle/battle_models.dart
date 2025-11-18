import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'battle_models.freezed.dart';
part 'battle_models.g.dart';

/// Battle status enum
enum BattleStatus {
  waiting('waiting', 'Waiting for opponent'),
  ready('ready', 'Ready to start'),
  inProgress('in_progress', 'Battle in progress'),
  completed('completed', 'Battle completed'),
  cancelled('cancelled', 'Battle cancelled'),
  abandoned('abandoned', 'Player abandoned');

  final String value;
  final String displayName;
  const BattleStatus(this.value, this.displayName);

  static BattleStatus fromString(String value) {
    return BattleStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => BattleStatus.waiting,
    );
  }
}

/// Battle type enum
enum BattleType {
  quick('quick', 'Quick Match', 'Random opponent, start immediately'),
  friend('friend', 'Friend Challenge', 'Challenge a specific friend'),
  tournament('tournament', 'Tournament', 'Compete in a tournament');

  final String value;
  final String displayName;
  final String description;
  const BattleType(this.value, this.displayName, this.description);

  static BattleType fromString(String value) {
    return BattleType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => BattleType.quick,
    );
  }
}

/// Battle player data
@freezed
class BattlePlayer with _$BattlePlayer {
  const factory BattlePlayer({
    required String userId,
    required String displayName,
    String? photoURL,
    @Default(0) int score,
    @Default(0) int correctAnswers,
    @Default(0) int wrongAnswers,
    @Default(0) int currentStreak,
    @Default(0) int answeredCount,
    @Default(false) bool isReady,
    @Default(false) bool hasFinished,
    DateTime? finishedAt,
    Map<String, dynamic>? lastAnswer, // {questionId, answer, isCorrect, timestamp}
  }) = _BattlePlayer;

  factory BattlePlayer.fromJson(Map<String, dynamic> json) =>
      _$BattlePlayerFromJson(json);
}

/// Battle configuration
@freezed
class BattleConfig with _$BattleConfig {
  const factory BattleConfig({
    @Default(10) int questionCount,
    String? category,
    String? difficulty,
    @Default('en') String language,
    @Default(30) int timePerQuestion, // seconds
    @Default(5) int energyCost,
  }) = _BattleConfig;

  factory BattleConfig.fromJson(Map<String, dynamic> json) =>
      _$BattleConfigFromJson(json);
}

/// Battle model (main collection)
@freezed
class Battle with _$Battle {
  const factory Battle({
    required String id,
    required BattleType type,
    required BattleStatus status,
    required BattlePlayer player1,
    BattlePlayer? player2,
    required BattleConfig config,
    required List<String> questionIds, // Questions for this battle
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? winnerId, // User ID of winner
    String? tournamentId, // If part of tournament
    @Default(false) bool isRanked, // Affects leaderboard
    Map<String, dynamic>? metadata, // Extra data
  }) = _Battle;

  factory Battle.fromJson(Map<String, dynamic> json) =>
      _$BattleFromJson(json);
}

/// Battle invitation model
@freezed
class BattleInvitation with _$BattleInvitation {
  const factory BattleInvitation({
    required String id,
    required String battleId,
    required String fromUserId,
    required String fromUserName,
    String? fromUserPhoto,
    required String toUserId,
    required BattleConfig config,
    @Default('pending') String status, // pending, accepted, rejected, expired
    required DateTime createdAt,
    DateTime? respondedAt,
    @Default(300) int expirySeconds, // 5 minutes default
  }) = _BattleInvitation;

  factory BattleInvitation.fromJson(Map<String, dynamic> json) =>
      _$BattleInvitationFromJson(json);
}

/// Matchmaking queue entry
@freezed
class MatchmakingEntry with _$MatchmakingEntry {
  const factory MatchmakingEntry({
    required String userId,
    required String displayName,
    String? photoURL,
    required BattleConfig config,
    required int userRating, // ELO or similar
    required DateTime joinedAt,
    @Default(60) int timeoutSeconds,
  }) = _MatchmakingEntry;

  factory MatchmakingEntry.fromJson(Map<String, dynamic> json) =>
      _$MatchmakingEntryFromJson(json);
}

/// Battle statistics
@freezed
class BattleStats with _$BattleStats {
  const factory BattleStats({
    @Default(0) int totalBattles,
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int draws,
    @Default(0) int winStreak,
    @Default(0) int longestWinStreak,
    @Default(1000) int rating, // ELO rating
    @Default(0) int totalPointsEarned,
    DateTime? lastBattleAt,
  }) = _BattleStats;

  factory BattleStats.fromJson(Map<String, dynamic> json) =>
      _$BattleStatsFromJson(json);
}

/// Battle result summary
@freezed
class BattleResult with _$BattleResult {
  const factory BattleResult({
    required String battleId,
    required BattlePlayer player1,
    required BattlePlayer player2,
    required String winnerId,
    required String loserId,
    required int winnerScore,
    required int loserScore,
    required int scoreDifference,
    required DateTime completedAt,
    required int durationSeconds,
    String? battleType,
  }) = _BattleResult;

  factory BattleResult.fromJson(Map<String, dynamic> json) =>
      _$BattleResultFromJson(json);
}

/// Live battle update (for real-time sync)
@freezed
class BattleUpdate with _$BattleUpdate {
  const factory BattleUpdate({
    required String battleId,
    required String userId,
    required String updateType, // answer_submitted, player_joined, battle_started, battle_ended
    required DateTime timestamp,
    Map<String, dynamic>? data,
  }) = _BattleUpdate;

  factory BattleUpdate.fromJson(Map<String, dynamic> json) =>
      _$BattleUpdateFromJson(json);
}

/// Tournament status enum
enum TournamentStatus {
  registration('registration', 'Registration Open'),
  ready('ready', 'Ready to Start'),
  inProgress('in_progress', 'In Progress'),
  completed('completed', 'Completed'),
  cancelled('cancelled', 'Cancelled');

  final String value;
  final String displayName;
  const TournamentStatus(this.value, this.displayName);

  static TournamentStatus fromString(String value) {
    return TournamentStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => TournamentStatus.registration,
    );
  }
}

/// Tournament bracket type
enum BracketType {
  singleElimination('single_elimination', 'Single Elimination'),
  doubleElimination('double_elimination', 'Double Elimination'),
  roundRobin('round_robin', 'Round Robin');

  final String value;
  final String displayName;
  const BracketType(this.value, this.displayName);

  static BracketType fromString(String value) {
    return BracketType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => BracketType.singleElimination,
    );
  }
}

/// Tournament participant
@freezed
class TournamentParticipant with _$TournamentParticipant {
  const factory TournamentParticipant({
    required String userId,
    required String displayName,
    String? photoURL,
    required DateTime joinedAt,
    @Default(0) int seed, // Tournament seeding
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int totalScore,
    @Default(false) bool isEliminated,
    DateTime? eliminatedAt,
  }) = _TournamentParticipant;

  factory TournamentParticipant.fromJson(Map<String, dynamic> json) =>
      _$TournamentParticipantFromJson(json);
}

/// Tournament round
@freezed
class TournamentRound with _$TournamentRound {
  const factory TournamentRound({
    required int roundNumber,
    required String roundName, // Quarterfinals, Semifinals, Finals
    required List<String> battleIds,
    @Default('pending') String status, // pending, in_progress, completed
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _TournamentRound;

  factory TournamentRound.fromJson(Map<String, dynamic> json) =>
      _$TournamentRoundFromJson(json);
}

/// Tournament model
@freezed
class Tournament with _$Tournament {
  const factory Tournament({
    required String id,
    required String title,
    required String titleAr,
    String? description,
    String? descriptionAr,
    required TournamentStatus status,
    required BracketType bracketType,
    required BattleConfig battleConfig,
    required int maxParticipants, // 4, 8, 16, 32, etc.
    required int minParticipants,
    required List<TournamentParticipant> participants,
    required List<TournamentRound> rounds,
    required DateTime createdAt,
    required DateTime registrationDeadline,
    DateTime? startedAt,
    DateTime? completedAt,
    String? winnerId,
    String? createdBy, // Admin/organizer
    @Default(0) int entryEnergyCost,
    @Default(false) bool isPremiumOnly,
    Map<String, dynamic>? prizes, // First, second, third place rewards
  }) = _Tournament;

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);
}

/// Battle history entry (simplified for user's battle list)
@freezed
class BattleHistoryEntry with _$BattleHistoryEntry {
  const factory BattleHistoryEntry({
    required String battleId,
    required String opponentId,
    required String opponentName,
    String? opponentPhoto,
    required bool isWinner,
    required int myScore,
    required int opponentScore,
    required DateTime completedAt,
    required String battleType,
    @Default(0) int pointsEarned,
    @Default(0) int ratingChange,
  }) = _BattleHistoryEntry;

  factory BattleHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$BattleHistoryEntryFromJson(json);
}
