// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      enabled: json['enabled'] as bool? ?? true,
      prayerTimes: json['prayerTimes'] as bool? ?? true,
      quizReminders: json['quizReminders'] as bool? ?? true,
      achievementUnlocked: json['achievementUnlocked'] as bool? ?? true,
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'prayerTimes': instance.prayerTimes,
      'quizReminders': instance.quizReminders,
      'achievementUnlocked': instance.achievementUnlocked,
    };

_$PrivacySettingsImpl _$$PrivacySettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$PrivacySettingsImpl(
      profileVisible: json['profileVisible'] as bool? ?? true,
      showInLeaderboard: json['showInLeaderboard'] as bool? ?? true,
      allowFriendRequests: json['allowFriendRequests'] as bool? ?? true,
    );

Map<String, dynamic> _$$PrivacySettingsImplToJson(
        _$PrivacySettingsImpl instance) =>
    <String, dynamic>{
      'profileVisible': instance.profileVisible,
      'showInLeaderboard': instance.showInLeaderboard,
      'allowFriendRequests': instance.allowFriendRequests,
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      theme: json['theme'] as String? ?? 'light',
      fontSize: json['fontSize'] as String? ?? 'medium',
      language: json['language'] as String? ?? 'auto',
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'fontSize': instance.fontSize,
      'language': instance.language,
    };

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      notifications: json['notifications'] == null
          ? const NotificationSettings()
          : NotificationSettings.fromJson(
              json['notifications'] as Map<String, dynamic>),
      privacy: json['privacy'] == null
          ? const PrivacySettings()
          : PrivacySettings.fromJson(json['privacy'] as Map<String, dynamic>),
      preferences: json['preferences'] == null
          ? const UserPreferences()
          : UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'privacy': instance.privacy,
      'preferences': instance.preferences,
    };

