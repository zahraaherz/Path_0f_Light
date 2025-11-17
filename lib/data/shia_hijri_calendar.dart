import '../models/islamic_events/islamic_event.dart';

/// Comprehensive Shia Hijri Calendar with all major Islamic celebrations and commemorations
/// Based on the Shia Islamic tradition
class ShiaHijriCalendar {
  static final List<IslamicEvent> events = [
    // ==================== MUHARRAM ====================
    const IslamicEvent(
      id: 'muharram_01',
      title: 'Islamic New Year',
      arabicTitle: 'رأس السنة الهجرية',
      hijriDate: '1 Muharram',
      hijriMonth: 1,
      hijriDay: 1,
      type: IslamicEventType.occasion,
      description: 'Beginning of the Islamic lunar calendar year',
    ),
    const IslamicEvent(
      id: 'muharram_07',
      title: 'Birth of Imam Ali al-Akbar (AS)',
      arabicTitle: 'ولادة الإمام علي الأكبر (ع)',
      hijriDate: '7 Muharram',
      hijriMonth: 1,
      hijriDay: 7,
      type: IslamicEventType.birth,
      description: 'Birth anniversary of the son of Imam Husayn (AS)',
    ),
    const IslamicEvent(
      id: 'muharram_10',
      title: 'Day of Ashura - Martyrdom of Imam Husayn (AS)',
      arabicTitle: 'يوم عاشوراء - شهادة الإمام الحسين (ع)',
      hijriDate: '10 Muharram',
      hijriMonth: 1,
      hijriDay: 10,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of Imam Husayn ibn Ali and his companions at Karbala',
    ),
    const IslamicEvent(
      id: 'muharram_25',
      title: 'Martyrdom of Imam Ali Zayn al-Abidin (AS)',
      arabicTitle: 'شهادة الإمام علي زين العابدين (ع)',
      hijriDate: '25 Muharram',
      hijriMonth: 1,
      hijriDay: 25,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 4th Imam',
    ),

    // ==================== SAFAR ====================
    const IslamicEvent(
      id: 'safar_07',
      title: 'Birth of Imam Musa al-Kadhim (AS)',
      arabicTitle: 'ولادة الإمام موسى الكاظم (ع)',
      hijriDate: '7 Safar',
      hijriMonth: 2,
      hijriDay: 7,
      type: IslamicEventType.birth,
      description: 'Birth anniversary of the 7th Imam',
    ),
    const IslamicEvent(
      id: 'safar_20',
      title: 'Arbaeen - 40th Day of Imam Husayn (AS)',
      arabicTitle: 'الأربعين',
      hijriDate: '20 Safar',
      hijriMonth: 2,
      hijriDay: 20,
      type: IslamicEventType.occasion,
      description: 'Commemoration of the 40th day after the martyrdom of Imam Husayn',
    ),
    const IslamicEvent(
      id: 'safar_28',
      title: 'Martyrdom of Prophet Muhammad (PBUH)',
      arabicTitle: 'شهادة النبي محمد (ص)',
      hijriDate: '28 Safar',
      hijriMonth: 2,
      hijriDay: 28,
      type: IslamicEventType.martyrdom,
      description: 'Passing of the Prophet Muhammad (PBUH)',
    ),
    const IslamicEvent(
      id: 'safar_29',
      title: 'Martyrdom of Imam Hassan al-Mujtaba (AS)',
      arabicTitle: 'شهادة الإمام الحسن المجتبى (ع)',
      hijriDate: '28 Safar', // Note: Some sources say 7th or 28th Safar
      hijriMonth: 2,
      hijriDay: 28,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 2nd Imam',
    ),

    // ==================== RABI' AL-AWWAL ====================
    const IslamicEvent(
      id: 'rabiawwal_08',
      title: 'Martyrdom of Imam Hassan al-Askari (AS)',
      arabicTitle: 'شهادة الإمام الحسن العسكري (ع)',
      hijriDate: '8 Rabi\' al-Awwal',
      hijriMonth: 3,
      hijriDay: 8,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 11th Imam',
    ),
    const IslamicEvent(
      id: 'rabiawwal_17',
      title: 'Birth of Prophet Muhammad (PBUH) & Imam Ja\'far al-Sadiq (AS)',
      arabicTitle: 'ولادة النبي محمد (ص) والإمام جعفر الصادق (ع)',
      hijriDate: '17 Rabi\' al-Awwal',
      hijriMonth: 3,
      hijriDay: 17,
      type: IslamicEventType.birth,
      description: 'Birth of the Prophet Muhammad and the 6th Imam (according to Shia tradition)',
    ),

    // ==================== RABI' AL-THANI (AL-AKHIR) ====================
    const IslamicEvent(
      id: 'rabiathani_10',
      title: 'Birth of Imam Muhammad al-Mahdi (AS)',
      arabicTitle: 'ولادة الإمام محمد المهدي (ع)',
      hijriDate: '10 Rabi\' al-Thani', // Some sources say 15th Sha'ban
      hijriMonth: 4,
      hijriDay: 10,
      type: IslamicEventType.birth,
      description: 'Birth of the 12th Imam, the Awaited Mahdi',
    ),

    // ==================== JUMADA AL-AWWAL ====================
    const IslamicEvent(
      id: 'jumadaawwal_05',
      title: 'Birth of Lady Zaynab (AS)',
      arabicTitle: 'ولادة السيدة زينب (ع)',
      hijriDate: '5 Jumada al-Awwal',
      hijriMonth: 5,
      hijriDay: 5,
      type: IslamicEventType.birth,
      description: 'Birth of Lady Zaynab bint Ali',
    ),

    // ==================== JUMADA AL-THANI (AL-AKHIRAH) ====================
    const IslamicEvent(
      id: 'jumadathani_03',
      title: 'Martyrdom of Lady Fatima al-Zahra (AS)',
      arabicTitle: 'شهادة السيدة فاطمة الزهراء (ع)',
      hijriDate: '3 Jumada al-Thani',
      hijriMonth: 6,
      hijriDay: 3,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the daughter of Prophet Muhammad (first narration)',
    ),
    const IslamicEvent(
      id: 'jumadathani_13',
      title: 'Birth of Imam Ali ibn Abi Talib (AS)',
      arabicTitle: 'ولادة الإمام علي بن أبي طالب (ع)',
      hijriDate: '13 Rajab', // Commonly celebrated in Rajab
      hijriMonth: 7,
      hijriDay: 13,
      type: IslamicEventType.birth,
      description: 'Birth of the 1st Imam and cousin of Prophet Muhammad',
    ),
    const IslamicEvent(
      id: 'jumadathani_20',
      title: 'Birth of Lady Fatima al-Zahra (AS)',
      arabicTitle: 'ولادة السيدة فاطمة الزهراء (ع)',
      hijriDate: '20 Jumada al-Thani',
      hijriMonth: 6,
      hijriDay: 20,
      type: IslamicEventType.birth,
      description: 'Birth of the daughter of Prophet Muhammad',
    ),

    // ==================== RAJAB ====================
    const IslamicEvent(
      id: 'rajab_01',
      title: 'Birth of Imam Muhammad al-Baqir (AS)',
      arabicTitle: 'ولادة الإمام محمد الباقر (ع)',
      hijriDate: '1 Rajab',
      hijriMonth: 7,
      hijriDay: 1,
      type: IslamicEventType.birth,
      description: 'Birth of the 5th Imam',
    ),
    const IslamicEvent(
      id: 'rajab_03',
      title: 'Martyrdom of Imam Ali al-Hadi (AS)',
      arabicTitle: 'شهادة الإمام علي الهادي (ع)',
      hijriDate: '3 Rajab',
      hijriMonth: 7,
      hijriDay: 3,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 10th Imam',
    ),
    const IslamicEvent(
      id: 'rajab_10',
      title: 'Birth of Imam Muhammad al-Jawad (AS)',
      arabicTitle: 'ولادة الإمام محمد الجواد (ع)',
      hijriDate: '10 Rajab',
      hijriMonth: 7,
      hijriDay: 10,
      type: IslamicEventType.birth,
      description: 'Birth of the 9th Imam',
    ),
    const IslamicEvent(
      id: 'rajab_13',
      title: 'Birth of Imam Ali ibn Abi Talib (AS)',
      arabicTitle: 'ولادة الإمام علي بن أبي طالب (ع)',
      hijriDate: '13 Rajab',
      hijriMonth: 7,
      hijriDay: 13,
      type: IslamicEventType.birth,
      description: 'Birth of the Commander of the Faithful inside the Kaaba',
    ),
    const IslamicEvent(
      id: 'rajab_15',
      title: 'Martyrdom of Lady Zaynab (AS)',
      arabicTitle: 'شهادة السيدة زينب (ع)',
      hijriDate: '15 Rajab',
      hijriMonth: 7,
      hijriDay: 15,
      type: IslamicEventType.martyrdom,
      description: 'Passing of Lady Zaynab bint Ali',
    ),
    const IslamicEvent(
      id: 'rajab_25',
      title: 'Martyrdom of Imam Musa al-Kadhim (AS)',
      arabicTitle: 'شهادة الإمام موسى الكاظم (ع)',
      hijriDate: '25 Rajab',
      hijriMonth: 7,
      hijriDay: 25,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 7th Imam',
    ),
    const IslamicEvent(
      id: 'rajab_27',
      title: 'Isra and Mi\'raj - Night Journey',
      arabicTitle: 'الإسراء والمعراج',
      hijriDate: '27 Rajab',
      hijriMonth: 7,
      hijriDay: 27,
      type: IslamicEventType.occasion,
      description: 'Night Journey and Ascension of Prophet Muhammad',
    ),

    // ==================== SHA'BAN ====================
    const IslamicEvent(
      id: 'shaban_03',
      title: 'Birth of Imam Husayn ibn Ali (AS)',
      arabicTitle: 'ولادة الإمام الحسين بن علي (ع)',
      hijriDate: '3 Sha\'ban',
      hijriMonth: 8,
      hijriDay: 3,
      type: IslamicEventType.birth,
      description: 'Birth of the 3rd Imam, Master of Martyrs',
    ),
    const IslamicEvent(
      id: 'shaban_04',
      title: 'Birth of Imam Abbas (AS)',
      arabicTitle: 'ولادة أبو الفضل العباس (ع)',
      hijriDate: '4 Sha\'ban',
      hijriMonth: 8,
      hijriDay: 4,
      type: IslamicEventType.birth,
      description: 'Birth of Abbas ibn Ali, standard bearer of Karbala',
    ),
    const IslamicEvent(
      id: 'shaban_05',
      title: 'Birth of Imam Ali al-Akbar (AS)',
      arabicTitle: 'ولادة الإمام علي الأكبر (ع)',
      hijriDate: '5 Sha\'ban',
      hijriMonth: 8,
      hijriDay: 5,
      type: IslamicEventType.birth,
      description: 'Birth of the son of Imam Husayn',
    ),
    const IslamicEvent(
      id: 'shaban_11',
      title: 'Birth of Ali al-Asghar (AS)',
      arabicTitle: 'ولادة علي الأصغر (ع)',
      hijriDate: '11 Sha\'ban',
      hijriMonth: 8,
      hijriDay: 11,
      type: IslamicEventType.birth,
      description: 'Birth of the infant son of Imam Husayn',
    ),
    const IslamicEvent(
      id: 'shaban_15',
      title: 'Birth of Imam Muhammad al-Mahdi (AS)',
      arabicTitle: 'ولادة الإمام محمد المهدي (ع)',
      hijriDate: '15 Sha\'ban',
      hijriMonth: 8,
      hijriDay: 15,
      type: IslamicEventType.birth,
      description: 'Birthday of the 12th Imam, the Awaited Mahdi (most commonly celebrated date)',
    ),

    // ==================== RAMADAN ====================
    const IslamicEvent(
      id: 'ramadan_01',
      title: 'Beginning of Ramadan',
      arabicTitle: 'بداية شهر رمضان المبارك',
      hijriDate: '1 Ramadan',
      hijriMonth: 9,
      hijriDay: 1,
      type: IslamicEventType.occasion,
      description: 'Start of the holy month of fasting',
    ),
    const IslamicEvent(
      id: 'ramadan_10',
      title: 'Martyrdom of Lady Khadijah (AS)',
      arabicTitle: 'وفاة السيدة خديجة (ع)',
      hijriDate: '10 Ramadan',
      hijriMonth: 9,
      hijriDay: 10,
      type: IslamicEventType.martyrdom,
      description: 'Passing of the wife of Prophet Muhammad',
    ),
    const IslamicEvent(
      id: 'ramadan_15',
      title: 'Birth of Imam Hassan ibn Ali (AS)',
      arabicTitle: 'ولادة الإمام الحسن بن علي (ع)',
      hijriDate: '15 Ramadan',
      hijriMonth: 9,
      hijriDay: 15,
      type: IslamicEventType.birth,
      description: 'Birth of the 2nd Imam',
    ),
    const IslamicEvent(
      id: 'ramadan_19',
      title: 'Laylat al-Qadr (1st Night) - Wounding of Imam Ali (AS)',
      arabicTitle: 'ليلة القدر - ضربة الإمام علي (ع)',
      hijriDate: '19 Ramadan',
      hijriMonth: 9,
      hijriDay: 19,
      type: IslamicEventType.occasion,
      description: 'Night of Decree - Imam Ali was struck in Kufa',
    ),
    const IslamicEvent(
      id: 'ramadan_21',
      title: 'Martyrdom of Imam Ali ibn Abi Talib (AS)',
      arabicTitle: 'شهادة الإمام علي بن أبي طالب (ع)',
      hijriDate: '21 Ramadan',
      hijriMonth: 9,
      hijriDay: 21,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 1st Imam, Commander of the Faithful',
    ),
    const IslamicEvent(
      id: 'ramadan_21_qadr',
      title: 'Laylat al-Qadr (2nd Night)',
      arabicTitle: 'ليلة القدر',
      hijriDate: '21 Ramadan',
      hijriMonth: 9,
      hijriDay: 21,
      type: IslamicEventType.occasion,
      description: 'Night of Decree - Better than a thousand months',
    ),
    const IslamicEvent(
      id: 'ramadan_23',
      title: 'Laylat al-Qadr (3rd Night)',
      arabicTitle: 'ليلة القدر',
      hijriDate: '23 Ramadan',
      hijriMonth: 9,
      hijriDay: 23,
      type: IslamicEventType.occasion,
      description: 'Night of Decree - Most emphasized night',
    ),

    // ==================== SHAWWAL ====================
    const IslamicEvent(
      id: 'shawwal_01',
      title: 'Eid al-Fitr',
      arabicTitle: 'عيد الفطر المبارك',
      hijriDate: '1 Shawwal',
      hijriMonth: 10,
      hijriDay: 1,
      type: IslamicEventType.celebration,
      description: 'Festival of Breaking the Fast',
    ),
    const IslamicEvent(
      id: 'shawwal_25',
      title: 'Martyrdom of Imam Ja\'far al-Sadiq (AS)',
      arabicTitle: 'شهادة الإمام جعفر الصادق (ع)',
      hijriDate: '25 Shawwal',
      hijriMonth: 10,
      hijriDay: 25,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 6th Imam',
    ),

    // ==================== DHU AL-QA'DAH ====================
    const IslamicEvent(
      id: 'dhuqadah_11',
      title: 'Birth of Imam Ali al-Ridha (AS)',
      arabicTitle: 'ولادة الإمام علي الرضا (ع)',
      hijriDate: '11 Dhu al-Qa\'dah',
      hijriMonth: 11,
      hijriDay: 11,
      type: IslamicEventType.birth,
      description: 'Birth of the 8th Imam',
    ),
    const IslamicEvent(
      id: 'dhuqadah_23',
      title: 'Birth of Imam Ali al-Hadi (AS)',
      arabicTitle: 'ولادة الإمام علي الهادي (ع)',
      hijriDate: '23 Dhu al-Qa\'dah', // Some say 15th Dhu al-Hijjah or 2nd Rajab
      hijriMonth: 11,
      hijriDay: 23,
      type: IslamicEventType.birth,
      description: 'Birth of the 10th Imam',
    ),
    const IslamicEvent(
      id: 'dhuqadah_29',
      title: 'Martyrdom of Imam Muhammad al-Jawad (AS)',
      arabicTitle: 'شهادة الإمام محمد الجواد (ع)',
      hijriDate: '29 Dhu al-Qa\'dah',
      hijriMonth: 11,
      hijriDay: 29,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 9th Imam',
    ),

    // ==================== DHU AL-HIJJAH ====================
    const IslamicEvent(
      id: 'dhuhijjah_01',
      title: 'Birth of Imam Hassan al-Askari (AS)',
      arabicTitle: 'ولادة الإمام الحسن العسكري (ع)',
      hijriDate: '1 Dhu al-Hijjah', // Some say 8th Rabi' al-Thani
      hijriMonth: 12,
      hijriDay: 1,
      type: IslamicEventType.birth,
      description: 'Birth of the 11th Imam',
    ),
    const IslamicEvent(
      id: 'dhuhijjah_07',
      title: 'Martyrdom of Imam Muhammad al-Baqir (AS)',
      arabicTitle: 'شهادة الإمام محمد الباقر (ع)',
      hijriDate: '7 Dhu al-Hijjah',
      hijriMonth: 12,
      hijriDay: 7,
      type: IslamicEventType.martyrdom,
      description: 'Martyrdom of the 5th Imam',
    ),
    const IslamicEvent(
      id: 'dhuhijjah_09',
      title: 'Day of Arafah',
      arabicTitle: 'يوم عرفة',
      hijriDate: '9 Dhu al-Hijjah',
      hijriMonth: 12,
      hijriDay: 9,
      type: IslamicEventType.occasion,
      description: 'Day of standing at Arafah during Hajj',
    ),
    const IslamicEvent(
      id: 'dhuhijjah_10',
      title: 'Eid al-Adha',
      arabicTitle: 'عيد الأضحى المبارك',
      hijriDate: '10 Dhu al-Hijjah',
      hijriMonth: 12,
      hijriDay: 10,
      type: IslamicEventType.celebration,
      description: 'Festival of Sacrifice',
    ),
    const IslamicEvent(
      id: 'dhuhijjah_18',
      title: 'Eid al-Ghadir',
      arabicTitle: 'عيد الغدير',
      hijriDate: '18 Dhu al-Hijjah',
      hijriMonth: 12,
      hijriDay: 18,
      type: IslamicEventType.celebration,
      description: 'Celebration of the appointment of Imam Ali as successor to Prophet Muhammad',
    ),
    const IslamicEvent(
      id: 'dhuhijjah_24',
      title: 'Eid al-Mubahala',
      arabicTitle: 'عيد المباهلة',
      hijriDate: '24 Dhu al-Hijjah',
      hijriMonth: 12,
      hijriDay: 24,
      type: IslamicEventType.occasion,
      description: 'Commemoration of the Mubahala event',
    ),
  ];

