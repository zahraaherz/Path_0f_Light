import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../models/library/book.dart';
import '../../models/library/paragraph.dart';
import '../../models/library/reading_models.dart';
import '../../providers/reading_providers.dart';
import '../../widgets/reading/paragraph_widget.dart';
import '../../widgets/reading/reading_settings_sheet.dart';
import '../../widgets/reading/table_of_contents_sheet.dart';
import '../../widgets/reading/bookmarks_list_sheet.dart';

class BookReaderScreen extends ConsumerStatefulWidget {
  final Book book;
  final List<Paragraph> paragraphs;
  final int? startParagraphIndex;

  const BookReaderScreen({
    Key? key,
    required this.book,
    required this.paragraphs,
    this.startParagraphIndex,
  }) : super(key: key);

  @override
  ConsumerState<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends ConsumerState<BookReaderScreen> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _positionsListener = ItemPositionsListener.create();

  int _currentParagraphIndex = 0;
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    _currentParagraphIndex = widget.startParagraphIndex ?? 0;

    // Listen to paragraph visibility changes
    _positionsListener.itemPositions.addListener(_onScrollPositionChanged);

    // Jump to start paragraph after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.startParagraphIndex != null) {
        _scrollController.jumpTo(index: widget.startParagraphIndex!);
      }
    });
  }

  void _onScrollPositionChanged() {
    final positions = _positionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      // Get the first visible paragraph
      final firstVisible = positions
          .where((position) => position.itemTrailingEdge > 0.3)
          .reduce((curr, next) =>
              curr.itemTrailingEdge < next.itemTrailingEdge ? curr : next);

      if (firstVisible.index != _currentParagraphIndex) {
        setState(() {
          _currentParagraphIndex = firstVisible.index;
        });

        // Save progress automatically
        _saveProgress();
      }
    }
  }

  Future<void> _saveProgress() async {
    if (_currentParagraphIndex >= widget.paragraphs.length) return;

    final paragraph = widget.paragraphs[_currentParagraphIndex];
    final saveProgress = ref.read(saveReadingProgressProvider);

    try {
      await saveProgress(
        bookId: widget.book.id,
        paragraphId: paragraph.id,
        sectionId: paragraph.sectionId,
        pageNumber: paragraph.pageNumber,
        totalPages: widget.book.totalParagraphs,
      );
    } catch (e) {
      print('Error saving progress: $e');
    }
  }

  void _showReadingSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ReadingSettingsSheet(),
    );
  }

  void _showTableOfContents() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TableOfContentsSheet(
        book: widget.book,
        paragraphs: widget.paragraphs,
        onSectionTap: (int paragraphIndex) {
          _scrollController.scrollTo(
            index: paragraphIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showBookmarks() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookmarksListSheet(
        bookId: widget.book.id,
        onBookmarkTap: (String paragraphId) {
          final index = widget.paragraphs.indexWhere((p) => p.id == paragraphId);
          if (index != -1) {
            _scrollController.scrollTo(
              index: index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _addBookmark() async {
    if (_currentParagraphIndex >= widget.paragraphs.length) return;

    final paragraph = widget.paragraphs[_currentParagraphIndex];
    final createBookmark = ref.read(createBookmarkProvider);

    try {
      await createBookmark(
        bookId: widget.book.id,
        paragraphId: paragraph.id,
        pageNumber: paragraph.pageNumber,
        sectionTitle: paragraph.sectionTitleAr,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bookmark added'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add bookmark: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _toggleAutoScroll() {
    final preferences = ref.read(readingPreferencesProvider);

    if (!_isAutoScrolling) {
      // Start auto-scroll
      setState(() => _isAutoScrolling = true);
      _autoScroll(preferences.scrollSpeed);
    } else {
      // Stop auto-scroll
      setState(() => _isAutoScrolling = false);
    }
  }

  void _autoScroll(double speed) async {
    if (!_isAutoScrolling) return;

    await Future.delayed(Duration(milliseconds: (1000 / speed).round()));

    if (!_isAutoScrolling || !mounted) return;

    // Scroll to next paragraph
    if (_currentParagraphIndex < widget.paragraphs.length - 1) {
      _scrollController.scrollTo(
        index: _currentParagraphIndex + 1,
        duration: Duration(milliseconds: (500 / speed).round()),
        curve: Curves.linear,
      );

      _autoScroll(speed); // Continue scrolling
    } else {
      setState(() => _isAutoScrolling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(readingPreferencesProvider);
    final progressPercentage = widget.paragraphs.isEmpty
        ? 0.0
        : (_currentParagraphIndex / widget.paragraphs.length) * 100;

    // Get background color from preferences
    final backgroundColor = _getBackgroundColor(preferences.backgroundColor);
    final textColor = _getTextColor(preferences.backgroundColor);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.book.titleAr,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border, color: textColor),
            onPressed: _addBookmark,
            tooltip: 'Add bookmark',
          ),
          IconButton(
            icon: Icon(Icons.bookmarks_outlined, color: textColor),
            onPressed: _showBookmarks,
            tooltip: 'View bookmarks',
          ),
          IconButton(
            icon: Icon(Icons.settings, color: textColor),
            onPressed: _showReadingSettings,
            tooltip: 'Reading settings',
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: progressPercentage / 100,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),

          // Paragraphs list
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              itemPositionsListener: _positionsListener,
              itemCount: widget.paragraphs.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return ParagraphWidget(
                  paragraph: widget.paragraphs[index],
                  book: widget.book,
                  preferences: preferences,
                  isCurrentParagraph: index == _currentParagraphIndex,
                );
              },
            ),
          ),

          // Bottom bar with page info
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page ${_currentParagraphIndex + 1} of ${widget.paragraphs.length}',
                  style: TextStyle(color: textColor, fontSize: 14),
                ),
                Text(
                  '${progressPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Auto-scroll button
          FloatingActionButton(
            mini: true,
            heroTag: 'autoScroll',
            onPressed: _toggleAutoScroll,
            backgroundColor:
                _isAutoScrolling ? Colors.red : Theme.of(context).primaryColor,
            child: Icon(_isAutoScrolling ? Icons.pause : Icons.play_arrow),
          ),
          const SizedBox(height: 12),

          // Table of contents button
          FloatingActionButton(
            heroTag: 'toc',
            onPressed: _showTableOfContents,
            child: const Icon(Icons.list),
            tooltip: 'Table of Contents',
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(BackgroundColor bgColor) {
    switch (bgColor) {
      case BackgroundColor.white:
        return Colors.white;
      case BackgroundColor.sepia:
        return const Color(0xFFF4ECD8);
      case BackgroundColor.dark:
        return const Color(0xFF2C2C2E);
      case BackgroundColor.black:
        return Colors.black;
    }
  }

  Color _getTextColor(BackgroundColor bgColor) {
    switch (bgColor) {
      case BackgroundColor.white:
      case BackgroundColor.sepia:
        return Colors.black;
      case BackgroundColor.dark:
      case BackgroundColor.black:
        return Colors.white;
    }
  }

  @override
  void dispose() {
    _positionsListener.itemPositions.removeListener(_onScrollPositionChanged);
    super.dispose();
  }
}
