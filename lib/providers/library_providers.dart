import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/library/book.dart';
import '../models/library/section.dart';
import '../models/library/paragraph.dart';
import '../models/library/bookmark.dart';
import '../models/library/reading_progress.dart';
import '../repositories/library_repository.dart';

// ===== Repository Provider =====

/// Library repository provider
final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  return LibraryRepository();
});

// ===== Books Providers =====

/// Get all published books
final publishedBooksProvider = FutureProvider<List<Book>>((ref) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getPublishedBooks();
});

/// Get a specific book by ID
final bookProvider = FutureProvider.family<Book?, String>((ref, bookId) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getBook(bookId);
});

/// Get recent books
final recentBooksProvider =
    FutureProvider.family<List<Book>, int>((ref, limit) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getRecentBooks(limit: limit);
});

/// Search books provider
final searchBooksProvider =
    FutureProvider.family<List<Book>, String>((ref, query) async {
  if (query.isEmpty) return [];

  final repository = ref.watch(libraryRepositoryProvider);
  return repository.searchBooks(query);
});

// ===== Sections Providers =====

/// Get all sections for a book
final bookSectionsProvider =
    FutureProvider.family<List<Section>, String>((ref, bookId) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getBookSections(bookId);
});

/// Get a specific section by ID
final sectionProvider =
    FutureProvider.family<Section?, String>((ref, sectionId) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getSection(sectionId);
});

// ===== Paragraphs Providers =====

/// Get all paragraphs for a section
final sectionParagraphsProvider =
    FutureProvider.family<List<Paragraph>, String>((ref, sectionId) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getSectionParagraphs(sectionId);
});

/// Get a specific paragraph by ID
final paragraphProvider =
    FutureProvider.family<Paragraph?, String>((ref, paragraphId) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getParagraph(paragraphId);
});

/// Search paragraphs in a book
final searchParagraphsProvider = FutureProvider.family<List<Paragraph>,
    ({String bookId, String query})>((ref, params) async {
  if (params.query.isEmpty) return [];

  final repository = ref.watch(libraryRepositoryProvider);
  return repository.searchParagraphsInBook(params.bookId, params.query);
});

// ===== Bookmarks Providers =====

/// Get all user bookmarks
final userBookmarksProvider = FutureProvider<List<Bookmark>>((ref) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getUserBookmarks();
});

/// Get bookmarks for a specific book
final bookBookmarksProvider =
    FutureProvider.family<List<Bookmark>, String>((ref, bookId) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getBookBookmarks(bookId);
});

/// Bookmark operations
class BookmarkNotifier extends StateNotifier<AsyncValue<void>> {
  BookmarkNotifier(this.repository) : super(const AsyncValue.data(null));

  final LibraryRepository repository;

  Future<void> addBookmark(Bookmark bookmark) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.addBookmark(bookmark));
  }

  Future<void> updateBookmark(String bookmarkId, Bookmark bookmark) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => repository.updateBookmark(bookmarkId, bookmark));
  }

  Future<void> deleteBookmark(String bookmarkId) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => repository.deleteBookmark(bookmarkId));
  }
}

final bookmarkNotifierProvider =
    StateNotifierProvider<BookmarkNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(libraryRepositoryProvider);
  return BookmarkNotifier(repository);
});

// ===== Reading Progress Providers =====

/// Get reading progress for a specific book
final readingProgressProvider =
    FutureProvider.family<ReadingProgress?, String>((ref, bookId) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getReadingProgress(bookId);
});

/// Get all user's reading progress
final allReadingProgressProvider =
    FutureProvider<List<ReadingProgress>>((ref) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getAllReadingProgress();
});

/// Get recently read books
final recentlyReadBooksProvider =
    FutureProvider.family<List<ReadingProgress>, int>((ref, limit) async {
  final repository = ref.watch(libraryRepositoryProvider);
  return repository.getRecentlyReadBooks(limit: limit);
});

/// Reading progress operations
class ReadingProgressNotifier extends StateNotifier<AsyncValue<void>> {
  ReadingProgressNotifier(this.repository)
      : super(const AsyncValue.data(null));

  final LibraryRepository repository;

  Future<void> updateProgress(ReadingProgress progress) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => repository.updateReadingProgress(progress));
  }

  Future<void> markParagraphAsRead(String bookId, String paragraphId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => repository.markParagraphAsRead(bookId, paragraphId));
  }
}

final readingProgressNotifierProvider =
    StateNotifierProvider<ReadingProgressNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(libraryRepositoryProvider);
  return ReadingProgressNotifier(repository);
});

// ===== UI State Providers =====

/// Selected book ID state
final selectedBookIdProvider = StateProvider<String?>((ref) => null);

/// Selected section ID state
final selectedSectionIdProvider = StateProvider<String?>((ref) => null);

/// Current search query state
final librarySearchQueryProvider = StateProvider<String>((ref) => '');

/// Reading view settings
class ReadingSettings {
  final double fontSize;
  final String fontFamily;
  final double lineSpacing;
  final bool showTranslation;

  const ReadingSettings({
    this.fontSize = 16.0,
    this.fontFamily = 'Amiri',
    this.lineSpacing = 1.5,
    this.showTranslation = true,
  });

  ReadingSettings copyWith({
    double? fontSize,
    String? fontFamily,
    double? lineSpacing,
    bool? showTranslation,
  }) {
    return ReadingSettings(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      lineSpacing: lineSpacing ?? this.lineSpacing,
      showTranslation: showTranslation ?? this.showTranslation,
    );
  }
}

final readingSettingsProvider =
    StateNotifierProvider<ReadingSettingsNotifier, ReadingSettings>((ref) {
  return ReadingSettingsNotifier();
});

class ReadingSettingsNotifier extends StateNotifier<ReadingSettings> {
  ReadingSettingsNotifier() : super(const ReadingSettings());

  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size);
  }

  void updateFontFamily(String family) {
    state = state.copyWith(fontFamily: family);
  }

  void updateLineSpacing(double spacing) {
    state = state.copyWith(lineSpacing: spacing);
  }

  void toggleTranslation() {
    state = state.copyWith(showTranslation: !state.showTranslation);
  }
}