  /// Get all events
  static List<IslamicEvent> getAllEvents() {
    return events;
  }

  /// Get events for a specific month
  static List<IslamicEvent> getEventsForMonth(int month) {
    return events.where((event) => event.hijriMonth == month).toList();
  }

  /// Get events for a specific date
  static List<IslamicEvent> getEventsForDate(int month, int day) {
    return events
        .where((event) => event.hijriMonth == month && event.hijriDay == day)
        .toList();
  }

  /// Get upcoming events (next N events from current date)
  static List<IslamicEvent> getUpcomingEvents({
    required int currentMonth,
    required int currentDay,
    int count = 5,
  }) {
    final List<IslamicEvent> upcomingEvents = [];

    // Calculate current date as a single number for comparison
    int currentDateValue = currentMonth * 100 + currentDay;

    // Find all events after current date
    for (var event in events) {
      int eventDateValue = event.hijriMonth! * 100 + event.hijriDay!;
      if (eventDateValue >= currentDateValue) {
        upcomingEvents.add(event);
      }
    }

    // If we need more events, add from beginning of year
    if (upcomingEvents.length < count) {
      for (var event in events) {
        int eventDateValue = event.hijriMonth! * 100 + event.hijriDay!;
        if (eventDateValue < currentDateValue) {
          upcomingEvents.add(event);
        }
        if (upcomingEvents.length >= count) break;
      }
    }

    // Sort by date
    upcomingEvents.sort((a, b) {
      int aValue = a.hijriMonth! * 100 + a.hijriDay!;
      int bValue = b.hijriMonth! * 100 + b.hijriDay!;
      return aValue.compareTo(bValue);
    });

    return upcomingEvents.take(count).toList();
  }

