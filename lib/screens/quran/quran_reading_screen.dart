import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../models/quran/quran_verse.dart';
import '../../providers/quran_providers.dart';
import '../../utils/responsive.dart';

/// Quran Reading Screen - Display verses of a Surah
class QuranReadingScreen extends ConsumerStatefulWidget {
  final int surahNumber;

  const QuranReadingScreen({
    Key? key,
    required this.surahNumber,
  }) : super(key: key);

  @override
  ConsumerState<QuranReadingScreen> createState() => _QuranReadingScreenState();
}

class _QuranReadingScreenState extends ConsumerState<QuranReadingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
    final surahAsync = ref.watch(surahProvider(widget.surahNumber));
    final versesAsync = ref.watch(surahVersesProvider(widget.surahNumber));

    return Scaffold(
      appBar: AppBar(
        title: surahAsync.when(
          data: (surah) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? surah?.arabicName ?? ''
                    : surah?.englishName ?? '',
              ),
              if (surah != null)
                Text(
                  l10n.totalVerses(surah.numberOfVerses),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                ),
            ],
          ),
          loading: () => Text(l10n.loading),
          error: (_, __) => Text(l10n.error),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsSheet(context),
            tooltip: l10n.settings,
          ),
        ],
      ),
      body: versesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: r.spaceMedium),
              Text('${l10n.error}: $error'),
              SizedBox(height: r.spaceMedium),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(surahVersesProvider(widget.surahNumber));
                },
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (verses) {
          if (verses.isEmpty) {
            return Center(
              child: Text(l10n.noVersesFound),
            );
          }

          return _buildVersesList(verses, l10n, r);
        },
      ),
    );
  }

  Widget _buildVersesList(
    List<QuranVerse> verses,
    AppLocalizations l10n,
    Responsive r,
  ) {
    final surah = ref.watch(surahProvider(widget.surahNumber)).value;
    final showTransliteration = ref.watch(showTransliterationProvider);
    final showTranslation = ref.watch(showTranslationProvider);
    final showTafsir = ref.watch(showTafsirProvider);

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(r.paddingMedium),
      itemCount: verses.length + 1, // +1 for Bismillah header
      itemBuilder: (context, index) {
        if (index == 0) {
          // Bismillah header (except for At-Tawbah which is surah 9)
          if (widget.surahNumber == 9) {
            return const SizedBox.shrink();
          }

          return _buildBismillahHeader(surah, l10n, r);
        }

        final verse = verses[index - 1];
        return _buildVerseCard(
          verse,
          showTransliteration,
          showTranslation,
          showTafsir,
          l10n,
          r,
        );
      },
    );
  }

  Widget _buildBismillahHeader(
    Surah? surah,
    AppLocalizations l10n,
    Responsive r,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: r.spaceLarge),
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.islamicGreen.withOpacity(0.1),
            AppTheme.primaryTeal.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
        border: Border.all(
          color: AppTheme.islamicGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (surah != null) ...[
            Text(
              surah.arabicName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.islamicGreen,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: r.spaceSmall),
            Text(
              '${surah.englishName} (${surah.englishNameTranslation})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.spaceSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  label: Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? surah.revelationType.displayNameAr
                        : surah.revelationType.displayName,
                  ),
                  backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
                ),
                SizedBox(width: r.spaceSmall),
                Chip(
                  label: Text(l10n.totalVerses(surah.numberOfVerses)),
                  backgroundColor: AppTheme.islamicGreen.withOpacity(0.1),
                ),
              ],
            ),
            SizedBox(height: r.spaceMedium),
            const Divider(),
            SizedBox(height: r.spaceSmall),
          ],
          Text(
            'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.islamicGreen,
                  fontWeight: FontWeight.w600,
                  height: 2.0,
                ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: r.spaceSmall),
          Text(
            l10n.bismillahArRahmanArRahim,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerseCard(
    QuranVerse verse,
    bool showTransliteration,
    bool showTranslation,
    bool showTafsir,
    AppLocalizations l10n,
    Responsive r,
  ) {
    final arabicFontSize = ref.watch(quranArabicFontSizeProvider);
    final translationFontSize = ref.watch(quranTranslationFontSizeProvider);

    return Card(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Verse number badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryTeal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.verseNumber(verse.number),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                if (verse.hasSajda) ...[
                  SizedBox(width: r.spaceSmall),
                  const Icon(
                    Icons.accessibility_new,
                    color: AppTheme.goldAccent,
                    size: 20,
                  ),
                ],
                const Spacer(),
                // Actions menu
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.bookmark_border, size: 20),
                          SizedBox(width: r.spaceSmall),
                          Text(l10n.bookmark),
                        ],
                      ),
                      onTap: () {
                        // TODO: Implement bookmark
                      },
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.share, size: 20),
                          SizedBox(width: r.spaceSmall),
                          Text(l10n.share),
                        ],
                      ),
                      onTap: () {
                        // TODO: Implement share
                      },
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: r.spaceMedium),

            // Arabic text
            Container(
              padding: EdgeInsets.all(r.paddingMedium),
              decoration: BoxDecoration(
                color: AppTheme.islamicGreen.withOpacity(0.05),
                borderRadius: BorderRadius.circular(r.radiusSmall),
              ),
              child: Text(
                verse.arabicText,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: arabicFontSize,
                      height: 2.0,
                      color: AppTheme.islamicGreen,
                    ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),

            // Transliteration
            if (showTransliteration && verse.transliteration != null) ...[
              SizedBox(height: r.spaceMedium),
              Text(
                l10n.transliteration,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryTeal,
                    ),
              ),
              SizedBox(height: r.spaceSmall),
              Text(
                verse.transliteration!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: translationFontSize,
                    ),
              ),
            ],

            // Translation
            if (showTranslation && verse.englishTranslation != null) ...[
              SizedBox(height: r.spaceMedium),
              Text(
                l10n.translation,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryTeal,
                    ),
              ),
              SizedBox(height: r.spaceSmall),
              Text(
                verse.englishTranslation!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: translationFontSize,
                      height: 1.6,
                    ),
              ),
            ],

            // Tafsir
            if (showTafsir && verse.tafsir != null) ...[
              SizedBox(height: r.spaceMedium),
              Text(
                l10n.tafsir,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldAccent,
                    ),
              ),
              SizedBox(height: r.spaceSmall),
              Container(
                padding: EdgeInsets.all(r.paddingSmall),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(r.radiusSmall),
                  border: Border.all(
                    color: AppTheme.goldAccent.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  verse.tafsir!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSettingsSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settings,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: r.spaceMedium),

            // Arabic font size
            Text(
              '${l10n.arabicText} ${l10n.fontSize}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Consumer(
              builder: (context, ref, _) {
                final fontSize = ref.watch(quranArabicFontSizeProvider);
                return Slider(
                  value: fontSize,
                  min: 18.0,
                  max: 36.0,
                  divisions: 9,
                  label: fontSize.round().toString(),
                  onChanged: (value) {
                    ref.read(quranArabicFontSizeProvider.notifier).state = value;
                  },
                );
              },
            ),
            SizedBox(height: r.spaceSmall),

            // Translation font size
            Text(
              '${l10n.translation} ${l10n.fontSize}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Consumer(
              builder: (context, ref, _) {
                final fontSize = ref.watch(quranTranslationFontSizeProvider);
                return Slider(
                  value: fontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 12,
                  label: fontSize.round().toString(),
                  onChanged: (value) {
                    ref.read(quranTranslationFontSizeProvider.notifier).state = value;
                  },
                );
              },
            ),
            SizedBox(height: r.spaceMedium),

            // Display options
            Text(
              l10n.display,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: r.spaceSmall),

            Consumer(
              builder: (context, ref, _) {
                return SwitchListTile(
                  title: Text(l10n.transliteration),
                  value: ref.watch(showTransliterationProvider),
                  onChanged: (value) {
                    ref.read(showTransliterationProvider.notifier).state = value;
                  },
                );
              },
            ),

            Consumer(
              builder: (context, ref, _) {
                return SwitchListTile(
                  title: Text(l10n.translation),
                  value: ref.watch(showTranslationProvider),
                  onChanged: (value) {
                    ref.read(showTranslationProvider.notifier).state = value;
                  },
                );
              },
            ),

            Consumer(
              builder: (context, ref, _) {
                return SwitchListTile(
                  title: Text(l10n.tafsir),
                  value: ref.watch(showTafsirProvider),
                  onChanged: (value) {
                    ref.read(showTafsirProvider.notifier).state = value;
                  },
                );
              },
            ),

            SizedBox(height: r.spaceMedium),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
