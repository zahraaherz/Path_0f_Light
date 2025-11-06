import 'package:cloud_firestore/cloud_firestore.dart';

class BatterySystem {
  final int currentHearts;
  final int maxHearts;
  final DateTime? lastHeartLostAt;
  final DateTime? nextHeartRefillAt;

  BatterySystem({
    this.currentHearts = 5,
    this.maxHearts = 5,
    this.lastHeartLostAt,
    this.nextHeartRefillAt,
  });

  factory BatterySystem.fromMap(Map<String, dynamic> data) {
    return BatterySystem(
      currentHearts: data['current_hearts'] ?? 5,
      maxHearts: data['max_hearts'] ?? 5,
      lastHeartLostAt: (data['last_heart_lost_at'] as Timestamp?)?.toDate(),
      nextHeartRefillAt: (data['next_heart_refill_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_hearts': currentHearts,
      'max_hearts': maxHearts,
      'last_heart_lost_at':
          lastHeartLostAt != null ? Timestamp.fromDate(lastHeartLostAt!) : null,
      'next_heart_refill_at': nextHeartRefillAt != null
          ? Timestamp.fromDate(nextHeartRefillAt!)
          : null,
    };
  }

  bool get canPlay => currentHearts > 0;

  int get heartsLost => maxHearts - currentHearts;
}

class CategoryProgress {
  final int questionsAnswered;
  final int correctAnswers;
  final int wrongAnswers;
  final int currentLevel;
  final int totalPoints;

  CategoryProgress({
    this.questionsAnswered = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.currentLevel = 1,
    this.totalPoints = 0,
  });

  factory CategoryProgress.fromMap(Map<String, dynamic> data) {
    return CategoryProgress(
      questionsAnswered: data['questions_answered'] ?? 0,
      correctAnswers: data['correct_answers'] ?? 0,
      wrongAnswers: data['wrong_answers'] ?? 0,
      currentLevel: data['current_level'] ?? 1,
      totalPoints: data['total_points'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questions_answered': questionsAnswered,
      'correct_answers': correctAnswers,
      'wrong_answers': wrongAnswers,
      'current_level': currentLevel,
      'total_points': totalPoints,
    };
  }

  double get accuracy =>
      questionsAnswered > 0 ? (correctAnswers / questionsAnswered) * 100 : 0;
}

class DailyStreak {
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastPlayedDate;

  DailyStreak({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastPlayedDate,
  });

  factory DailyStreak.fromMap(Map<String, dynamic> data) {
    return DailyStreak(
      currentStreak: data['current_streak'] ?? 0,
      longestStreak: data['longest_streak'] ?? 0,
      lastPlayedDate: (data['last_played_date'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'last_played_date':
          lastPlayedDate != null ? Timestamp.fromDate(lastPlayedDate!) : null,
    };
  }
}

class UserProgress {
  final String userId;
  final int totalPoints;
  final int currentLevel;
  final int totalQuestionsAnswered;
  final int totalCorrectAnswers;
  final int totalWrongAnswers;
  final BatterySystem batterySystem;
  final Map<String, CategoryProgress> categoryProgress;
  final DailyStreak dailyStreak;
  final List<String> achievementIds;
  final List<String> completedLevels;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProgress({
    required this.userId,
    this.totalPoints = 0,
    this.currentLevel = 1,
    this.totalQuestionsAnswered = 0,
    this.totalCorrectAnswers = 0,
    this.totalWrongAnswers = 0,
    required this.batterySystem,
    this.categoryProgress = const {},
    required this.dailyStreak,
    this.achievementIds = const [],
    this.completedLevels = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProgress.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Map<String, CategoryProgress> catProgress = {};
    if (data['category_progress'] != null) {
      (data['category_progress'] as Map<String, dynamic>).forEach((key, value) {
        catProgress[key] = CategoryProgress.fromMap(value as Map<String, dynamic>);
      });
    }

    return UserProgress(
      userId: doc.id,
      totalPoints: data['total_points'] ?? 0,
      currentLevel: data['current_level'] ?? 1,
      totalQuestionsAnswered: data['total_questions_answered'] ?? 0,
      totalCorrectAnswers: data['total_correct_answers'] ?? 0,
      totalWrongAnswers: data['total_wrong_answers'] ?? 0,
      batterySystem: BatterySystem.fromMap(data['battery_system'] ?? {}),
      categoryProgress: catProgress,
      dailyStreak: DailyStreak.fromMap(data['daily_streak'] ?? {}),
      achievementIds: List<String>.from(data['achievement_ids'] ?? []),
      completedLevels: List<String>.from(data['completed_levels'] ?? []),
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> catProgressMap = {};
    categoryProgress.forEach((key, value) {
      catProgressMap[key] = value.toMap();
    });

    return {
      'total_points': totalPoints,
      'current_level': currentLevel,
      'total_questions_answered': totalQuestionsAnswered,
      'total_correct_answers': totalCorrectAnswers,
      'total_wrong_answers': totalWrongAnswers,
      'battery_system': batterySystem.toMap(),
      'category_progress': catProgressMap,
      'daily_streak': dailyStreak.toMap(),
      'achievement_ids': achievementIds,
      'completed_levels': completedLevels,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }

  double get overallAccuracy => totalQuestionsAnswered > 0
      ? (totalCorrectAnswers / totalQuestionsAnswered) * 100
      : 0;
}
