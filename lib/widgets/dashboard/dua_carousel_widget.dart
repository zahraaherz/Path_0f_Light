import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/language_providers.dart';

class DuaItem {
  final String titleEn;
  final String titleAr;
  final String textAr;
  final String translationEn;
  final String transliterationEn;
  final String benefit;

  const DuaItem({
    required this.titleEn,
    required this.titleAr,
    required this.textAr,
    required this.translationEn,
    required this.transliterationEn,
    required this.benefit,
  });
}

// Sample Du'as
final sampleDuas = [
  DuaItem(
    titleEn: 'Morning Dhikr',
    titleAr: 'أذكار الصباح',
    textAr: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
    translationEn: 'In the name of Allah, the Most Gracious, the Most Merciful',
    transliterationEn: 'Bismillah ar-Rahman ar-Rahim',
    benefit: 'Seeking Allah\'s blessings for the day',
  ),
  DuaItem(
    titleEn: 'Du\'a for Knowledge',
    titleAr: 'دعاء طلب العلم',
    textAr: 'رَبِّ زِدْنِي عِلْمًا',
    translationEn: 'My Lord, increase me in knowledge',
    transliterationEn: 'Rabbi zidni ilma',
    benefit: 'Seeking increase in knowledge and wisdom',
  ),
  DuaItem(
    titleEn: 'Du\'a for Protection',
    titleAr: 'دعاء الحفظ',
    textAr: 'اللَّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ وَمِنْ خَلْفِي',
    translationEn: 'O Allah, protect me from before me and from behind me',
    transliterationEn: 'Allahumma ihfazni min bayni yadayya wa min khalfi',
    benefit: 'Seeking Allah\'s protection from all directions',
  ),
  DuaItem(
    titleEn: 'Du\'a for Patience',
    titleAr: 'دعاء الصبر',
    textAr: 'رَبَّنَا أَفْرِغْ عَلَيْنَا صَبْرًا وَتَوَفَّنَا مُسْلِمِينَ',
    translationEn: 'Our Lord, pour upon us patience and let us die as Muslims',
    transliterationEn: 'Rabbana afrigh \'alayna sabran wa tawaffana muslimin',
    benefit: 'Seeking patience and steadfastness in faith',
  ),
];

class DuaCarouselWidget extends ConsumerStatefulWidget {
  const DuaCarouselWidget({super.key});

  @override
  ConsumerState<DuaCarouselWidget> createState() => _DuaCarouselWidgetState();
}

class _DuaCarouselWidgetState extends ConsumerState<DuaCarouselWidget> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRTL = ref.watch(isRTLProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.goldAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: AppTheme.goldAccent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.dailyDua,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.goldAccent,
                        ),
                  ),
                ),
              ],
            ),
          ),

          // Du'a Carousel
          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: sampleDuas.length,
              itemBuilder: (context, index) {
                final dua = sampleDuas[index];
                return _buildDuaCard(context, dua, isRTL);
              },
            ),
          ),

          // Page Indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                sampleDuas.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppTheme.goldAccent
                        : AppTheme.goldAccent.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDuaCard(BuildContext context, DuaItem dua, bool isRTL) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.goldAccent.withOpacity(0.1),
              AppTheme.islamicGreen.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              isRTL ? dua.titleAr : dua.titleEn,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.goldAccent,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Arabic Text
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                dua.textAr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 2.0,
                      fontSize: 20,
                    ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 12),

            // Translation
            Text(
              dua.translationEn,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Transliteration
            Text(
              dua.transliterationEn,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),

            // Benefit
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.islamicGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: AppTheme.islamicGreen,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      dua.benefit,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.islamicGreen,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
