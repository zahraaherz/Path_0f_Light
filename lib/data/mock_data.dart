import '../models/leaderboard/leaderboard_entry.dart';
import '../models/user/user_profile.dart';
import '../models/user/user_role.dart';

/// Mock data for development and design purposes
class MockData {
  // Mock Leaderboard Entries
  static final List<LeaderboardEntry> leaderboardEntries = [
    const LeaderboardEntry(
      uid: 'user1',
      displayName: 'Fatima Al-Zahra',
      photoURL: null,
      rank: 1,
      points: 5280,
      totalQuestionsAnswered: 356,
      correctAnswers: 328,
      currentStreak: 28,
      longestStreak: 35,
      loginStreak: 45,
      accuracy: 92.1,
    ),
    const LeaderboardEntry(
      uid: 'user2',
      displayName: 'Muhammad Ali',
      photoURL: null,
      rank: 2,
      points: 4850,
      totalQuestionsAnswered: 312,
      correctAnswers: 289,
      currentStreak: 22,
      longestStreak: 28,
      loginStreak: 38,
      accuracy: 92.6,
    ),
    const LeaderboardEntry(
      uid: 'user3',
      displayName: 'Zaynab Hassan',
      photoURL: null,
      rank: 3,
      points: 4620,
      totalQuestionsAnswered: 298,
      correctAnswers: 268,
      currentStreak: 18,
      longestStreak: 25,
      loginStreak: 32,
      accuracy: 89.9,
    ),
    const LeaderboardEntry(
      uid: 'user4',
      displayName: 'Ahmad Hussein',
      photoURL: null,
      rank: 4,
      points: 4350,
      totalQuestionsAnswered: 285,
      correctAnswers: 254,
      currentStreak: 15,
      longestStreak: 22,
      loginStreak: 28,
      accuracy: 89.1,
    ),
    const LeaderboardEntry(
      uid: 'user5',
      displayName: 'Khadija Mahmoud',
      photoURL: null,
      rank: 5,
      points: 4120,
      totalQuestionsAnswered: 268,
      correctAnswers: 242,
      currentStreak: 14,
      longestStreak: 20,
      loginStreak: 25,
      accuracy: 90.3,
    ),
    const LeaderboardEntry(
      uid: 'user6',
      displayName: 'Ibrahim Kareem',
      photoURL: null,
      rank: 6,
      points: 3890,
      totalQuestionsAnswered: 252,
      correctAnswers: 225,
      currentStreak: 12,
      longestStreak: 18,
      loginStreak: 22,
      accuracy: 89.3,
    ),
    const LeaderboardEntry(
      uid: 'user7',
      displayName: 'Maryam Abbas',
      photoURL: null,
      rank: 7,
      points: 3650,
      totalQuestionsAnswered: 238,
      correctAnswers: 208,
      currentStreak: 10,
      longestStreak: 16,
      loginStreak: 20,
      accuracy: 87.4,
    ),
    const LeaderboardEntry(
      uid: 'user8',
      displayName: 'Hassan Jafar',
      photoURL: null,
      rank: 8,
      points: 3420,
      totalQuestionsAnswered: 225,
      correctAnswers: 198,
      currentStreak: 9,
      longestStreak: 15,
      loginStreak: 18,
      accuracy: 88.0,
    ),
    const LeaderboardEntry(
      uid: 'user9',
      displayName: 'Ruqayya Saleh',
      photoURL: null,
      rank: 9,
      points: 3180,
      totalQuestionsAnswered: 210,
      correctAnswers: 185,
      currentStreak: 8,
      longestStreak: 14,
      loginStreak: 16,
      accuracy: 88.1,
    ),
    const LeaderboardEntry(
      uid: 'user10',
      displayName: 'Yusuf Mustafa',
      photoURL: null,
      rank: 10,
      points: 2950,
      totalQuestionsAnswered: 195,
      correctAnswers: 172,
      currentStreak: 7,
      longestStreak: 12,
      loginStreak: 14,
      accuracy: 88.2,
    ),
    const LeaderboardEntry(
      uid: 'user11',
      displayName: 'Aisha Rahman',
      photoURL: null,
      rank: 11,
      points: 2720,
      totalQuestionsAnswered: 182,
      correctAnswers: 158,
      currentStreak: 6,
      longestStreak: 11,
      loginStreak: 12,
      accuracy: 86.8,
    ),
    const LeaderboardEntry(
      uid: 'user12',
      displayName: 'Zaid Abdullah',
      photoURL: null,
      rank: 12,
      points: 2480,
      totalQuestionsAnswered: 168,
      correctAnswers: 145,
      currentStreak: 5,
      longestStreak: 10,
      loginStreak: 10,
      accuracy: 86.3,
    ),
    const LeaderboardEntry(
      uid: 'user13',
      displayName: 'Sakina Malik',
      photoURL: null,
      rank: 13,
      points: 2250,
      totalQuestionsAnswered: 155,
      correctAnswers: 132,
      currentStreak: 5,
      longestStreak: 9,
      loginStreak: 9,
      accuracy: 85.2,
    ),
    const LeaderboardEntry(
      uid: 'user14',
      displayName: 'Ja\'far Naqvi',
      photoURL: null,
      rank: 14,
      points: 2020,
      totalQuestionsAnswered: 142,
      correctAnswers: 120,
      currentStreak: 4,
      longestStreak: 8,
      loginStreak: 8,
      accuracy: 84.5,
    ),
    const LeaderboardEntry(
      uid: 'user15',
      displayName: 'Sumayya Hadi',
      photoURL: null,
      rank: 15,
      points: 1800,
      totalQuestionsAnswered: 128,
      correctAnswers: 108,
      currentStreak: 4,
      longestStreak: 7,
      loginStreak: 7,
      accuracy: 84.4,
    ),
  ];

