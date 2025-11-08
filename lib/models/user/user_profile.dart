import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_role.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// User account status
enum AccountStatus {
  active,
  suspended,
  deleted;

  static AccountStatus fromString(String value) {
    return AccountStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => AccountStatus.active,
    );
  }
}

/// Notification settings
@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @Default(true) bool enabled,
    @Default(true) bool prayerTimes,
    @Default(true) bool quizReminders,
    @Default(true) bool achievementUnlocked,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
}

/// Privacy settings
@freezed
class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    @Default(true) bool profileVisible,
    @Default(true) bool showInLeaderboard,
    @Default(true) bool allowFriendRequests,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) =>
      _$PrivacySettingsFromJson(json);
}

/// User preferences
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default('light') String theme,
    @Default('medium') String fontSize,
    @Default('auto') String language,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

/// User settings
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(NotificationSettings()) NotificationSettings notifications,
    @Default(PrivacySettings()) PrivacySettings privacy,
    @Default(UserPreferences()) UserPreferences preferences,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}

/// Energy data
@freezed
class EnergyData with _$EnergyData {
  const factory EnergyData({
    required int currentEnergy,
    required int maxEnergy,
    @TimestampConverter() required DateTime lastUpdateTime,
    required String lastDailyBonusDate,
    @Default(0) int totalEnergyUsed,
    @Default(0) int totalEnergyEarned,
  }) = _EnergyData;

  factory EnergyData.fromJson(Map<String, dynamic> json) =>
      _$EnergyDataFromJson(json);
}

/// Subscription data
@freezed
class SubscriptionData with _$SubscriptionData {
  const factory SubscriptionData({
    @Default('free') String plan,
    @Default(false) bool active,
    @TimestampConverter() DateTime? startDate,
    @TimestampConverter() DateTime? expiryDate,
    @Default(false) bool autoRenew,
  }) = _SubscriptionData;

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDataFromJson(json);
}

/// Daily stats
@freezed
class DailyStats with _$DailyStats {
  const factory DailyStats({
    required String lastLoginDate,
    @Default(0) int loginStreak,
    @Default(0) int longestLoginStreak,
    @Default(0) int totalLoginDays,
  }) = _DailyStats;

  factory DailyStats.fromJson(Map<String, dynamic> json) =>
      _$DailyStatsFromJson(json);
}

/// Ad tracking data
@freezed
class AdTracking with _$AdTracking {
  const factory AdTracking({
    @Default(0) int adsWatchedToday,
    @TimestampConverter() DateTime? lastAdWatchedTime,
    required String lastAdResetDate,
    @Default(0) int totalAdsWatched,
  }) = _AdTracking;

  factory AdTracking.fromJson(Map<String, dynamic> json) =>
      _$AdTrackingFromJson(json);
}

/// Difficulty progress
@freezed
class DifficultyProgress with _$DifficultyProgress {
  const factory DifficultyProgress({
    @Default(0) int answered,
    @Default(0) int correct,
  }) = _DifficultyProgress;

  factory DifficultyProgress.fromJson(Map<String, dynamic> json) =>
      _$DifficultyProgressFromJson(json);
}

/// Category progress
@freezed
class CategoryProgress with _$CategoryProgress {
  const factory CategoryProgress({
    @Default(0) int answered,
    @Default(0) int correct,
    @Default(0) int points,
  }) = _CategoryProgress;

  factory CategoryProgress.fromJson(Map<String, dynamic> json) =>
      _$CategoryProgressFromJson(json);
}

/// Quiz progress
@freezed
class QuizProgress with _$QuizProgress {
  const factory QuizProgress({
    @Default(0) int totalQuestionsAnswered,
    @Default(0) int correctAnswers,
    @Default(0) int wrongAnswers,
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    @Default(0) int totalPoints,
    @Default({}) Map<String, CategoryProgress> categoryProgress,
    required DifficultyProgress basic,
    required DifficultyProgress intermediate,
    required DifficultyProgress advanced,
    required DifficultyProgress expert,
  }) = _QuizProgress;

  factory QuizProgress.fromJson(Map<String, dynamic> json) =>
      _$QuizProgressFromJson(json);
}

/// Main user profile model
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    @Default('en') String language,
    @Default(false) bool emailVerified,
    @Default(false) bool phoneVerified,
    required String provider,
    @Default([]) List<String> providers,
    @Default(UserRole.user) UserRole role,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime lastActive,
    @Default(AccountStatus.active) AccountStatus accountStatus,
    @Default(false) bool profileComplete,
    required EnergyData energy,
    required SubscriptionData subscription,
    required QuizProgress quizProgress,
    required DailyStats dailyStats,
    required AdTracking adTracking,
    required UserSettings settings,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// Create from Firestore document
  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile.fromJson(data);
  }

  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Convert DateTime to Timestamp for Firestore
    return json.map((key, value) {
      if (value is DateTime) {
        return MapEntry(key, Timestamp.fromDate(value));
      }
      return MapEntry(key, value);
    });
  }
}

/// Timestamp converter for Freezed
class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    }
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}
