import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/battle_repository.dart';
import '../models/battle/battle_models.dart';
import '../models/quiz/quiz_models.dart';

// ==================== REPOSITORY PROVIDER ====================

final battleRepositoryProvider = Provider<BattleRepository>((ref) {
  return BattleRepository();
});

// ==================== BATTLE STATS PROVIDER ====================

final battleStatsProvider = StreamProvider<BattleStats>((ref) {
  final repository = ref.watch(battleRepositoryProvider);
  return repository.watchBattleStats();
});

// ==================== ACTIVE BATTLES PROVIDER ====================

final activeBattlesProvider = StreamProvider<List<Battle>>((ref) {
  final repository = ref.watch(battleRepositoryProvider);
  return repository.watchActiveBattles();
});

// ==================== PENDING INVITATIONS PROVIDER ====================

final pendingInvitationsProvider = StreamProvider<List<BattleInvitation>>((ref) {
  final repository = ref.watch(battleRepositoryProvider);
  return repository.watchPendingInvitations();
});

// ==================== SINGLE BATTLE PROVIDER ====================

final battleProvider = StreamProvider.family<Battle, String>((ref, battleId) {
  final repository = ref.watch(battleRepositoryProvider);
  return repository.watchBattle(battleId);
});

// ==================== BATTLE QUESTIONS PROVIDER ====================

/// Fetches questions for a specific battle
/// Uses the battle's questionIds to fetch the actual question data
final battleQuestionsProvider = FutureProvider.family<List<QuizQuestion>, String>((ref, battleId) async {
  final repository = ref.watch(battleRepositoryProvider);
  final battleAsync = await ref.watch(battleProvider(battleId).future);

  return repository.getBattleQuestions(battleAsync.questionIds);
});

// ==================== BATTLE HISTORY PROVIDER ====================

final battleHistoryProvider = FutureProvider<List<BattleHistoryEntry>>((ref) {
  final repository = ref.watch(battleRepositoryProvider);
  return repository.getBattleHistory(limit: 50);
});

// ==================== TOURNAMENTS PROVIDER ====================

final availableTournamentsProvider = StreamProvider<List<Tournament>>((ref) {
  final repository = ref.watch(battleRepositoryProvider);
  return repository.watchAvailableTournaments();
});

// ==================== SINGLE TOURNAMENT PROVIDER ====================

final tournamentProvider = StreamProvider.family<Tournament, String>((ref, tournamentId) {
  final repository = ref.watch(battleRepositoryProvider);
  return repository.watchTournament(tournamentId);
});

// ==================== MATCHMAKING STATE PROVIDER ====================

class MatchmakingState {
  final bool isSearching;
  final String? queueId;
  final BattleConfig? config;
  final DateTime? startedAt;

  const MatchmakingState({
    this.isSearching = false,
    this.queueId,
    this.config,
    this.startedAt,
  });

  MatchmakingState copyWith({
    bool? isSearching,
    String? queueId,
    BattleConfig? config,
    DateTime? startedAt,
  }) {
    return MatchmakingState(
      isSearching: isSearching ?? this.isSearching,
      queueId: queueId ?? this.queueId,
      config: config ?? this.config,
      startedAt: startedAt ?? this.startedAt,
    );
  }
}

class MatchmakingNotifier extends StateNotifier<MatchmakingState> {
  final BattleRepository repository;

  MatchmakingNotifier(this.repository) : super(const MatchmakingState());

  Future<void> startMatchmaking(BattleConfig config) async {
    state = MatchmakingState(
      isSearching: true,
      config: config,
      startedAt: DateTime.now(),
    );

    try {
      final id = await repository.joinMatchmaking(config: config);
      state = state.copyWith(queueId: id);
    } catch (e) {
      state = const MatchmakingState();
      rethrow;
    }
  }

  Future<void> cancelMatchmaking() async {
    if (state.queueId != null) {
      try {
        await repository.leaveMatchmaking();
      } catch (e) {
        // Ignore errors when leaving
      }
    }
    state = const MatchmakingState();
  }

  void matchFound(String battleId) {
    state = const MatchmakingState();
  }
}

final matchmakingProvider =
    StateNotifierProvider<MatchmakingNotifier, MatchmakingState>((ref) {
  final repository = ref.watch(battleRepositoryProvider);
  return MatchmakingNotifier(repository);
});

// ==================== BATTLE CONFIG PROVIDER ====================

class BattleConfigNotifier extends StateNotifier<BattleConfig> {
  BattleConfigNotifier()
      : super(const BattleConfig(
          questionCount: 10,
          timePerQuestion: 30,
          energyCost: 5,
          language: 'en',
        ));

  void updateCategory(String? category) {
    state = state.copyWith(category: category);
  }

  void updateDifficulty(String? difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void updateLanguage(String language) {
    state = state.copyWith(language: language);
  }

  void updateQuestionCount(int count) {
    state = state.copyWith(questionCount: count);
  }

  void updateTimePerQuestion(int seconds) {
    state = state.copyWith(timePerQuestion: seconds);
  }

  void reset() {
    state = const BattleConfig(
      questionCount: 10,
      timePerQuestion: 30,
      energyCost: 5,
      language: 'en',
    );
  }
}

final battleConfigProvider =
    StateNotifierProvider<BattleConfigNotifier, BattleConfig>((ref) {
  return BattleConfigNotifier();
});
