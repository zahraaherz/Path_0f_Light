import 'package:cloud_firestore/cloud_firestore.dart';

enum AchievementType {
  questionsAnswered,
  categoryMastery,
  streakMilestone,
  levelCompleted,
  pointsMilestone,
  perfectScore,
  speedChallenge
}

class Achievement {
  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final AchievementType type;
  final String iconUrl;
  final int pointsReward;
  final int targetValue;
  final String? category;
  final DateTime createdAt;

  Achievement({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.type,
    required this.iconUrl,
    required this.pointsReward,
    required this.targetValue,
    this.category,
    required this.createdAt,
  });

  factory Achievement.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Achievement(
      id: doc.id,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      descriptionAr: data['description_ar'] ?? '',
      descriptionEn: data['description_en'] ?? '',
      type: _typeFromString(data['type'] ?? ''),
      iconUrl: data['icon_url'] ?? '',
      pointsReward: data['points_reward'] ?? 0,
      targetValue: data['target_value'] ?? 0,
      category: data['category'],
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title_ar': titleAr,
      'title_en': titleEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'type': _typeToString(type),
      'icon_url': iconUrl,
      'points_reward': pointsReward,
      'target_value': targetValue,
      'category': category,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }

  static AchievementType _typeFromString(String value) {
    switch (value) {
      case 'questions_answered':
        return AchievementType.questionsAnswered;
      case 'category_mastery':
        return AchievementType.categoryMastery;
      case 'streak_milestone':
        return AchievementType.streakMilestone;
      case 'level_completed':
        return AchievementType.levelCompleted;
      case 'points_milestone':
        return AchievementType.pointsMilestone;
      case 'perfect_score':
        return AchievementType.perfectScore;
      case 'speed_challenge':
        return AchievementType.speedChallenge;
      default:
        return AchievementType.questionsAnswered;
    }
  }

  static String _typeToString(AchievementType type) {
    switch (type) {
      case AchievementType.questionsAnswered:
        return 'questions_answered';
      case AchievementType.categoryMastery:
        return 'category_mastery';
      case AchievementType.streakMilestone:
        return 'streak_milestone';
      case AchievementType.levelCompleted:
        return 'level_completed';
      case AchievementType.pointsMilestone:
        return 'points_milestone';
      case AchievementType.perfectScore:
        return 'perfect_score';
      case AchievementType.speedChallenge:
        return 'speed_challenge';
    }
  }
}

class UserAchievement {
  final String achievementId;
  final DateTime unlockedAt;
  final int currentProgress;
  final bool isUnlocked;

  UserAchievement({
    required this.achievementId,
    required this.unlockedAt,
    this.currentProgress = 0,
    this.isUnlocked = false,
  });

  factory UserAchievement.fromMap(Map<String, dynamic> data) {
    return UserAchievement(
      achievementId: data['achievement_id'] ?? '',
      unlockedAt: (data['unlocked_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      currentProgress: data['current_progress'] ?? 0,
      isUnlocked: data['is_unlocked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'achievement_id': achievementId,
      'unlocked_at': Timestamp.fromDate(unlockedAt),
      'current_progress': currentProgress,
      'is_unlocked': isUnlocked,
    };
  }
}