  /// Get events by type
  static List<IslamicEvent> getEventsByType(IslamicEventType type) {
    return events.where((event) => event.type == type).toList();
  }

  /// Check if a specific date has any events
  static bool hasEvents(int month, int day) {
    return events.any(
      (event) => event.hijriMonth == month && event.hijriDay == day,
    );
  }

  /// Get all birth celebrations
  static List<IslamicEvent> getBirthCelebrations() {
    return getEventsByType(IslamicEventType.birth);
  }

  /// Get all martyrdom commemorations
  static List<IslamicEvent> getMartyrdomCommemorations() {
    return getEventsByType(IslamicEventType.martyrdom);
  }

  /// Get all major celebrations (Eids)
  static List<IslamicEvent> getMajorCelebrations() {
    return getEventsByType(IslamicEventType.celebration);
  }

  /// Get month name in English
  static String getMonthName(int month) {
    const monthNames = [
      'Muharram',
      'Safar',
      'Rabi\' al-Awwal',
      'Rabi\' al-Thani',
      'Jumada al-Awwal',
      'Jumada al-Thani',
      'Rajab',
      'Sha\'ban',
      'Ramadan',
      'Shawwal',
      'Dhu al-Qa\'dah',
      'Dhu al-Hijjah',
    ];
    return month >= 1 && month <= 12 ? monthNames[month - 1] : '';
  }

  /// Get month name in Arabic
  static String getMonthNameArabic(int month) {
    const monthNames = [
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الثاني',
      'جمادى الأولى',
      'جمادى الثانية',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة',
    ];
    return month >= 1 && month <= 12 ? monthNames[month - 1] : '';
  }
}