  // Mock User Profile
  static UserProfile get mockUserProfile => UserProfile(
        uid: 'mock_user_id',
        email: 'user@pathoflight.com',
        displayName: 'Ahmad Khan',
        photoURL: null,
        phoneNumber: null,
        language: 'en',
        emailVerified: true,
        phoneVerified: false,
        provider: 'google',
        providers: ['google'],
        role: UserRole.user,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        lastActive: DateTime.now(),
        accountStatus: AccountStatus.active,
        profileComplete: true,
        energy: EnergyData(
          currentEnergy: 85,
          maxEnergy: 100,
          lastUpdateTime: DateTime.now(),
          lastDailyBonusDate:
              '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
          totalEnergyUsed: 450,
          totalEnergyEarned: 535,
        ),
        subscription: SubscriptionData(
          plan: 'free',
          active: true,
          startDate: DateTime.now().subtract(const Duration(days: 60)),
          expiryDate: null,
          autoRenew: false,
        ),
        quizProgress: const QuizProgress(
          totalQuestionsAnswered: 186,
          correctAnswers: 158,
          wrongAnswers: 28,
          currentStreak: 12,
          longestStreak: 18,
          totalPoints: 2380,
          categoryProgress: {
            'quran': CategoryProgress(answered: 45, correct: 39, points: 585),
            'hadith': CategoryProgress(answered: 52, correct: 44, points: 660),
            'fiqh': CategoryProgress(answered: 38, correct: 32, points: 480),
            'history': CategoryProgress(answered: 51, correct: 43, points: 645),
          },
          basic: DifficultyProgress(answered: 68, correct: 62),
          intermediate: DifficultyProgress(answered: 72, correct: 60),
          advanced: DifficultyProgress(answered: 36, correct: 28),
          expert: DifficultyProgress(answered: 10, correct: 8),
        ),
        dailyStats: DailyStats(
          lastLoginDate:
              '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
          loginStreak: 14,
          longestLoginStreak: 22,
          totalLoginDays: 48,
        ),
        adTracking: AdTracking(
          adsWatchedToday: 2,
          lastAdWatchedTime: DateTime.now().subtract(const Duration(hours: 3)),
          lastAdResetDate:
              '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
          totalAdsWatched: 45,
        ),
        settings: const UserSettings(
          notifications: NotificationSettings(
            enabled: true,
            prayerTimes: true,
            quizReminders: true,
            achievementUnlocked: true,
          ),
          privacy: PrivacySettings(
            profileVisible: true,
            showInLeaderboard: true,
            allowFriendRequests: true,
          ),
          preferences: UserPreferences(
            theme: 'light',
            fontSize: 'medium',
            language: 'auto',
          ),
        ),
      );

  // Get leaderboard entries sorted by different criteria
  static List<LeaderboardEntry> getLeaderboardByType(LeaderboardType type) {
    final entries = List<LeaderboardEntry>.from(leaderboardEntries);

    switch (type) {
      case LeaderboardType.points:
        entries.sort((a, b) => b.points.compareTo(a.points));
        break;
      case LeaderboardType.streak:
        entries.sort((a, b) => b.currentStreak.compareTo(a.currentStreak));
        break;
      case LeaderboardType.accuracy:
        entries.sort((a, b) => b.accuracy.compareTo(a.accuracy));
        break;
      case LeaderboardType.questions:
        entries
            .sort((a, b) => b.totalQuestionsAnswered.compareTo(a.totalQuestionsAnswered));
        break;
    }

    // Update ranks based on sort
    for (var i = 0; i < entries.length; i++) {
      entries[i] = entries[i].copyWith(rank: i + 1);
    }

    return entries;
  }

  // Get user rank in leaderboard
  static int getUserRank(String userId, LeaderboardType type) {
    final entries = getLeaderboardByType(type);
    final index = entries.indexWhere((e) => e.uid == userId);
    return index == -1 ? -1 : index + 1;
  }

  // Mock quotes of the day
  static final List<Map<String, String>> quotesOfTheDay = [
    {
      'quote': '"The seeking of knowledge is obligatory for every Muslim."',
      'author': 'Prophet Muhammad ﷺ',
    },
    {
      'quote':
          '"He who dies in the search of knowledge dies a martyr."',
      'author': 'Imam Ali (AS)',
    },
    {
      'quote':
          '"Knowledge is better than wealth. Knowledge guards you, while you guard wealth."',
      'author': 'Imam Ali (AS)',
    },
    {
      'quote':
          '"The best form of devotion to the service of Allah is not to make a show of it."',
      'author': 'Imam Ali (AS)',
    },
    {
      'quote': '"Patience is of two kinds: patience over what pains you, and patience against what you covet."',
      'author': 'Imam Ali (AS)',
    },
    {
      'quote': '"Your remedy is within you, but you do not sense it. Your sickness is from you, but you do not perceive it."',
      'author': 'Imam Ali (AS)',
    },
    {
      'quote': '"Silence is the best reply to a fool."',
      'author': 'Imam Ali (AS)',
    },
  ];

  // Get a random quote of the day
  static Map<String, String> getRandomQuote() {
    final today = DateTime.now();
    final seed = today.year * 10000 + today.month * 100 + today.day;
    final index = seed % quotesOfTheDay.length;
    return quotesOfTheDay[index];
  }
}
