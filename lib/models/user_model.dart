import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String preferredLanguage; // 'en' or 'ar'
  final DateTime createdAt;
  final DateTime lastActive;

  // Quiz Statistics
  final int totalPoints;
  final int questionsAnswered;
  final int correctAnswers;
  final int currentStreak;
  final int longestStreak;

  // Battery System
  final int heartsRemaining;
  final DateTime? lastHeartRefill;

  // User Preferences
  final bool isDarkMode;
  final bool notificationsEnabled;
  final String prayerCalculationMethod;

  // Friends & Social
  final List<String> friendIds;
  final int rank;

  // Achievements
  final List<String> unlockedBadges;
  final Map<String, int> categoryMastery; // category_id: level

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.preferredLanguage = 'en',
    required this.createdAt,
    required this.lastActive,
    this.totalPoints = 0,
    this.questionsAnswered = 0,
    this.correctAnswers = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.heartsRemaining = 5,
    this.lastHeartRefill,
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.prayerCalculationMethod = 'MWL',
    this.friendIds = const [],
    this.rank = 0,
    this.unlockedBadges = const [],
    this.categoryMastery = const {},
  });

  // Convert from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      preferredLanguage: data['preferredLanguage'] ?? 'en',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastActive: (data['lastActive'] as Timestamp).toDate(),
      totalPoints: data['totalPoints'] ?? 0,
      questionsAnswered: data['questionsAnswered'] ?? 0,
      correctAnswers: data['correctAnswers'] ?? 0,
      currentStreak: data['currentStreak'] ?? 0,
      longestStreak: data['longestStreak'] ?? 0,
      heartsRemaining: data['heartsRemaining'] ?? 5,
      lastHeartRefill: data['lastHeartRefill'] != null
          ? (data['lastHeartRefill'] as Timestamp).toDate()
          : null,
      isDarkMode: data['isDarkMode'] ?? false,
      notificationsEnabled: data['notificationsEnabled'] ?? true,
      prayerCalculationMethod: data['prayerCalculationMethod'] ?? 'MWL',
      friendIds: List<String>.from(data['friendIds'] ?? []),
      rank: data['rank'] ?? 0,
      unlockedBadges: List<String>.from(data['unlockedBadges'] ?? []),
      categoryMastery: Map<String, int>.from(data['categoryMastery'] ?? {}),
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'preferredLanguage': preferredLanguage,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastActive': Timestamp.fromDate(lastActive),
      'totalPoints': totalPoints,
      'questionsAnswered': questionsAnswered,
      'correctAnswers': correctAnswers,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'heartsRemaining': heartsRemaining,
      'lastHeartRefill': lastHeartRefill != null
          ? Timestamp.fromDate(lastHeartRefill!)
          : null,
      'isDarkMode': isDarkMode,
      'notificationsEnabled': notificationsEnabled,
      'prayerCalculationMethod': prayerCalculationMethod,
      'friendIds': friendIds,
      'rank': rank,
      'unlockedBadges': unlockedBadges,
      'categoryMastery': categoryMastery,
    };
  }

  // Calculate accuracy percentage
  double get accuracy {
    if (questionsAnswered == 0) return 0.0;
    return (correctAnswers / questionsAnswered) * 100;
  }

  // Check if user can play (has hearts remaining)
  bool get canPlay => heartsRemaining > 0;

  // Calculate next heart refill time
  DateTime? get nextHeartRefill {
    if (heartsRemaining >= 5 || lastHeartRefill == null) return null;
    return lastHeartRefill!.add(const Duration(hours: 2));
  }
}
