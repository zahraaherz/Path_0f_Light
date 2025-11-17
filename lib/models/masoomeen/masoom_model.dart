import 'package:freezed_annotation/freezed_annotation.dart';

part 'masoom_model.freezed.dart';
part 'masoom_model.g.dart';

/// Model representing one of the 14 Masoomeen (Infallibles) in Shia Islam
@freezed
class Masoom with _$Masoom {
  const factory Masoom({
    required String id,
    required String name,
    required String arabicName,
    required String title,
    required String arabicTitle,
    required int order, // 1-14
    required String imageUrl,
    required String birthPlace,
    required String birthDate,
    String? deathPlace,
    String? deathDate,
    required String shortBio,
    required List<String> notableEvents,
    required List<String> teachings,
    required int quizCount, // Number of available quizzes
  }) = _Masoom;

  factory Masoom.fromJson(Map<String, dynamic> json) => _$MasoomFromJson(json);
}

/// The 14 Masoomeen in order
class MasoomeenData {
  static final List<Masoom> all = [
    // 1. Prophet Muhammad (ﷺ)
    Masoom(
      id: 'prophet-muhammad',
      name: 'Prophet Muhammad',
      arabicName: 'مُحَمَّد',
      title: 'The Seal of Prophets',
      arabicTitle: 'خاتم النبيين',
      order: 1,
      imageUrl: '',
      birthPlace: 'Mecca',
      birthDate: '571 CE (Year of the Elephant)',
      deathPlace: 'Medina',
      deathDate: '632 CE',
      shortBio: 'The final messenger of Allah, who brought the Holy Quran and completed the message of Islam.',
      notableEvents: [
        'Revelation of the Quran',
        'Migration to Medina (Hijra)',
        'Event of Ghadir Khumm',
        'Farewell Pilgrimage',
      ],
      teachings: [
        'Tawhid (Oneness of Allah)',
        'Justice and Equality',
        'Compassion and Mercy',
        'Importance of Knowledge',
      ],
      quizCount: 50,
    ),

    // 2. Fatima al-Zahra (AS)
    Masoom(
      id: 'fatima-zahra',
      name: 'Fatima al-Zahra',
      arabicName: 'فاطمة الزهراء',
      title: 'The Radiant One',
      arabicTitle: 'سيدة نساء العالمين',
      order: 2,
      imageUrl: '',
      birthPlace: 'Mecca',
      birthDate: '605 or 615 CE',
      deathPlace: 'Medina',
      deathDate: '632 CE',
      shortBio: 'The beloved daughter of Prophet Muhammad and wife of Imam Ali, known for her piety and knowledge.',
      notableEvents: [
        'Marriage to Imam Ali',
        'Birth of Imam Hassan and Hussain',
        'Sermon of Fadak',
        'Event of the Cloak (Hadith al-Kisa)',
      ],
      teachings: [
        'Rights of Women',
        'Importance of Family',
        'Standing for Justice',
        'Devotion to Allah',
      ],
      quizCount: 30,
    ),

    // 3. Imam Ali (AS)
    Masoom(
      id: 'imam-ali',
      name: 'Imam Ali ibn Abi Talib',
      arabicName: 'علي بن أبي طالب',
      title: 'Commander of the Faithful',
      arabicTitle: 'أمير المؤمنين',
      order: 3,
      imageUrl: '',
      birthPlace: 'Kaaba, Mecca',
      birthDate: '600 CE',
      deathPlace: 'Kufa',
      deathDate: '661 CE',
      shortBio: 'The first Imam, cousin and son-in-law of Prophet Muhammad, known for his wisdom, bravery, and justice.',
      notableEvents: [
        'First male to accept Islam',
        'Night of Migration (sleeping in Prophet\'s bed)',
        'Battle of Badr, Uhud, Khandaq',
        'Caliphate period and governance',
      ],
      teachings: [
        'Nahj al-Balagha (Peak of Eloquence)',
        'Justice and Governance',
        'Knowledge and Wisdom',
        'Equality and Social Justice',
      ],
      quizCount: 60,
    ),

    // 4. Imam Hassan (AS)
    Masoom(
      id: 'imam-hassan',
      name: 'Imam Hassan al-Mujtaba',
      arabicName: 'الحسن المجتبى',
      title: 'The Chosen One',
      arabicTitle: 'سيد شباب أهل الجنة',
      order: 4,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '625 CE',
      deathPlace: 'Medina',
      deathDate: '670 CE',
      shortBio: 'The second Imam, known for his wisdom in preventing bloodshed through peace treaty.',
      notableEvents: [
        'Peace Treaty with Muawiyah',
        'Protection of Muslim unity',
        'Acts of charity and generosity',
      ],
      teachings: [
        'Wisdom in Peace',
        'Strategic Patience',
        'Unity of Muslims',
        'Generosity and Kindness',
      ],
      quizCount: 25,
    ),

    // 5. Imam Hussain (AS)
    Masoom(
      id: 'imam-hussain',
      name: 'Imam Hussain ibn Ali',
      arabicName: 'الحسين بن علي',
      title: 'Master of Martyrs',
      arabicTitle: 'سيد الشهداء',
      order: 5,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '626 CE',
      deathPlace: 'Karbala',
      deathDate: '680 CE (10th Muharram)',
      shortBio: 'The third Imam, who sacrificed everything in Karbala to preserve Islam and stand against tyranny.',
      notableEvents: [
        'Event of Karbala',
        'Journey to Kufa',
        'Stand against Yazid',
        'Ultimate sacrifice on Ashura',
      ],
      teachings: [
        'Standing against oppression',
        'Sacrifice for truth',
        'Dignity and honor',
        'Never compromising principles',
      ],
      quizCount: 70,
    ),

    // 6. Imam Zayn al-Abidin (AS)
    Masoom(
      id: 'imam-zayn-al-abidin',
      name: 'Imam Ali Zayn al-Abidin',
      arabicName: 'علي زين العابدين',
      title: 'Ornament of the Worshippers',
      arabicTitle: 'سيد الساجدين',
      order: 6,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '658 CE',
      deathPlace: 'Medina',
      deathDate: '713 CE',
      shortBio: 'The fourth Imam, author of Sahifa al-Sajjadiya, known for his devotion and supplications.',
      notableEvents: [
        'Survived Karbala',
        'Journey as captive to Damascus',
        'Compilation of Sahifa al-Sajjadiya',
      ],
      teachings: [
        'Spiritual devotion',
        'Rights of others',
        'Patience in adversity',
        'Power of supplication',
      ],
      quizCount: 30,
    ),

    // 7. Imam Muhammad al-Baqir (AS)
    Masoom(
      id: 'imam-muhammad-baqir',
      name: 'Imam Muhammad al-Baqir',
      arabicName: 'محمد الباقر',
      title: 'The Revealer of Knowledge',
      arabicTitle: 'باقر العلوم',
      order: 7,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '676 CE',
      deathPlace: 'Medina',
      deathDate: '733 CE',
      shortBio: 'The fifth Imam, who revealed vast Islamic knowledge and trained many scholars.',
      notableEvents: [
        'Establishment of Islamic sciences',
        'Training of scholars',
        'Preserving Islamic knowledge',
      ],
      teachings: [
        'Islamic jurisprudence',
        'Quranic exegesis',
        'Hadith sciences',
        'Unity through knowledge',
      ],
      quizCount: 35,
    ),

    // 8. Imam Ja'far al-Sadiq (AS)
    Masoom(
      id: 'imam-jafar-sadiq',
      name: 'Imam Ja\'far al-Sadiq',
      arabicName: 'جعفر الصادق',
      title: 'The Truthful',
      arabicTitle: 'الصادق',
      order: 8,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '702 CE',
      deathPlace: 'Medina',
      deathDate: '765 CE',
      shortBio: 'The sixth Imam, founder of Ja\'fari school of jurisprudence, known for vast knowledge.',
      notableEvents: [
        'Establishment of Ja\'fari fiqh',
        'Training thousands of students',
        'Advancement of Islamic sciences',
      ],
      teachings: [
        'Ja\'fari jurisprudence',
        'Scientific knowledge',
        'Ethics and morality',
        'Spiritual purification',
      ],
      quizCount: 50,
    ),

    // 9. Imam Musa al-Kadhim (AS)
    Masoom(
      id: 'imam-musa-kadhim',
      name: 'Imam Musa al-Kadhim',
      arabicName: 'موسى الكاظم',
      title: 'The Restrained',
      arabicTitle: 'الكاظم',
      order: 9,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '745 CE',
      deathPlace: 'Baghdad (prison)',
      deathDate: '799 CE',
      shortBio: 'The seventh Imam, known for patience and restraint despite persecution and imprisonment.',
      notableEvents: [
        'Years of imprisonment',
        'Patience in adversity',
        'Spreading knowledge despite oppression',
      ],
      teachings: [
        'Patience and forbearance',
        'Controlling anger',
        'Trust in Allah',
        'Perseverance in faith',
      ],
      quizCount: 28,
    ),

    // 10. Imam Ali al-Ridha (AS)
    Masoom(
      id: 'imam-ali-ridha',
      name: 'Imam Ali al-Ridha',
      arabicName: 'علي الرضا',
      title: 'The Accepted One',
      arabicTitle: 'الرضا',
      order: 10,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '765 CE',
      deathPlace: 'Mashhad',
      deathDate: '818 CE',
      shortBio: 'The eighth Imam, known for interfaith dialogues and spreading Islamic knowledge.',
      notableEvents: [
        'Heir apparent to Abbasid Caliphate',
        'Debates with scholars of different faiths',
        'Journey to Khorasan',
      ],
      teachings: [
        'Interfaith dialogue',
        'Medical knowledge',
        'Rights and responsibilities',
        'True leadership',
      ],
      quizCount: 32,
    ),

    // 11. Imam Muhammad al-Jawad (AS)
    Masoom(
      id: 'imam-muhammad-jawad',
      name: 'Imam Muhammad al-Jawad',
      arabicName: 'محمد الجواد',
      title: 'The Generous',
      arabicTitle: 'الجواد',
      order: 11,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '811 CE',
      deathPlace: 'Baghdad',
      deathDate: '835 CE',
      shortBio: 'The ninth Imam, who became Imam at young age, displaying divine knowledge and wisdom.',
      notableEvents: [
        'Imamate at young age',
        'Debates demonstrating knowledge',
        'Guidance to community',
      ],
      teachings: [
        'Knowledge transcends age',
        'Divine appointment',
        'Patience with adversity',
        'Generosity and kindness',
      ],
      quizCount: 22,
    ),

    // 12. Imam Ali al-Hadi (AS)
    Masoom(
      id: 'imam-ali-hadi',
      name: 'Imam Ali al-Hadi',
      arabicName: 'علي الهادي',
      title: 'The Guide',
      arabicTitle: 'النقي',
      order: 12,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '828 CE',
      deathPlace: 'Samarra',
      deathDate: '868 CE',
      shortBio: 'The tenth Imam, who guided the community during difficult times under Abbasid surveillance.',
      notableEvents: [
        'Life under surveillance in Samarra',
        'Guidance through representatives',
        'Preserving Islamic teachings',
      ],
      teachings: [
        'Faith in hardship',
        'Leadership under oppression',
        'Maintaining community',
        'Patience and wisdom',
      ],
      quizCount: 25,
    ),

    // 13. Imam Hassan al-Askari (AS)
    Masoom(
      id: 'imam-hassan-askari',
      name: 'Imam Hassan al-Askari',
      arabicName: 'الحسن العسكري',
      title: 'The Soldier',
      arabicTitle: 'العسكري',
      order: 13,
      imageUrl: '',
      birthPlace: 'Medina',
      birthDate: '846 CE',
      deathPlace: 'Samarra',
      deathDate: '874 CE',
      shortBio: 'The eleventh Imam, father of Imam Mahdi, lived under severe restrictions.',
      notableEvents: [
        'Life under house arrest',
        'Birth of Imam Mahdi',
        'Guidance through trusted representatives',
      ],
      teachings: [
        'Faith under restriction',
        'Preparation for occultation',
        'Trust in Allah\'s plan',
        'Community guidance',
      ],
      quizCount: 20,
    ),

    // 14. Imam Muhammad al-Mahdi (AS)
    Masoom(
      id: 'imam-mahdi',
      name: 'Imam Muhammad al-Mahdi',
      arabicName: 'محمد المهدي',
      title: 'The Awaited One',
      arabicTitle: 'صاحب الزمان',
      order: 14,
      imageUrl: '',
      birthPlace: 'Samarra',
      birthDate: '869 CE',
      deathPlace: null,
      deathDate: null,
      shortBio: 'The twelfth Imam, currently in occultation, awaited to establish justice across the world.',
      notableEvents: [
        'Birth in secrecy',
        'Minor Occultation (874-941 CE)',
        'Major Occultation (941 CE - present)',
        'Awaited reappearance',
      ],
      teachings: [
        'Patience in waiting',
        'Preparation for return',
        'Justice and equity',
        'Hope and anticipation',
      ],
      quizCount: 30,
    ),
  ];

  static Masoom? getById(String id) {
    try {
      return all.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Masoom> getByIds(List<String> ids) {
    return all.where((m) => ids.contains(m.id)).toList();
  }
}
