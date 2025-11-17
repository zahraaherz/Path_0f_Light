import 'package:cloud_functions/cloud_functions.dart';
import '../models/energy/energy_status.dart';

/// Exception class for energy repository errors
class EnergyRepositoryException implements Exception {
  final String message;
  final String code;

  EnergyRepositoryException(this.message, this.code);

  @override
  String toString() => message;
}

/// Repository for managing energy system operations
class EnergyRepository {
  final FirebaseFunctions _functions;

  EnergyRepository({
    FirebaseFunctions? functions,
  }) : _functions = functions ?? FirebaseFunctions.instance;

  /// Get current energy status with natural refill and daily bonus
  Future<EnergyStatus> getEnergyStatus() async {
    try {
      final callable = _functions.httpsCallable('getEnergyStatus');
      final result = await callable.call();

      return EnergyStatus.fromJson(Map<String, dynamic>.from(result.data));
    } catch (e) {
      throw EnergyRepositoryException(
        'Failed to get energy status: ${e.toString()}',
        'get-energy-failed',
      );
    }
  }

  /// Consume energy for answering a question
  Future<EnergyConsumeResult> consumeEnergy(String sessionId) async {
    try {
      final callable = _functions.httpsCallable('consumeEnergy');
      final result = await callable.call({'sessionId': sessionId});

      return EnergyConsumeResult.fromJson(
        Map<String, dynamic>.from(result.data),
      );
    } catch (e) {
      throw EnergyRepositoryException(
        'Failed to consume energy: ${e.toString()}',
        'consume-energy-failed',
      );
    }
  }

  /// Reward energy for completing a quiz
  Future<QuizRewardResult> rewardQuizCompletion({
    required String sessionId,
    required int questionsCompleted,
  }) async {
    try {
      final callable = _functions.httpsCallable('rewardQuizCompletion');
      final result = await callable.call({
        'sessionId': sessionId,
        'questionsCompleted': questionsCompleted,
      });

      return QuizRewardResult.fromJson(
        Map<String, dynamic>.from(result.data),
      );
    } catch (e) {
      throw EnergyRepositoryException(
        'Failed to reward quiz completion: ${e.toString()}',
        'reward-quiz-failed',
      );
    }
  }

  /// Reward energy for watching an ad
  Future<AdRewardResult> rewardAdWatch({
    required String adId,
    required String adProvider,
  }) async {
    try {
      final callable = _functions.httpsCallable('rewardAdWatch');
      final result = await callable.call({
        'adId': adId,
        'adProvider': adProvider,
      });

      return AdRewardResult.fromJson(
        Map<String, dynamic>.from(result.data),
      );
    } catch (e) {
      throw EnergyRepositoryException(
        'Failed to reward ad watch: ${e.toString()}',
        'reward-ad-failed',
      );
    }
  }

  /// Update subscription plan
  Future<Map<String, dynamic>> updateSubscription({
    required String plan,
    required String purchaseToken,
  }) async {
    try {
      final callable = _functions.httpsCallable('updateSubscription');
      final result = await callable.call({
        'plan': plan,
        'purchaseToken': purchaseToken,
      });

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw EnergyRepositoryException(
        'Failed to update subscription: ${e.toString()}',
        'update-subscription-failed',
      );
    }
  }

  /// Check subscription status
  Future<Map<String, dynamic>> checkSubscriptionStatus() async {
    try {
      final callable = _functions.httpsCallable('checkSubscriptionStatus');
      final result = await callable.call();

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw EnergyRepositoryException(
        'Failed to check subscription status: ${e.toString()}',
        'check-subscription-failed',
      );
    }
  }

  /// Calculate time until next energy point
  Duration calculateTimeUntilNextEnergy(bool isPremium) {
    final minutesPerPoint = isPremium ? 6 : 12; // 10/hour vs 5/hour
    return Duration(minutes: minutesPerPoint);
  }

  /// Calculate time until full energy
  Duration calculateTimeUntilFull({
    required int currentEnergy,
    required int maxEnergy,
    required bool isPremium,
  }) {
    if (currentEnergy >= maxEnergy) {
      return Duration.zero;
    }

    final energyNeeded = maxEnergy - currentEnergy;
    final minutesPerPoint = isPremium ? 6 : 12;
    final totalMinutes = energyNeeded * minutesPerPoint;

    return Duration(minutes: totalMinutes);
  }

  /// Dispose resources
  void dispose() {
    // Nothing to dispose for now
  }
}
