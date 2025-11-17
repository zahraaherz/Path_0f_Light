// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardEntryImpl _$$LeaderboardEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderboardEntryImpl(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String,
      photoURL: json['photoURL'] as String?,
      rank: (json['rank'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      totalQuestionsAnswered: (json['totalQuestionsAnswered'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      loginStreak: (json['loginStreak'] as num).toInt(),
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$LeaderboardEntryImplToJson(
        _$LeaderboardEntryImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'rank': instance.rank,
      'points': instance.points,
      'totalQuestionsAnswered': instance.totalQuestionsAnswered,
      'correctAnswers': instance.correctAnswers,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'loginStreak': instance.loginStreak,
      'accuracy': instance.accuracy,
    };

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconName: json['iconName'] as String,
      requiredValue: (json['requiredValue'] as num).toInt(),
      category: json['category'] as String,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: (json['unlockedAt'] as num?)?.toInt(),
      currentProgress: (json['currentProgress'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'iconName': instance.iconName,
      'requiredValue': instance.requiredValue,
      'category': instance.category,
      'isUnlocked': instance.isUnlocked,
      'unlockedAt': instance.unlockedAt,
      'currentProgress': instance.currentProgress,
    };
