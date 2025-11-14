import '../models/leaderboard/leaderboard_entry.dart';
import '../models/user/user_profile.dart';
import '../models/user/user_role.dart';
import '../models/prayer/prayer_times.dart';
import '../models/islamic_events/islamic_event.dart';
import '../models/dua/dua_model.dart';

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

  // ============================================================================
  // PRAYER TIMES MOCK DATA
  // ============================================================================

  static DailyPrayerTimes get todayPrayerTimes {
    final now = DateTime.now();
    final currentHour = now.hour;

    return DailyPrayerTimes(
      date: now,
      fajr: PrayerTime(
        name: 'Fajr',
        arabicName: 'الفجر',
        time: '05:15 AM',
        isPassed: currentHour >= 5,
        iqamaTime: '05:30 AM',
      ),
      sunrise: PrayerTime(
        name: 'Sunrise',
        arabicName: 'الشروق',
        time: '06:42 AM',
        isPassed: currentHour >= 6,
      ),
      dhuhr: PrayerTime(
        name: 'Dhuhr',
        arabicName: 'الظهر',
        time: '12:28 PM',
        isPassed: currentHour >= 12,
        iqamaTime: '12:45 PM',
      ),
      asr: PrayerTime(
        name: 'Asr',
        arabicName: 'العصر',
        time: '03:45 PM',
        isPassed: currentHour >= 15,
        iqamaTime: '04:00 PM',
      ),
      maghrib: PrayerTime(
        name: 'Maghrib',
        arabicName: 'المغرب',
        time: '06:15 PM',
        isPassed: currentHour >= 18,
        iqamaTime: '06:20 PM',
      ),
      isha: PrayerTime(
        name: 'Isha',
        arabicName: 'العشاء',
        time: '07:42 PM',
        isPassed: currentHour >= 19,
        iqamaTime: '07:55 PM',
      ),
      nextPrayer: _getNextPrayer(currentHour),
      timeUntilNext: _getTimeUntilNext(currentHour),
    );
  }

  static String _getNextPrayer(int currentHour) {
    if (currentHour < 5) return 'Fajr';
    if (currentHour < 12) return 'Dhuhr';
    if (currentHour < 15) return 'Asr';
    if (currentHour < 18) return 'Maghrib';
    if (currentHour < 19) return 'Isha';
    return 'Fajr (tomorrow)';
  }

  static String _getTimeUntilNext(int currentHour) {
    if (currentHour < 5) return '${5 - currentHour}h ${60 - DateTime.now().minute}m';
    if (currentHour < 12) return '${12 - currentHour}h ${28 - DateTime.now().minute}m';
    if (currentHour < 15) return '${15 - currentHour}h ${45 - DateTime.now().minute}m';
    if (currentHour < 18) return '${18 - currentHour}h ${15 - DateTime.now().minute}m';
    if (currentHour < 19) return '${19 - currentHour}h ${42 - DateTime.now().minute}m';
    return '${24 + 5 - currentHour}h';
  }

  // ============================================================================
  // ISLAMIC EVENTS MOCK DATA
  // ============================================================================

  static final List<IslamicEvent> islamicEvents = [
    const IslamicEvent(
      id: 'event_1',
      title: 'Day of Ashura',
      arabicTitle: 'يوم عاشوراء',
      description: 'The martyrdom of Imam Husayn (AS) at Karbala',
      type: IslamicEventType.martyrdom,
      hijriDate: '10 Muharram',
      significance: 'One of the most significant days in Islamic history, marking the martyrdom of Imam Husayn (AS) and his companions at Karbala.',
      recommendations: [
        'Fast on this day',
        'Recite Ziyarat Ashura',
        'Attend mourning gatherings',
        'Give charity',
      ],
    ),
    const IslamicEvent(
      id: 'event_2',
      title: 'Birth of Prophet Muhammad (PBUH)',
      arabicTitle: 'مولد النبي محمد ﷺ',
      description: 'The birth of the final messenger, Prophet Muhammad (PBUH)',
      type: IslamicEventType.birth,
      hijriDate: '17 Rabi al-Awwal',
      significance: 'Celebration of the birth of the Seal of Prophets, Muhammad (PBUH).',
      recommendations: [
        'Send blessings upon the Prophet',
        'Read about the Seerah',
        'Organize gatherings',
        'Give charity to the poor',
      ],
    ),
    const IslamicEvent(
      id: 'event_3',
      title: 'Birth of Imam Ali (AS)',
      arabicTitle: 'مولد الإمام علي (ع)',
      description: 'The birth of Imam Ali ibn Abi Talib (AS) in the Kaaba',
      type: IslamicEventType.birth,
      hijriDate: '13 Rajab',
      significance: 'The only person born inside the Holy Kaaba, Imam Ali (AS) is the first Imam of Shia Muslims.',
      recommendations: [
        'Recite Nahjul Balagha',
        'Study his teachings',
        'Visit the mosque',
        'Help the needy',
      ],
    ),
    const IslamicEvent(
      id: 'event_4',
      title: 'Laylat al-Qadr',
      arabicTitle: 'ليلة القدر',
      description: 'The Night of Power, better than a thousand months',
      type: IslamicEventType.occasion,
      hijriDate: '19, 21, 23 Ramadan',
      significance: 'The night when the Quran was first revealed. Worship on this night is better than 1000 months.',
      recommendations: [
        'Stay awake in worship',
        'Recite Quran',
        'Make abundant dua',
        'Seek forgiveness',
      ],
    ),
    const IslamicEvent(
      id: 'event_5',
      title: 'Eid al-Fitr',
      arabicTitle: 'عيد الفطر',
      description: 'Festival celebrating the end of Ramadan',
      type: IslamicEventType.celebration,
      hijriDate: '1 Shawwal',
      significance: 'Celebration marking the end of the blessed month of Ramadan.',
      recommendations: [
        'Pray Eid salah',
        'Give Zakat al-Fitr',
        'Visit family and friends',
        'Wear new clothes',
      ],
    ),
    const IslamicEvent(
      id: 'event_6',
      title: 'Birth of Lady Fatima (AS)',
      arabicTitle: 'مولد السيدة فاطمة الزهراء (ع)',
      description: 'The birth of Lady Fatima al-Zahra (AS), daughter of the Prophet',
      type: IslamicEventType.birth,
      hijriDate: '20 Jumada al-Thani',
      significance: 'The birth of the daughter of Prophet Muhammad (PBUH) and mother of Imam Hasan and Imam Husayn.',
      recommendations: [
        'Recite Tasbih of Lady Fatima',
        'Read about her life',
        'Organize gatherings',
        'Honor women in your family',
      ],
    ),
  ];

  // Get upcoming events (next 3 events)
  static List<IslamicEvent> get upcomingEvents {
    return islamicEvents.take(3).toList();
  }

  // ============================================================================
  // DU'A MOCK DATA
  // ============================================================================

  static final List<Dua> duaList = [
    const Dua(
      id: 'dua_1',
      title: 'Du\'a for Morning',
      arabicTitle: 'دعاء الصباح',
      arabicText: 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ وَمَلَائِكَتَكَ وَجَمِيعَ خَلْقِكَ أَنَّكَ أَنْتَ اللَّهُ لَا إِلَٰهَ إِلَّا أَنْتَ وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ',
      translation: 'O Allah, as I enter this morning, I call upon You, and upon the bearers of Your Throne, Your angels and all creation to witness that You are Allah, there is no god but You alone, and that Muhammad is Your servant and Messenger.',
      transliteration: 'Allahumma inni asbahtu ushhiduka wa ushhidu hamalata \'arshika wa mala\'ikatika wa jami\'a khalqika annaka Antallahu la ilaha illa Anta wa anna Muhammadan \'abduka wa Rasuluk',
      category: DuaCategory.morning,
      shortExcerpt: 'Morning affirmation of faith',
      meaning: 'This du\'a starts the day by affirming one\'s faith in Allah and the Prophethood of Muhammad (PBUH).',
      tafsir: 'Reciting this du\'a every morning helps strengthen one\'s connection with Allah and reminds us of our purpose.',
      source: 'Sahih Muslim',
      benefits: 'Protection throughout the day, increased faith, and blessings.',
      hasTashkeel: true,
    ),
    const Dua(
      id: 'dua_2',
      title: 'Du\'a for Knowledge',
      arabicTitle: 'دعاء طلب العلم',
      arabicText: 'رَبِّ زِدْنِي عِلْمًا',
      translation: 'My Lord, increase me in knowledge.',
      transliteration: 'Rabbi zidni \'ilma',
      category: DuaCategory.knowledge,
      shortExcerpt: 'Seeking knowledge',
      meaning: 'A simple yet powerful prayer asking Allah to grant more knowledge.',
      tafsir: 'This is the du\'a that Allah taught to Prophet Muhammad (PBUH) in the Quran.',
      source: 'Quran 20:114',
      benefits: 'Opens doors of knowledge, improves understanding, and brings barakah in learning.',
      hasTashkeel: true,
    ),
    const Dua(
      id: 'dua_3',
      title: 'Du\'a for Protection',
      arabicTitle: 'دعاء الحفظ',
      arabicText: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      translation: 'I seek refuge in the perfect words of Allah from the evil of what He has created.',
      transliteration: 'A\'udhu bi kalimatillahi at-tammati min sharri ma khalaq',
      category: DuaCategory.protection,
      shortExcerpt: 'Seeking Allah\'s protection',
      meaning: 'A powerful du\'a for protection from all forms of harm.',
      tafsir: 'The Prophet (PBUH) used to recite this du\'a for protection, especially when traveling.',
      source: 'Sahih Muslim',
      benefits: 'Protection from harm, evil eye, and negative energies.',
      hasTashkeel: true,
    ),
    const Dua(
      id: 'dua_4',
      title: 'Du\'a for Patience',
      arabicTitle: 'دعاء الصبر',
      arabicText: 'رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَثَبِّتْ أَقْدَامَنَا',
      translation: 'Our Lord, pour upon us patience and make our steps firm.',
      transliteration: 'Rabbana afrigh \'alayna sabran wa thabbit aqdamana',
      category: DuaCategory.daily,
      shortExcerpt: 'Asking for patience',
      meaning: 'A du\'a to ask Allah for patience in times of difficulty.',
      tafsir: 'Patience (sabr) is one of the greatest virtues in Islam, and this du\'a helps strengthen it.',
      source: 'Quran 2:250',
      benefits: 'Strengthens resolve, brings peace of mind, and helps overcome difficulties.',
      hasTashkeel: true,
    ),
    const Dua(
      id: 'dua_5',
      title: 'Du\'a for Forgiveness',
      arabicTitle: 'دعاء الاستغفار',
      arabicText: 'أَسْتَغْفِرُ اللَّهَ الَّذِي لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
      translation: 'I seek forgiveness from Allah, there is no god but He, the Ever-Living, the Sustainer, and I repent to Him.',
      transliteration: 'Astaghfirullaha alladhi la ilaha illa Huwa al-Hayyu al-Qayyumu wa atubu ilayh',
      category: DuaCategory.forgiveness,
      shortExcerpt: 'Seeking forgiveness',
      meaning: 'The master du\'a for seeking forgiveness from Allah.',
      tafsir: 'Reciting this regularly washes away sins and brings one closer to Allah.',
      source: 'Hadith',
      benefits: 'Forgiveness of sins, peace of heart, and increased taqwa.',
      hasTashkeel: true,
    ),
  ];

  // Get daily du'a (rotates based on day)
  static Dua get dailyDua {
    final today = DateTime.now();
    final index = today.day % duaList.length;
    return duaList[index];
  }

  // ============================================================================
  // AUDIO RECITATIONS MOCK DATA
  // ============================================================================

  static final List<AudioRecitation> audioRecitations = [
    const AudioRecitation(
      id: 'audio_1',
      title: 'Du\'a Kumayl',
      arabicTitle: 'دعاء كميل',
      reciter: 'Sheikh Abdulbasit',
      audioUrl: 'https://example.com/dua_kumayl.mp3',
      durationMinutes: 25,
      description: 'A powerful du\'a taught by Imam Ali (AS) to his companion Kumayl ibn Ziyad.',
    ),
    const AudioRecitation(
      id: 'audio_2',
      title: 'Ziyarat Ashura',
      arabicTitle: 'زيارة عاشوراء',
      reciter: 'Sheikh Husayn Akraf',
      audioUrl: 'https://example.com/ziyarat_ashura.mp3',
      durationMinutes: 30,
      description: 'The famous ziyarat of Imam Husayn (AS) recommended to be recited on the day of Ashura.',
    ),
    const AudioRecitation(
      id: 'audio_3',
      title: 'Du\'a Tawassul',
      arabicTitle: 'دعاء التوسل',
      reciter: 'Sheikh Majid al-Amili',
      audioUrl: 'https://example.com/dua_tawassul.mp3',
      durationMinutes: 10,
      description: 'A beautiful du\'a seeking intercession through the Ahlul Bayt.',
    ),
    const AudioRecitation(
      id: 'audio_4',
      title: 'Du\'a Nudba',
      arabicTitle: 'دعاء الندبة',
      reciter: 'Basim Karbalai',
      audioUrl: 'https://example.com/dua_nudba.mp3',
      durationMinutes: 20,
      description: 'A lamentation du\'a expressing longing for Imam Mahdi (AJ).',
    ),
  ];

  // ============================================================================
  // SPIRITUAL CHECKLIST MOCK DATA
  // ============================================================================

  static List<SpiritualChecklistItem> get todayChecklist {
    return [
      SpiritualChecklistItem(
        id: 'check_1',
        title: 'Fajr Prayer',
        arabicTitle: 'صلاة الفجر',
        type: 'prayer',
        isCompleted: false,
      ),
      const SpiritualChecklistItem(
        id: 'check_2',
        title: 'Morning Dhikr',
        arabicTitle: 'أذكار الصباح',
        type: 'dhikr',
        isCompleted: false,
        targetCount: 100,
        currentCount: 0,
      ),
      const SpiritualChecklistItem(
        id: 'check_3',
        title: 'Quran Recitation',
        arabicTitle: 'قراءة القرآن',
        type: 'quran',
        isCompleted: false,
      ),
      SpiritualChecklistItem(
        id: 'check_4',
        title: 'Du\'a Kumayl (Thursday)',
        arabicTitle: 'دعاء كميل',
        type: 'dua',
        isCompleted: false,
      ),
      const SpiritualChecklistItem(
        id: 'check_5',
        title: 'Give Charity',
        arabicTitle: 'الصدقة',
        type: 'other',
        isCompleted: false,
      ),
    ];
  }

  // ============================================================================
  // HIJRI DATE UTILITIES
  // ============================================================================

  static HijriDate get todayHijriDate {
    // This is a simplified mock - in real app, use proper Hijri calculation
    return const HijriDate(
      day: 15,
      month: 5,
      year: 1446,
      monthName: 'Jumada al-Awwal',
      monthNameArabic: 'جمادى الأولى',
      weekdayName: 'Friday',
      weekdayNameArabic: 'الجمعة',
    );
  }

  static String get formattedHijriDate {
    final hijri = todayHijriDate;
    return '${hijri.day} ${hijri.monthName} ${hijri.year} AH';
  }

  static String get formattedArabicHijriDate {
    final hijri = todayHijriDate;
    return '${hijri.day} ${hijri.monthNameArabic} ${hijri.year} هـ';
  }
}
