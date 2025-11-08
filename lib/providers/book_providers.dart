import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/library/book_models.dart';
import '../repositories/book_repository.dart';
import 'auth_providers.dart';

/// Provider for all published books
final publishedBooksProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  final bookRepo = ref.watch(bookRepositoryProvider);
  return await bookRepo.getPublishedBooks();
});

/// Provider for searching books
final bookSearchProvider = FutureProvider.autoDispose.family<List<Book>, String>(
  (ref, searchTerm) async {
    if (searchTerm.isEmpty) {
      return ref.watch(publishedBooksProvider.future);
    }

    final bookRepo = ref.watch(bookRepositoryProvider);
    return await bookRepo.searchBooks(searchTerm: searchTerm);
  },
);

/// Provider for book details with sections
final bookDetailsProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>(
  (ref, bookId) async {
    final bookRepo = ref.watch(bookRepositoryProvider);
    return await bookRepo.getBookDetails(bookId);
  },
);

/// Provider for section paragraphs
final sectionParagraphsProvider =
    FutureProvider.autoDispose.family<List<Paragraph>, String>(
  (ref, sectionId) async {
    final bookRepo = ref.watch(bookRepositoryProvider);
    return await bookRepo.getSectionParagraphs(sectionId: sectionId);
  },
);

/// Provider for single paragraph
final paragraphProvider = FutureProvider.autoDispose.family<Paragraph?, String>(
  (ref, paragraphId) async {
    final bookRepo = ref.watch(bookRepositoryProvider);
    return await bookRepo.getParagraph(paragraphId);
  },
);

/// Provider for books by topic
final booksByTopicProvider = FutureProvider.autoDispose.family<List<Book>, String>(
  (ref, topic) async {
    final bookRepo = ref.watch(bookRepositoryProvider);
    return await bookRepo.getBooksByTopic(topic);
  },
);

/// Provider for reading progress
final readingProgressProvider =
    FutureProvider.autoDispose.family<ReadingProgress?, String>(
  (ref, bookId) async {
    final currentUser = ref.watch(currentAuthUserProvider);
    if (currentUser == null) return null;

    final bookRepo = ref.watch(bookRepositoryProvider);
    return await bookRepo.getReadingProgress(currentUser.uid, bookId);
  },
);

/// Provider for reading statistics
final readingStatsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final currentUser = ref.watch(currentAuthUserProvider);
  if (currentUser == null) {
    return {
      'totalBooksStarted': 0,
      'completedBooks': 0,
      'totalParagraphsRead': 0,
      'currentlyReading': 0,
    };
  }

  final bookRepo = ref.watch(bookRepositoryProvider);
  return await bookRepo.getReadingStats(currentUser.uid);
});

/// State for current reading session
class ReadingSessionState {
  final String bookId;
  final String sectionId;
  final List<Paragraph> paragraphs;
  final int currentIndex;
  final Set<String> readParagraphs;

  ReadingSessionState({
    required this.bookId,
    required this.sectionId,
    required this.paragraphs,
    this.currentIndex = 0,
    this.readParagraphs = const {},
  });

  ReadingSessionState copyWith({
    String? bookId,
    String? sectionId,
    List<Paragraph>? paragraphs,
    int? currentIndex,
    Set<String>? readParagraphs,
  }) {
    return ReadingSessionState(
      bookId: bookId ?? this.bookId,
      sectionId: sectionId ?? this.sectionId,
      paragraphs: paragraphs ?? this.paragraphs,
      currentIndex: currentIndex ?? this.currentIndex,
      readParagraphs: readParagraphs ?? this.readParagraphs,
    );
  }

  Paragraph? get currentParagraph {
    if (currentIndex >= 0 && currentIndex < paragraphs.length) {
      return paragraphs[currentIndex];
    }
    return null;
  }

  bool get hasNext => currentIndex < paragraphs.length - 1;
  bool get hasPrevious => currentIndex > 0;
  int get progress => readParagraphs.length;
  double get progressPercentage {
    if (paragraphs.isEmpty) return 0.0;
    return readParagraphs.length / paragraphs.length;
  }
}

/// Reading session notifier
class ReadingSessionNotifier extends StateNotifier<ReadingSessionState?> {
  final BookRepository _bookRepository;
  final String? _userId;

  ReadingSessionNotifier(this._bookRepository, this._userId) : super(null);

  /// Start a new reading session
  Future<void> startSession({
    required String bookId,
    required String sectionId,
    required List<Paragraph> paragraphs,
    int startIndex = 0,
  }) async {
    state = ReadingSessionState(
      bookId: bookId,
      sectionId: sectionId,
      paragraphs: paragraphs,
      currentIndex: startIndex,
    );
  }

  /// Navigate to next paragraph
  Future<void> nextParagraph() async {
    if (state == null || !state!.hasNext) return;

    // Mark current as read
    await _markCurrentAsRead();

    state = state!.copyWith(
      currentIndex: state!.currentIndex + 1,
    );

    // Update reading progress
    await _updateProgress();
  }

  /// Navigate to previous paragraph
  void previousParagraph() {
    if (state == null || !state!.hasPrevious) return;

    state = state!.copyWith(
      currentIndex: state!.currentIndex - 1,
    );
  }

  /// Jump to specific paragraph
  void jumpToParagraph(int index) {
    if (state == null || index < 0 || index >= state!.paragraphs.length) {
      return;
    }

    state = state!.copyWith(currentIndex: index);
  }

  /// Mark current paragraph as read
  Future<void> _markCurrentAsRead() async {
    if (state == null || _userId == null) return;

    final currentParagraph = state!.currentParagraph;
    if (currentParagraph == null) return;

    try {
      await _bookRepository.markParagraphAsRead(
        userId: _userId!,
        bookId: state!.bookId,
        paragraphId: currentParagraph.id,
      );

      // Update local state
      final newReadSet = Set<String>.from(state!.readParagraphs)
        ..add(currentParagraph.id);

      state = state!.copyWith(readParagraphs: newReadSet);
    } catch (e) {
      // Silently fail - not critical
      print('Failed to mark paragraph as read: $e');
    }
  }

  /// Update overall reading progress
  Future<void> _updateProgress() async {
    if (state == null || _userId == null) return;

    try {
      await _bookRepository.updateReadingProgress(
        userId: _userId!,
        bookId: state!.bookId,
        sectionId: state!.sectionId,
        currentParagraph: state!.currentIndex,
        totalParagraphs: state!.paragraphs.length,
        completedParagraphs: state!.readParagraphs.length,
      );
    } catch (e) {
      // Silently fail
      print('Failed to update reading progress: $e');
    }
  }

  /// End session
  void endSession() {
    state = null;
  }
}

/// Provider for reading session
final readingSessionProvider =
    StateNotifierProvider<ReadingSessionNotifier, ReadingSessionState?>((ref) {
  final bookRepo = ref.watch(bookRepositoryProvider);
  final currentUser = ref.watch(currentAuthUserProvider);

  return ReadingSessionNotifier(bookRepo, currentUser?.uid);
});

/// Provider for currently reading books
final currentlyReadingBooksProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>(
  (ref) async {
    final currentUser = ref.watch(currentAuthUserProvider);
    if (currentUser == null) return [];

    final bookRepo = ref.watch(bookRepositoryProvider);
    final stats = await bookRepo.getReadingStats(currentUser.uid);

    // This would need to be enhanced to actually return the books with progress
    // For now, return empty list
    return [];
  },
);

/// Provider for search query state
final bookSearchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for selected book filter
enum BookFilter { all, inProgress, completed }

final bookFilterProvider = StateProvider<BookFilter>((ref) => BookFilter.all);
