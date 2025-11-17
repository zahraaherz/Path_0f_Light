import 'package:freezed_annotation/freezed_annotation.dart';

part 'energy_status.freezed.dart';
part 'energy_status.g.dart';

/// Energy status response from backend
@freezed
class EnergyStatus with _$EnergyStatus {
  const factory EnergyStatus({
    required int currentEnergy,
    required int maxEnergy,
    required bool canPlayQuiz,
    required bool isPremium,
    required bool dailyBonusAvailable,
    required int energyPerQuestion,
    required int adRewardEnergy,
  }) = _EnergyStatus;

  factory EnergyStatus.fromJson(Map<String, dynamic> json) =>
      _$EnergyStatusFromJson(json);
}

/// Energy consume response
@freezed
class EnergyConsumeResult with _$EnergyConsumeResult {
  const factory EnergyConsumeResult({
    required bool success,
    required int currentEnergy,
    int? energyConsumed,
    int? energyNeeded,
    String? message,
  }) = _EnergyConsumeResult;

  factory EnergyConsumeResult.fromJson(Map<String, dynamic> json) =>
      _$EnergyConsumeResultFromJson(json);
}

/// Quiz completion reward response
@freezed
class QuizRewardResult with _$QuizRewardResult {
  const factory QuizRewardResult({
    required bool success,
    required int currentEnergy,
    required int energyRewarded,
    required String message,
  }) = _QuizRewardResult;

  factory QuizRewardResult.fromJson(Map<String, dynamic> json) =>
      _$QuizRewardResultFromJson(json);
}

/// Ad watch reward response
@freezed
class AdRewardResult with _$AdRewardResult {
  const factory AdRewardResult({
    required bool success,
    int? currentEnergy,
    int? energyRewarded,
    int? adsRemaining,
    int? cooldownRemainingSeconds,
    String? message,
    @Default(false) bool isPremium,
  }) = _AdRewardResult;

  factory AdRewardResult.fromJson(Map<String, dynamic> json) =>
      _$AdRewardResultFromJson(json);
}
