// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnergyStatusImpl _$$EnergyStatusImplFromJson(Map<String, dynamic> json) =>
    _$EnergyStatusImpl(
      currentEnergy: (json['currentEnergy'] as num).toInt(),
      maxEnergy: (json['maxEnergy'] as num).toInt(),
      canPlayQuiz: json['canPlayQuiz'] as bool,
      isPremium: json['isPremium'] as bool,
      dailyBonusAvailable: json['dailyBonusAvailable'] as bool,
      energyPerQuestion: (json['energyPerQuestion'] as num).toInt(),
      adRewardEnergy: (json['adRewardEnergy'] as num).toInt(),
    );

Map<String, dynamic> _$$EnergyStatusImplToJson(_$EnergyStatusImpl instance) =>
    <String, dynamic>{
      'currentEnergy': instance.currentEnergy,
      'maxEnergy': instance.maxEnergy,
      'canPlayQuiz': instance.canPlayQuiz,
      'isPremium': instance.isPremium,
      'dailyBonusAvailable': instance.dailyBonusAvailable,
      'energyPerQuestion': instance.energyPerQuestion,
      'adRewardEnergy': instance.adRewardEnergy,
    };

_$EnergyConsumeResultImpl _$$EnergyConsumeResultImplFromJson(
        Map<String, dynamic> json) =>
    _$EnergyConsumeResultImpl(
      success: json['success'] as bool,
      currentEnergy: (json['currentEnergy'] as num).toInt(),
      energyConsumed: (json['energyConsumed'] as num?)?.toInt(),
      energyNeeded: (json['energyNeeded'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$EnergyConsumeResultImplToJson(
        _$EnergyConsumeResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'currentEnergy': instance.currentEnergy,
      'energyConsumed': instance.energyConsumed,
      'energyNeeded': instance.energyNeeded,
      'message': instance.message,
    };

_$QuizRewardResultImpl _$$QuizRewardResultImplFromJson(
        Map<String, dynamic> json) =>
    _$QuizRewardResultImpl(
      success: json['success'] as bool,
      currentEnergy: (json['currentEnergy'] as num).toInt(),
      energyRewarded: (json['energyRewarded'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$QuizRewardResultImplToJson(
        _$QuizRewardResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'currentEnergy': instance.currentEnergy,
      'energyRewarded': instance.energyRewarded,
      'message': instance.message,
    };

_$AdRewardResultImpl _$$AdRewardResultImplFromJson(Map<String, dynamic> json) =>
    _$AdRewardResultImpl(
      success: json['success'] as bool,
      currentEnergy: (json['currentEnergy'] as num?)?.toInt(),
      energyRewarded: (json['energyRewarded'] as num?)?.toInt(),
      adsRemaining: (json['adsRemaining'] as num?)?.toInt(),
      cooldownRemainingSeconds:
          (json['cooldownRemainingSeconds'] as num?)?.toInt(),
      message: json['message'] as String?,
      isPremium: json['isPremium'] as bool? ?? false,
    );

Map<String, dynamic> _$$AdRewardResultImplToJson(
        _$AdRewardResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'currentEnergy': instance.currentEnergy,
      'energyRewarded': instance.energyRewarded,
      'adsRemaining': instance.adsRemaining,
      'cooldownRemainingSeconds': instance.cooldownRemainingSeconds,
      'message': instance.message,
      'isPremium': instance.isPremium,
    };
