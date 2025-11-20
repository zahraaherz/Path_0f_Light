import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../models/library/book.dart';
import '../../models/library/paragraph.dart';
import '../../repositories/library_repository.dart';
import 'book_reader_screen.dart';
import '../../utils/responsive.dart';
import '../../l10n/app_localizations.dart';

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
          _errorMessage = AppLocalizations.of(context)!.bookNotFound;
        });
        return;
      }

      // Load all paragraphs for the book
      final paragraphs = await _libraryRepository.getBookParagraphs(widget.bookId);

      if (paragraphs.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage = AppLocalizations.of(context)!.noContentAvailable;
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
        _errorMessage = '${AppLocalizations.of(context)!.failedToLoadBook}: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookTitle ?? AppLocalizations.of(context)!.loadingBook),
        backgroundColor: AppTheme.primaryTeal,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: r.fontLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final r = context.responsive;
    if (_isLoading) {
      return _buildLoadingState(r);
    }

    if (_errorMessage != null) {
      return _buildErrorState(r);
    }

    // This should rarely be shown as we navigate away immediately
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadingState(Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Islamic pattern decoration
          Container(
            width: r.iconXLarge * 2,
            height: r.iconXLarge * 2,
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
          SizedBox(height: r.spaceLarge + 8),

          // Loading text
          Text(
            AppLocalizations.of(context)!.openingBook,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTeal,
                ),
          ),
          SizedBox(height: r.paddingSmall),

          Text(
            widget.bookTitle ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spaceLarge),

          // Progress steps
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.paddingLarge + 16),
            child: Column(
              children: [
                _buildLoadingStep(
                  r,
                  AppLocalizations.of(context)!.loadingBookInfo,
                  _book != null,
                ),
                SizedBox(height: r.paddingSmall),
                _buildLoadingStep(
                  r,
                  AppLocalizations.of(context)!.loadingContent,
                  _paragraphs != null,
                ),
                SizedBox(height: r.paddingSmall),
                _buildLoadingStep(
                  r,
                  AppLocalizations.of(context)!.preparingReader,
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingStep(Responsive r, String text, bool completed) {
    return Row(
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.circle_outlined,
          color: completed ? AppTheme.success : AppTheme.textSecondary,
          size: r.iconSmall,
        ),
        SizedBox(width: r.paddingSmall),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: completed ? AppTheme.success : AppTheme.textSecondary,
              fontSize: r.fontMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(Responsive r) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon
            Container(
              width: r.iconXLarge + 36,
              height: r.iconXLarge + 36,
              decoration: BoxDecoration(
                color: AppTheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: r.iconXLarge,
                color: AppTheme.error,
              ),
            ),
            SizedBox(height: r.spaceLarge),

            // Error title
            Text(
              AppLocalizations.of(context)!.unableToLoadBook,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.error,
                  ),
            ),
            SizedBox(height: r.paddingSmall),

            // Error message
            Text(
              _errorMessage ?? AppLocalizations.of(context)!.unknownError,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.spaceLarge + 8),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(AppLocalizations.of(context)!.goBack),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryTeal,
                    side: const BorderSide(color: AppTheme.primaryTeal),
                  ),
                ),
                SizedBox(width: r.spaceMedium),
                ElevatedButton.icon(
                  onPressed: _loadBookContent,
                  icon: const Icon(Icons.refresh),
                  label: Text(AppLocalizations.of(context)!.retry),
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
