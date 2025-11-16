import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/dua/dua_model.dart';
import '../../data/mock_data.dart';

class DuaSliderWidget extends StatelessWidget {
  const DuaSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final duas = MockData.duaList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Du\'as',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'الأدعية اليومية',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Du'a slider
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: duas.length,
            itemBuilder: (context, index) {
              return _DuaCard(dua: duas[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _DuaCard extends StatelessWidget {
  final Dua dua;

  const _DuaCard({required this.dua});

  Color _getCategoryColor(DuaCategory category) {
    switch (category) {
      case DuaCategory.morning:
        return const Color(0xFFFFA500); // Orange
      case DuaCategory.evening:
        return const Color(0xFF6A5ACD); // Purple
      case DuaCategory.protection:
        return const Color(0xFF228B22); // Forest green
      case DuaCategory.knowledge:
        return AppTheme.primaryTeal;
      case DuaCategory.forgiveness:
        return const Color(0xFF8B0000); // Dark red
      default:
        return AppTheme.goldAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(dua.category);

    return GestureDetector(
      onTap: () => _showDuaDetail(context, dua),
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                dua.category.name.toUpperCase(),
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Arabic title
            Text(
              dua.arabicTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // English title
            Text(
              dua.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Short excerpt or arabic text
            Text(
              dua.shortExcerpt ?? dua.arabicText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            // Tap to view full
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tap to view full',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDuaDetail(BuildContext context, Dua dua) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DuaDetailSheet(dua: dua),
    );
  }
}

class _DuaDetailSheet extends StatelessWidget {
  final Dua dua;

  const _DuaDetailSheet({required this.dua});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Arabic title
                      Text(
                        dua.arabicTitle,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppTheme.islamicGreen,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),

                      // English title
                      Text(
                        dua.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),

                      const SizedBox(height: 24),

                      // Arabic text
                      _Section(
                        title: 'Arabic Text',
                        arabicTitle: 'النص العربي',
                        child: Text(
                          dua.arabicText,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppTheme.islamicGreen,
                                height: 2.0,
                                fontSize: 20,
                              ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Transliteration
                      _Section(
                        title: 'Transliteration',
                        arabicTitle: 'الكتابة بالحروف اللاتينية',
                        child: Text(
                          dua.transliteration,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontStyle: FontStyle.italic,
                                height: 1.6,
                              ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Translation
                      _Section(
                        title: 'Translation',
                        arabicTitle: 'الترجمة',
                        child: Text(
                          dua.translation,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                height: 1.6,
                              ),
                        ),
                      ),

                      if (dua.meaning != null) ...[
                        const SizedBox(height: 20),
                        _Section(
                          title: 'Meaning',
                          arabicTitle: 'المعنى',
                          child: Text(
                            dua.meaning!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.6,
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                        ),
                      ],

                      if (dua.tafsir != null) ...[
                        const SizedBox(height: 20),
                        _Section(
                          title: 'Tafsir',
                          arabicTitle: 'التفسير',
                          child: Text(
                            dua.tafsir!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.6,
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                        ),
                      ],

                      if (dua.benefits != null) ...[
                        const SizedBox(height: 20),
                        _Section(
                          title: 'Benefits',
                          arabicTitle: 'الفوائد',
                          child: Text(
                            dua.benefits!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  height: 1.6,
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                        ),
                      ],

                      if (dua.source != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.islamicGreen.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.source,
                                color: AppTheme.islamicGreen,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Source: ${dua.source}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.islamicGreen,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Audio button (if available)
                      if (dua.audioUrl != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Play audio
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Play Audio'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryTeal,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      // Favorite button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Toggle favorite
                          },
                          icon: Icon(
                            dua.isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                          label: Text(dua.isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryTeal,
                            side: const BorderSide(color: AppTheme.primaryTeal),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String arabicTitle;
  final Widget child;

  const _Section({
    required this.title,
    required this.arabicTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              arabicTitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
