import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/energy/energy_status.dart';
import '../repositories/energy_repository.dart';

/// Provider for EnergyRepository
final energyRepositoryProvider = Provider<EnergyRepository>((ref) {
  return EnergyRepository();
});

/// Provider for current energy status
/// This auto-refreshes and includes natural refill calculation
final energyStatusProvider = FutureProvider<EnergyStatus>((ref) async {
  final repository = ref.watch(energyRepositoryProvider);
  return await repository.getEnergyStatus();
});

/// Provider for energy status that auto-refreshes every minute
/// This ensures the UI stays updated with natural energy refill
final autoRefreshEnergyProvider = StreamProvider<EnergyStatus>((ref) async* {
  final repository = ref.watch(energyRepositoryProvider);

  // Initial fetch
  yield await repository.getEnergyStatus();

  // Auto-refresh every minute
  while (true) {
    await Future.delayed(const Duration(minutes: 1));
    try {
      yield await repository.getEnergyStatus();
    } catch (e) {
      // Continue with previous value on error
    }
  }
});

/// Provider for checking if user can play quiz
final canPlayQuizProvider = Provider<bool>((ref) {
  final energyStatus = ref.watch(energyStatusProvider);

  return energyStatus.when(
    data: (status) => status.canPlayQuiz,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for current energy value
final currentEnergyProvider = Provider<int>((ref) {
  final energyStatus = ref.watch(energyStatusProvider);

  return energyStatus.when(
    data: (status) => status.currentEnergy,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// Provider for max energy value
final maxEnergyProvider = Provider<int>((ref) {
  final energyStatus = ref.watch(energyStatusProvider);

  return energyStatus.when(
    data: (status) => status.maxEnergy,
    loading: () => 100,
    error: (_, __) => 100,
  );
});

/// Provider for premium status
final isPremiumProvider = Provider<bool>((ref) {
  final energyStatus = ref.watch(energyStatusProvider);

  return energyStatus.when(
    data: (status) => status.isPremium,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for daily bonus availability
final dailyBonusAvailableProvider = Provider<bool>((ref) {
  final energyStatus = ref.watch(energyStatusProvider);

  return energyStatus.when(
    data: (status) => status.dailyBonusAvailable,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for energy percentage (0.0 to 1.0)
final energyPercentageProvider = Provider<double>((ref) {
  final current = ref.watch(currentEnergyProvider);
  final max = ref.watch(maxEnergyProvider);

  if (max == 0) return 0.0;
  return (current / max).clamp(0.0, 1.0);
});

/// State notifier for energy operations
class EnergyController extends StateNotifier<AsyncValue<String>> {
  final EnergyRepository _repository;
  final Ref _ref;

  EnergyController(this._repository, this._ref)
      : super(const AsyncValue.data(''));

  /// Consume energy for a question
  Future<bool> consumeEnergy(String sessionId) async {
    state = const AsyncValue.loading();

    try {
      final result = await _repository.consumeEnergy(sessionId);

      if (result.success) {
        // Refresh energy status
        _ref.invalidate(energyStatusProvider);
        state = AsyncValue.data(result.message ?? 'Energy consumed');
        return true;
      } else {
        state = AsyncValue.error(
          result.message ?? 'Insufficient energy',
          StackTrace.current,
        );
        return false;
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  /// Reward quiz completion
  Future<bool> rewardQuizCompletion({
    required String sessionId,
    required int questionsCompleted,
  }) async {
    state = const AsyncValue.loading();

    try {
      final result = await _repository.rewardQuizCompletion(
        sessionId: sessionId,
        questionsCompleted: questionsCompleted,
      );

      if (result.success) {
        // Refresh energy status
        _ref.invalidate(energyStatusProvider);
        state = AsyncValue.data(result.message);
        return true;
      } else {
        state = AsyncValue.error(
          'Failed to reward completion',
          StackTrace.current,
        );
        return false;
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  /// Reward ad watch
  Future<AdRewardResult> rewardAdWatch({
    required String adId,
    required String adProvider,
  }) async {
    state = const AsyncValue.loading();

    try {
      final result = await _repository.rewardAdWatch(
        adId: adId,
        adProvider: adProvider,
      );

      if (result.success) {
        // Refresh energy status
        _ref.invalidate(energyStatusProvider);
        state = AsyncValue.data(result.message ?? 'Ad reward received');
      } else {
        state = AsyncValue.error(
          result.message ?? 'Failed to reward ad',
          StackTrace.current,
        );
      }

      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  /// Refresh energy status
  void refreshEnergy() {
    _ref.invalidate(energyStatusProvider);
    state = const AsyncValue.data('Refreshed');
  }

  /// Clear messages
  void clearMessages() {
    state = const AsyncValue.data('');
  }
}

/// Provider for EnergyController
final energyControllerProvider =
    StateNotifierProvider<EnergyController, AsyncValue<String>>((ref) {
  final repository = ref.watch(energyRepositoryProvider);
  return EnergyController(repository, ref);
});
