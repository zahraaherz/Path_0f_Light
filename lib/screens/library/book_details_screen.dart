import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/library/book_models.dart';
import '../../providers/book_providers.dart';
import 'reading_screen.dart';

class BookDetailsScreen extends ConsumerWidget {
  final String bookId;

  const BookDetailsScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookDetailsAsync = ref.watch(bookDetailsProvider(bookId));
    final readingProgress = ref.watch(readingProgressProvider(bookId));

    return Scaffold(
      body: bookDetailsAsync.when(
        data: (data) {
          final book = data['book'] as Book;
          final sections = data['sections'] as List<BookSection>;

          return CustomScrollView(
            slivers: [
              // App Bar with Book Info
              SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    book.titleEn,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3.0,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.islamicGreen, AppTheme.primaryTeal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        const Icon(
                          Icons.menu_book,
                          size: 80,
                          color: AppTheme.goldAccent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          book.authorEn,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Book Information
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Arabic Title
                          Text(
                            book.titleAr,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontFamily: 'Amiri',
                                  fontWeight: FontWeight.bold,
                                ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            book.authorAr,
                            style: const TextStyle(
                              fontFamily: 'Amiri',
                              color: AppTheme.textSecondary,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const Divider(height: 32),

                          // Stats
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _InfoItem(
                                icon: Icons.folder,
                                label: 'Sections',
                                value: '${book.totalSections}',
                              ),
                              _InfoItem(
                                icon: Icons.article,
                                label: 'Paragraphs',
                                value: '${book.totalParagraphs}',
                              ),
                              _InfoItem(
                                icon: Icons.language,
                                label: 'Language',
                                value: book.language.toUpperCase(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Reading Progress
              if (readingProgress.value != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      color: AppTheme.info.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.auto_stories, color: AppTheme.info),
                                const SizedBox(width: 8),
                                Text(
                                  'Reading Progress',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: readingProgress.value!.progress,
                              minHeight: 8,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.info),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${(readingProgress.value!.progress * 100).toStringAsFixed(1)}% complete',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // Sections Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Sections',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),

              // Sections List
              if (sections.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text('No sections available yet'),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final section = sections[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SectionCard(
                            section: section,
                            bookId: bookId,
                          ),
                        );
                      },
                      childCount: sections.length,
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppTheme.error),
              const SizedBox(height: 16),
              Text(
                'Failed to load book details',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(bookDetailsProvider(bookId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionCard extends ConsumerWidget {
  final BookSection section;
  final String bookId;

  const SectionCard({
    super.key,
    required this.section,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficultyColor = _getDifficultyColor(section.difficultyLevel);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ReadingScreen(
                bookId: bookId,
                sectionId: section.id,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Number & Difficulty
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Section ${section.sectionNumber}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryTeal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: difficultyColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.signal_cellular_alt, size: 14, color: difficultyColor),
                        const SizedBox(width: 4),
                        Text(
                          section.difficultyLevel.displayName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: difficultyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                section.titleEn,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),

              // Arabic Title
              Text(
                section.titleAr,
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  color: AppTheme.textSecondary,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 12),

              // Topics & Info
              Row(
                children: [
                  Icon(Icons.article, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '${section.paragraphCount} paragraphs',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  if (section.pageRange != null) ...[
                    const SizedBox(width: 16),
                    Icon(Icons.menu_book, size: 16, color: AppTheme.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      'Pages ${section.pageRange}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),

              // Topics
              if (section.topics.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: section.topics.take(3).map((topic) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.islamicGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        topic,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.islamicGreen,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.basic:
        return AppTheme.success;
      case DifficultyLevel.intermediate:
        return AppTheme.info;
      case DifficultyLevel.advanced:
        return AppTheme.warning;
      case DifficultyLevel.expert:
        return AppTheme.error;
    }
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryTeal, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryTeal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
