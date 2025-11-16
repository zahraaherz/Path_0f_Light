import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/library/book.dart';
import '../../models/library/paragraph.dart';
import '../../repositories/library_repository.dart';
import 'book_reader_screen.dart';

/// Screen for loading book content and navigating to the reader
class BookReadingScreen extends ConsumerStatefulWidget {
  final String bookId;
  final String? bookTitle;
  final int? startParagraphIndex;

  const BookReadingScreen({
    Key? key,
    required this.bookId,
    this.bookTitle,
    this.startParagraphIndex,
  }) : super(key: key);

  @override
  ConsumerState<BookReadingScreen> createState() => _BookReadingScreenState();
}

class _BookReadingScreenState extends ConsumerState<BookReadingScreen> {
  final LibraryRepository _libraryRepository = LibraryRepository();

  bool _isLoading = true;
  String? _errorMessage;
  Book? _book;
  List<Paragraph>? _paragraphs;

  @override
  void initState() {
    super.initState();
    _loadBookContent();
  }

  Future<void> _loadBookContent() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Load book data
      final book = await _libraryRepository.getBook(widget.bookId);

      if (book == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Book not found';
        });
        return;
      }

      // Load all paragraphs for the book
      final paragraphs = await _libraryRepository.getBookParagraphs(widget.bookId);

      if (paragraphs.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'No content available for this book yet';
        });
        return;
      }

      setState(() {
        _book = book;
        _paragraphs = paragraphs;
        _isLoading = false;
      });

      // Navigate to reader after content is loaded
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BookReaderScreen(
              book: book,
              paragraphs: paragraphs,
              startParagraphIndex: widget.startParagraphIndex,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load book: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookTitle ?? 'Loading Book...'),
        backgroundColor: AppTheme.primaryTeal,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    // This should rarely be shown as we navigate away immediately
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Islamic pattern decoration
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryTeal.withOpacity(0.2),
                  AppTheme.islamicGreen.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Loading text
          Text(
            'Opening Book...',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTeal,
                ),
          ),
          const SizedBox(height: 12),

          Text(
            widget.bookTitle ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Progress steps
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                _buildLoadingStep(
                  'Loading book information',
                  _book != null,
                ),
                const SizedBox(height: 12),
                _buildLoadingStep(
                  'Loading content',
                  _paragraphs != null,
                ),
                const SizedBox(height: 12),
                _buildLoadingStep(
                  'Preparing reader',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingStep(String text, bool completed) {
    return Row(
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.circle_outlined,
          color: completed ? AppTheme.success : AppTheme.textSecondary,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: completed ? AppTheme.success : AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 60,
                color: AppTheme.error,
              ),
            ),
            const SizedBox(height: 24),

            // Error title
            Text(
              'Unable to Load Book',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.error,
                  ),
            ),
            const SizedBox(height: 12),

            // Error message
            Text(
              _errorMessage ?? 'An unknown error occurred',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Go Back'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryTeal,
                    side: const BorderSide(color: AppTheme.primaryTeal),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _loadBookContent,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTeal,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
