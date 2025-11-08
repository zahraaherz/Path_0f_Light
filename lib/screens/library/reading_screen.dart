import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/library/book_models.dart';
import '../../providers/book_providers.dart';

class ReadingScreen extends ConsumerStatefulWidget {
  final String bookId;
  final String sectionId;

  const ReadingScreen({
    super.key,
    required this.bookId,
    required this.sectionId,
  });

  @override
  ConsumerState<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends ConsumerState<ReadingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paragraphsAsync = ref.watch(sectionParagraphsProvider(widget.sectionId));

    return Scaffold(
      appBar: AppBar(
        title: paragraphsAsync.when(
          data: (paragraphs) => Text('Page ${_currentPage + 1} of ${paragraphs.length}'),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Error'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => _showParagraphList(context),
            tooltip: 'Jump to paragraph',
          ),
        ],
      ),
      body: paragraphsAsync.when(
        data: (paragraphs) {
          if (paragraphs.isEmpty) {
            return const Center(
              child: Text('No content available'),
            );
          }

          // Initialize reading session
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (ref.read(readingSessionProvider) == null) {
              ref.read(readingSessionProvider.notifier).startSession(
                    bookId: widget.bookId,
                    sectionId: widget.sectionId,
                    paragraphs: paragraphs,
                    startIndex: _currentPage,
                  );
            }
          });

          return Column(
            children: [
              // Progress Bar
              LinearProgressIndicator(
                value: ((_currentPage + 1) / paragraphs.length),
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
              ),

              // Reading Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: paragraphs.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    ref.read(readingSessionProvider.notifier).jumpToParagraph(index);
                  },
                  itemBuilder: (context, index) {
                    final paragraph = paragraphs[index];
                    return ParagraphView(paragraph: paragraph);
                  },
                ),
              ),

              // Navigation Controls
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous Button
                    ElevatedButton.icon(
                      onPressed: _currentPage > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Previous'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryTeal,
                        foregroundColor: Colors.white,
                      ),
                    ),

                    // Page Indicator
                    Text(
                      '${_currentPage + 1} / ${paragraphs.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    // Next Button
                    ElevatedButton.icon(
                      onPressed: _currentPage < paragraphs.length - 1
                          ? () async {
                              // Mark current as read before moving
                              await ref.read(readingSessionProvider.notifier).nextParagraph();

                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.islamicGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
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
                'Failed to load content',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(sectionParagraphsProvider(widget.sectionId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showParagraphList(BuildContext context) {
    final paragraphsAsync = ref.read(sectionParagraphsProvider(widget.sectionId));

    paragraphsAsync.whenData((paragraphs) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemCount: paragraphs.length,
            itemBuilder: (context, index) {
              final paragraph = paragraphs[index];
              final isCurrentPage = index == _currentPage;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isCurrentPage
                      ? AppTheme.primaryTeal
                      : Colors.grey[300],
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isCurrentPage ? Colors.white : Colors.black,
                      fontWeight:
                          isCurrentPage ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                title: Text(
                  paragraph.content.textEn ?? paragraph.content.textAr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('Page ${paragraph.pageNumber}'),
                trailing: isCurrentPage
                    ? const Icon(Icons.visibility, color: AppTheme.primaryTeal)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              );
            },
          );
        },
      );
    });
  }
}

class ParagraphView extends StatelessWidget {
  final Paragraph paragraph;

  const ParagraphView({super.key, required this.paragraph});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Paragraph Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu_book, size: 20, color: AppTheme.primaryTeal),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paragraph.sectionTitleEn ?? paragraph.sectionTitleAr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Page ${paragraph.pageNumber} · Paragraph ${paragraph.paragraphNumber}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(paragraph.metadata.difficulty),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    paragraph.metadata.difficulty.displayName,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Arabic Text
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.islamicGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.islamicGreen.withOpacity(0.2),
              ),
            ),
            child: SelectableText(
              paragraph.content.textAr,
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 22,
                height: 2.0,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),

          // English Translation (if available)
          if (paragraph.content.textEn != null) ...[
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: SelectableText(
                paragraph.content.textEn!,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  color: Colors.black87,
                ),
              ),
            ),
          ],

          // Entities (if available)
          if (paragraph.entities.people.isNotEmpty ||
              paragraph.entities.places.isNotEmpty ||
              paragraph.entities.events.isNotEmpty) ...[
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Key References',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            if (paragraph.entities.people.isNotEmpty)
              _EntitySection(
                icon: Icons.person,
                title: 'People',
                items: paragraph.entities.people,
                color: AppTheme.primaryTeal,
              ),
            if (paragraph.entities.places.isNotEmpty)
              _EntitySection(
                icon: Icons.place,
                title: 'Places',
                items: paragraph.entities.places,
                color: AppTheme.islamicGreen,
              ),
            if (paragraph.entities.events.isNotEmpty)
              _EntitySection(
                icon: Icons.event,
                title: 'Events',
                items: paragraph.entities.events,
                color: AppTheme.goldAccent,
              ),
          ],

          const SizedBox(height: 32),
        ],
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

class _EntitySection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;
  final Color color;

  const _EntitySection({
    required this.icon,
    required this.title,
    required this.items,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