_$EnergyDataImpl _$$EnergyDataImplFromJson(Map<String, dynamic> json) =>
    _$EnergyDataImpl(
      currentEnergy: (json['currentEnergy'] as num).toInt(),
      maxEnergy: (json['maxEnergy'] as num).toInt(),
      lastUpdateTime:
          const TimestampConverter().fromJson(json['lastUpdateTime']),
      lastDailyBonusDate: json['lastDailyBonusDate'] as String,
      totalEnergyUsed: (json['totalEnergyUsed'] as num?)?.toInt() ?? 0,
      totalEnergyEarned: (json['totalEnergyEarned'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$EnergyDataImplToJson(_$EnergyDataImpl instance) =>
    <String, dynamic>{
      'currentEnergy': instance.currentEnergy,
      'maxEnergy': instance.maxEnergy,
      'lastUpdateTime':
          const TimestampConverter().toJson(instance.lastUpdateTime),
      'lastDailyBonusDate': instance.lastDailyBonusDate,
      'totalEnergyUsed': instance.totalEnergyUsed,
      'totalEnergyEarned': instance.totalEnergyEarned,
    };

_$SubscriptionDataImpl _$$SubscriptionDataImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionDataImpl(
      plan: json['plan'] as String? ?? 'free',
      active: json['active'] as bool? ?? false,
      startDate: const TimestampConverter().fromJson(json['startDate']),
      expiryDate: const TimestampConverter().fromJson(json['expiryDate']),
      autoRenew: json['autoRenew'] as bool? ?? false,
    );

Map<String, dynamic> _$$SubscriptionDataImplToJson(
        _$SubscriptionDataImpl instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'active': instance.active,
      'startDate': _$JsonConverterToJson<dynamic, DateTime>(
          instance.startDate, const TimestampConverter().toJson),
      'expiryDate': _$JsonConverterToJson<dynamic, DateTime>(
          instance.expiryDate, const TimestampConverter().toJson),
      'autoRenew': instance.autoRenew,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$DailyStatsImpl _$$DailyStatsImplFromJson(Map<String, dynamic> json) =>
    _$DailyStatsImpl(
      lastLoginDate: json['lastLoginDate'] as String,
      loginStreak: (json['loginStreak'] as num?)?.toInt() ?? 0,
      longestLoginStreak: (json['longestLoginStreak'] as num?)?.toInt() ?? 0,
      totalLoginDays: (json['totalLoginDays'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DailyStatsImplToJson(_$DailyStatsImpl instance) =>
    <String, dynamic>{
      'lastLoginDate': instance.lastLoginDate,
      'loginStreak': instance.loginStreak,
      'longestLoginStreak': instance.longestLoginStreak,
      'totalLoginDays': instance.totalLoginDays,
    };

_$AdTrackingImpl _$$AdTrackingImplFromJson(Map<String, dynamic> json) =>
    _$AdTrackingImpl(
      adsWatchedToday: (json['adsWatchedToday'] as num?)?.toInt() ?? 0,
      lastAdWatchedTime:
          const TimestampConverter().fromJson(json['lastAdWatchedTime']),
      lastAdResetDate: json['lastAdResetDate'] as String,
      totalAdsWatched: (json['totalAdsWatched'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdTrackingImplToJson(_$AdTrackingImpl instance) =>
    <String, dynamic>{
      'adsWatchedToday': instance.adsWatchedToday,
      'lastAdWatchedTime': _$JsonConverterToJson<dynamic, DateTime>(
          instance.lastAdWatchedTime, const TimestampConverter().toJson),
      'lastAdResetDate': instance.lastAdResetDate,
      'totalAdsWatched': instance.totalAdsWatched,
    };

_$DifficultyProgressImpl _$$DifficultyProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$DifficultyProgressImpl(
      answered: (json['answered'] as num?)?.toInt() ?? 0,
      correct: (json['correct'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DifficultyProgressImplToJson(
        _$DifficultyProgressImpl instance) =>
    <String, dynamic>{
      'answered': instance.answered,
      'correct': instance.correct,
    };

_$CategoryProgressImpl _$$CategoryProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$CategoryProgressImpl(
      answered: (json['answered'] as num?)?.toInt() ?? 0,
      correct: (json['correct'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CategoryProgressImplToJson(
        _$CategoryProgressImpl instance) =>
    <String, dynamic>{
      'answered': instance.answered,
      'correct': instance.correct,
      'points': instance.points,
    };

_$QuizProgressImpl _$$QuizProgressImplFromJson(Map<String, dynamic> json) =>
    _$QuizProgressImpl(
      totalQuestionsAnswered:
          (json['totalQuestionsAnswered'] as num?)?.toInt() ?? 0,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
      wrongAnswers: (json['wrongAnswers'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
      categoryProgress:
          (json['categoryProgress'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(
                    k, CategoryProgress.fromJson(e as Map<String, dynamic>)),
              ) ??
              const {},
      basic: DifficultyProgress.fromJson(json['basic'] as Map<String, dynamic>),
      intermediate: DifficultyProgress.fromJson(
          json['intermediate'] as Map<String, dynamic>),
      advanced:
          DifficultyProgress.fromJson(json['advanced'] as Map<String, dynamic>),
      expert:
          DifficultyProgress.fromJson(json['expert'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$QuizProgressImplToJson(_$QuizProgressImpl instance) =>
    <String, dynamic>{
      'totalQuestionsAnswered': instance.totalQuestionsAnswered,
      'correctAnswers': instance.correctAnswers,
      'wrongAnswers': instance.wrongAnswers,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'totalPoints': instance.totalPoints,
      'categoryProgress': instance.categoryProgress,
      'basic': instance.basic,
      'intermediate': instance.intermediate,
      'advanced': instance.advanced,
      'expert': instance.expert,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      language: json['language'] as String? ?? 'en',
      emailVerified: json['emailVerified'] as bool? ?? false,
      phoneVerified: json['phoneVerified'] as bool? ?? false,
      provider: json['provider'] as String,
      providers: (json['providers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      role:
          $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.user,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      lastActive: const TimestampConverter().fromJson(json['lastActive']),
      accountStatus:
          $enumDecodeNullable(_$AccountStatusEnumMap, json['accountStatus']) ??
              AccountStatus.active,
      profileComplete: json['profileComplete'] as bool? ?? false,
      energy: EnergyData.fromJson(json['energy'] as Map<String, dynamic>),
      subscription: SubscriptionData.fromJson(
          json['subscription'] as Map<String, dynamic>),
      quizProgress:
          QuizProgress.fromJson(json['quizProgress'] as Map<String, dynamic>),
      dailyStats:
          DailyStats.fromJson(json['dailyStats'] as Map<String, dynamic>),
      adTracking:
          AdTracking.fromJson(json['adTracking'] as Map<String, dynamic>),
      settings: UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'phoneNumber': instance.phoneNumber,
      'language': instance.language,
      'emailVerified': instance.emailVerified,
      'phoneVerified': instance.phoneVerified,
      'provider': instance.provider,
      'providers': instance.providers,
      'role': _$UserRoleEnumMap[instance.role]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'lastActive': const TimestampConverter().toJson(instance.lastActive),
      'accountStatus': _$AccountStatusEnumMap[instance.accountStatus]!,
      'profileComplete': instance.profileComplete,
      'energy': instance.energy,
      'subscription': instance.subscription,
      'quizProgress': instance.quizProgress,
      'dailyStats': instance.dailyStats,
      'adTracking': instance.adTracking,
      'settings': instance.settings,
    };

const _$UserRoleEnumMap = {
  UserRole.user: 'user',
  UserRole.scholar: 'scholar',
  UserRole.admin: 'admin',
  UserRole.moderator: 'moderator',
};

const _$AccountStatusEnumMap = {
  AccountStatus.active: 'active',
  AccountStatus.suspended: 'suspended',
  AccountStatus.deleted: 'deleted',
};
