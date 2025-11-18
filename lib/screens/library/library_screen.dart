import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/theme/app_theme.dart';
import '../../models/library/book.dart';
import '../../providers/library_providers.dart';
import '../../providers/auth_providers.dart';
import 'book_reading_screen.dart';
import '../auth/login_screen.dart';
import '../../utils/responsive.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isGridView = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
    final booksAsync = ref.watch(publishedBooksProvider);
    final authUser = ref.watch(currentAuthUserProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Library',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: AppTheme.primaryTeal,
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view, color: Colors.white),
            onPressed: () {
              setState(() => _isGridView = !_isGridView);
            },
            tooltip: _isGridView ? 'List View' : 'Grid View',
          ),
          // Login button if not authenticated
          if (authUser == null)
            IconButton(
              icon: Icon(Icons.login, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              tooltip: l10n.signInTooltip,
            ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(r.paddingMedium),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchBooks,
                prefixIcon: Icon(Icons.search, color: AppTheme.primaryTeal),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: AppTheme.textSecondary),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium),
                  borderSide: BorderSide(color: AppTheme.primaryTeal.withValues(alpha:0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(r.radiusMedium),
                  borderSide: BorderSide(color: AppTheme.primaryTeal, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value.toLowerCase());
              },
            ),
          ),

          // Books list/grid
          Expanded(
            child: booksAsync.when(
              data: (books) {
                // Filter books by search query
                final filteredBooks = books.where((book) {
                  if (_searchQuery.isEmpty) return true;
                  return book.titleAr.toLowerCase().contains(_searchQuery) ||
                      book.titleEn.toLowerCase().contains(_searchQuery) ||
                      book.authorAr.toLowerCase().contains(_searchQuery) ||
                      book.authorEn.toLowerCase().contains(_searchQuery);
                }).toList();

                if (filteredBooks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchQuery.isEmpty
                              ? Icons.menu_book
                              : Icons.search_off,
                          size: r.iconLarge * 2,
                          color: AppTheme.textSecondary.withValues(alpha:0.5),
                        ),
                        SizedBox(height: r.spaceMedium),
                        Text(
                          _searchQuery.isEmpty
                              ? 'No books available'
                              : 'No books found',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(publishedBooksProvider);
                  },
                  child: _isGridView
                      ? _buildGridView(filteredBooks)
                      : _buildListView(filteredBooks),
                );
              },
              loading: () => Center(
                    child: CircularProgressIndicator(color: AppTheme.primaryTeal),
                  ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: r.iconLarge * 1.5, color: AppTheme.error),
                    SizedBox(height: r.spaceMedium),
                    Text(
                      l10n.failedToLoadBooks,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                    ),
                    SizedBox(height: r.spaceSmall),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(publishedBooksProvider);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryTeal,
                      ),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Book> books) {
    final r = context.responsive;
    return GridView.builder(
      padding: EdgeInsets.all(r.paddingMedium),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: r.spaceMedium,
        mainAxisSpacing: r.spaceMedium,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _BookGridCard(book: books[index]);
      },
    );
  }

  Widget _buildListView(List<Book> books) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _BookListCard(book: books[index]);
      },
    );
  }
}

class _BookGridCard extends ConsumerWidget {
  final Book book;

  const _BookGridCard({required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _openBook(context, ref),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Book cover
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: book.coverImageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: book.coverImageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppTheme.primaryTeal.withValues(alpha:0.1),
                          child: Center(
                            child: CircularProgressIndicator(color: AppTheme.primaryTeal),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppTheme.primaryTeal.withValues(alpha:0.1),
                          child: Icon(Icons.menu_book, size: 48, color: AppTheme.primaryTeal),
                        ),
                      )
                    : Container(
                        color: AppTheme.primaryTeal.withValues(alpha:0.1),
                        child: Icon(Icons.menu_book, size: 48, color: AppTheme.primaryTeal),
                      ),
              ),
            ),

            // Book info
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.titleAr,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book.authorAr,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),

                    // Reading progress (if available)
                    _buildProgressIndicator(ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(WidgetRef ref) {
    final progressAsync = ref.watch(readingProgressProvider(book.id));

    return progressAsync.when(
      data: (progress) {
        if (progress == null || progress.progressPercentage == 0) {
          return const SizedBox.shrink();
        }
        return LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 4,
          percent: progress.progressPercentage / 100,
          backgroundColor: Colors.grey[300],
          progressColor: AppTheme.primaryTeal,
          barRadius: const Radius.circular(2),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _openBook(BuildContext context, WidgetRef ref) async {
    // Navigate to BookReadingScreen which will load paragraphs and then open reader
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookReadingScreen(
          bookId: book.id,
          bookTitle: book.titleAr,
        ),
      ),
    );
  }
}

class _BookListCard extends ConsumerWidget {
  final Book book;

  const _BookListCard({required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: book.coverImageUrl != null
              ? CachedNetworkImage(
                  imageUrl: book.coverImageUrl!,
                  width: 60,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 60,
                    height: 80,
                    color: AppTheme.primaryTeal.withValues(alpha:0.1),
                    child: Center(
                      child: CircularProgressIndicator(color: AppTheme.primaryTeal, strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 60,
                    height: 80,
                    color: AppTheme.primaryTeal.withValues(alpha:0.1),
                    child: Icon(Icons.menu_book, color: AppTheme.primaryTeal),
                  ),
                )
              : Container(
                  width: 60,
                  height: 80,
                  color: AppTheme.primaryTeal.withValues(alpha:0.1),
                  child: Icon(Icons.menu_book, color: AppTheme.primaryTeal),
                ),
        ),
        title: Text(
          book.titleAr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textDirection: TextDirection.rtl,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              book.authorAr,
              style: Theme.of(context).textTheme.bodyMedium,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 4),
            Text(
              '${book.totalParagraphs} paragraphs',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: AppTheme.primaryTeal),
        onTap: () {
          // Navigate to book reading screen which will load paragraphs
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookReadingScreen(
                bookId: book.id,
                bookTitle: book.titleAr,
              ),
            ),
          );
        },
      ),
    );
  }
}
