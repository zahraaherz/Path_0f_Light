import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_of_light/models/user_progress.dart';
import 'package:path_of_light/models/question.dart';

class UserProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user progress
  Future<UserProgress?> getUserProgress(String userId) async {
    try {
      final doc = await _firestore.collection('user_progress').doc(userId).get();
      if (doc.exists) {
        return UserProgress.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting user progress: $e');
      return null;
    }
  }

  // Stream user progress
  Stream<UserProgress?> streamUserProgress(String userId) {
    return _firestore
        .collection('user_progress')
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return UserProgress.fromFirestore(doc);
      }
      return null;
    });
  }

  // Update answer result
  Future<void> recordAnswer({
    required String userId,
    required QuestionCategory category,
    required bool isCorrect,
    required int pointsEarned,
  }) async {
    try {
      final docRef = _firestore.collection('user_progress').doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) return;

      final progress = UserProgress.fromFirestore(doc);
      final categoryKey = _categoryToString(category);

      // Get existing category progress or create new one
      CategoryProgress catProgress = progress.categoryProgress[categoryKey] ??
          CategoryProgress(
            questionsAnswered: 0,
            correctAnswers: 0,
            wrongAnswers: 0,
            currentLevel: 1,
            totalPoints: 0,
          );

      // Update category progress
      Map<String, CategoryProgress> updatedCategoryProgress =
          Map.from(progress.categoryProgress);
      updatedCategoryProgress[categoryKey] = CategoryProgress(
        questionsAnswered: catProgress.questionsAnswered + 1,
        correctAnswers: catProgress.correctAnswers + (isCorrect ? 1 : 0),
        wrongAnswers: catProgress.wrongAnswers + (isCorrect ? 0 : 1),
        currentLevel: catProgress.currentLevel,
        totalPoints: catProgress.totalPoints + pointsEarned,
      );

      // Update battery system if answer is wrong
      BatterySystem updatedBattery = progress.batterySystem;
      if (!isCorrect && progress.batterySystem.currentHearts > 0) {
        updatedBattery = BatterySystem(
          currentHearts: progress.batterySystem.currentHearts - 1,
          maxHearts: progress.batterySystem.maxHearts,
          lastHeartLostAt: DateTime.now(),
          nextHeartRefillAt: DateTime.now().add(const Duration(hours: 2)),
        );
      }

      // Update daily streak
      DailyStreak updatedStreak = _updateStreak(progress.dailyStreak);

      // Prepare update
      Map<String, dynamic> updates = {
        'total_points': progress.totalPoints + pointsEarned,
        'total_questions_answered': progress.totalQuestionsAnswered + 1,
        'total_correct_answers':
            progress.totalCorrectAnswers + (isCorrect ? 1 : 0),
        'total_wrong_answers': progress.totalWrongAnswers + (isCorrect ? 0 : 1),
        'battery_system': updatedBattery.toMap(),
        'daily_streak': updatedStreak.toMap(),
        'category_progress': updatedCategoryProgress.map(
          (key, value) => MapEntry(key, value.toMap()),
        ),
        'updated_at': FieldValue.serverTimestamp(),
      };

      await docRef.update(updates);
    } catch (e) {
      print('Error recording answer: $e');
    }
  }

  // Refill one heart
  Future<void> refillHeart(String userId) async {
    try {
      final docRef = _firestore.collection('user_progress').doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) return;

      final progress = UserProgress.fromFirestore(doc);

      if (progress.batterySystem.currentHearts >= progress.batterySystem.maxHearts) {
        return; // Already at max
      }

      BatterySystem updatedBattery = BatterySystem(
        currentHearts: progress.batterySystem.currentHearts + 1,
        maxHearts: progress.batterySystem.maxHearts,
        lastHeartLostAt: progress.batterySystem.lastHeartLostAt,
        nextHeartRefillAt: progress.batterySystem.currentHearts + 1 < progress.batterySystem.maxHearts
            ? DateTime.now().add(const Duration(hours: 2))
            : null,
      );

      await docRef.update({
        'battery_system': updatedBattery.toMap(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error refilling heart: $e');
    }
  }

  // Refill all hearts (for premium users or ads)
  Future<void> refillAllHearts(String userId) async {
    try {
      final docRef = _firestore.collection('user_progress').doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) return;

      final progress = UserProgress.fromFirestore(doc);

      BatterySystem updatedBattery = BatterySystem(
        currentHearts: progress.batterySystem.maxHearts,
        maxHearts: progress.batterySystem.maxHearts,
        lastHeartLostAt: null,
        nextHeartRefillAt: null,
      );

      await docRef.update({
        'battery_system': updatedBattery.toMap(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error refilling all hearts: $e');
    }
  }

  // Complete a level
  Future<void> completeLevel({
    required String userId,
    required String levelId,
    required int pointsEarned,
  }) async {
    try {
      final docRef = _firestore.collection('user_progress').doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) return;

      final progress = UserProgress.fromFirestore(doc);

      if (progress.completedLevels.contains(levelId)) {
        return; // Already completed
      }

      List<String> updatedCompletedLevels = List.from(progress.completedLevels)
        ..add(levelId);

      await docRef.update({
        'completed_levels': updatedCompletedLevels,
        'total_points': progress.totalPoints + pointsEarned,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error completing level: $e');
    }
  }

  // Add achievement
  Future<void> addAchievement({
    required String userId,
    required String achievementId,
  }) async {
    try {
      final docRef = _firestore.collection('user_progress').doc(userId);
      final doc = await docRef.get();

      if (!doc.exists) return;

      final progress = UserProgress.fromFirestore(doc);

      if (progress.achievementIds.contains(achievementId)) {
        return; // Already has achievement
      }

      List<String> updatedAchievements = List.from(progress.achievementIds)
        ..add(achievementId);

      await docRef.update({
        'achievement_ids': updatedAchievements,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding achievement: $e');
    }
  }

  // Update streak
  DailyStreak _updateStreak(DailyStreak currentStreak) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (currentStreak.lastPlayedDate == null) {
      return DailyStreak(
        currentStreak: 1,
        longestStreak: 1,
        lastPlayedDate: today,
      );
    }

    final lastPlayed = DateTime(
      currentStreak.lastPlayedDate!.year,
      currentStreak.lastPlayedDate!.month,
      currentStreak.lastPlayedDate!.day,
    );

    final daysDifference = today.difference(lastPlayed).inDays;

    if (daysDifference == 0) {
      // Same day, no change
      return currentStreak;
    } else if (daysDifference == 1) {
      // Next day, increment streak
      int newStreak = currentStreak.currentStreak + 1;
      return DailyStreak(
        currentStreak: newStreak,
        longestStreak: newStreak > currentStreak.longestStreak
            ? newStreak
            : currentStreak.longestStreak,
        lastPlayedDate: today,
      );
    } else {
      // Streak broken
      return DailyStreak(
        currentStreak: 1,
        longestStreak: currentStreak.longestStreak,
        lastPlayedDate: today,
      );
    }
  }

  // Helper method to convert category to string
  String _categoryToString(QuestionCategory category) {
    switch (category) {
      case QuestionCategory.prophetMuhammad:
        return 'prophet_muhammad';
      case QuestionCategory.imam1Ali:
        return 'imam_1_ali';
      case QuestionCategory.imam2Hassan:
        return 'imam_2_hassan';
      case QuestionCategory.imam3Hussain:
        return 'imam_3_hussain';
      case QuestionCategory.imam4Sajjad:
        return 'imam_4_sajjad';
      case QuestionCategory.imam5Baqir:
        return 'imam_5_baqir';
      case QuestionCategory.imam6Sadiq:
        return 'imam_6_sadiq';
      case QuestionCategory.imam7Kadhim:
        return 'imam_7_kadhim';
      case QuestionCategory.imam8Ridha:
        return 'imam_8_ridha';
      case QuestionCategory.imam9Jawad:
        return 'imam_9_jawad';
      case QuestionCategory.imam10Hadi:
        return 'imam_10_hadi';
      case QuestionCategory.imam11Askari:
        return 'imam_11_askari';
      case QuestionCategory.imam12Mahdi:
        return 'imam_12_mahdi';
      case QuestionCategory.ladyFatimah:
        return 'lady_fatimah';
      case QuestionCategory.companions:
        return 'companions';
      case QuestionCategory.islamicPractices:
        return 'islamic_practices';
      case QuestionCategory.quranHistory:
        return 'quran_history';
      case QuestionCategory.ethics:
        return 'ethics';
    }
  }
}
