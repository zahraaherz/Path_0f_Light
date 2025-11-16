import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/library/book.dart';
import '../../repositories/library_repository.dart';

/// Screen for reading a book's content
class BookReadingScreen extends ConsumerStatefulWidget {
  final String bookId;
  final String? bookTitle;

  const BookReadingScreen({
    Key? key,
    required this.bookId,
    this.bookTitle,
  }) : super(key: key);

  @override
  ConsumerState<BookReadingScreen> createState() => _BookReadingScreenState();
}

class _BookReadingScreenState extends ConsumerState<BookReadingScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isArabic = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For now, we'll create a provider inline. In production, this should be in providers file
    final libraryRepository = LibraryRepository();
    final bookFuture = libraryRepository.getBook(widget.bookId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookTitle ?? 'Reading'),
        actions: [
          // Language toggle
          IconButton(
            icon: Icon(_isArabic ? Icons.translate : Icons.language),
            onPressed: () {
              setState(() {
                _isArabic = !_isArabic;
              });
            },
            tooltip: _isArabic ? 'Show English' : 'Show Arabic',
          ),
          // Font size controls
          PopupMenuButton<String>(
            icon: const Icon(Icons.text_fields),
            onSelected: (value) {
              // TODO: Implement font size adjustment
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Font size: $value')),
              );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'small', child: Text('Small')),
              const PopupMenuItem(value: 'medium', child: Text('Medium')),
              const PopupMenuItem(value: 'large', child: Text('Large')),
            ],
          ),
        ],
      ),
      body: FutureBuilder<Book>(
        future: bookFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: AppTheme.error),
                  const SizedBox(height: 16),
                  Text(
                    'Unable to load book',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Book not found'));
          }

          final book = snapshot.data!;
          return _buildBookContent(context, book);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Scroll to top
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  Widget _buildBookContent(BuildContext context, Book book) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book header
          _buildBookHeader(context, book),
          const SizedBox(height: 24),

          // Book description
          if (book.description != null) ...[
            Text(
              book.description!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.6,
                  ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
          ],

          // Book sections (placeholder)
          _buildSectionsPlaceholder(context, book),
        ],
      ),
    );
  }

  Widget _buildBookHeader(BuildContext context, Book book) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryTeal.withOpacity(0.1),
            AppTheme.islamicGreen.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            _isArabic ? book.titleAr : book.titleEn,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTeal,
                ),
          ),
          const SizedBox(height: 8),

          // Author
          Row(
            children: [
              const Icon(Icons.person, size: 20, color: AppTheme.textSecondary),
              const SizedBox(width: 8),
              Text(
                _isArabic ? book.authorAr : book.authorEn,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Book stats
          Row(
            children: [
              _buildStat(
                context,
                Icons.menu_book,
                '${book.totalSections} Sections',
              ),
              const SizedBox(width: 16),
              _buildStat(
                context,
                Icons.article,
                '${book.totalParagraphs} Paragraphs',
              ),
              const SizedBox(width: 16),
              _buildStat(
                context,
                Icons.access_time,
                '${book.estimatedReadingTime} min',
              ),
            ],
          ),

          // Topics
          if (book.topics.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: book.topics.map((topic) {
                return Chip(
                  label: Text(topic),
                  backgroundColor: AppTheme.primaryTeal.withOpacity(0.1),
                  labelStyle: const TextStyle(
                    color: AppTheme.primaryTeal,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppTheme.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildSectionsPlaceholder(BuildContext context, Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content Loading...',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.info.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              const Icon(Icons.construction, size: 48, color: AppTheme.info),
              const SizedBox(height: 12),
              Text(
                'Book Content Coming Soon',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.info,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'The full book reading experience with sections, paragraphs, and interactive features will be available soon.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (book.pdfUrl != null)
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('PDF viewer coming soon'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Open PDF'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTeal,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
