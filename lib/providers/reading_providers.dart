import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/library/reading_models.dart';
import '../repositories/book_reading_repository.dart';

// Repository provider
final bookReadingRepositoryProvider = Provider<BookReadingRepository>((ref) {
  return BookReadingRepository();
});

// Reading preferences state (persisted per user)
final readingPreferencesProvider =
    StateNotifierProvider<ReadingPreferencesNotifier, ReadingPreferences>((ref) {
  return ReadingPreferencesNotifier();
});

class ReadingPreferencesNotifier extends StateNotifier<ReadingPreferences> {
  ReadingPreferencesNotifier() : super(const ReadingPreferences());

  void setFontSize(FontSize fontSize) {
    state = state.copyWith(fontSize: fontSize);
  }

  void setFontFamily(FontFamily fontFamily) {
    state = state.copyWith(fontFamily: fontFamily);
  }

  void setBackgroundColor(BackgroundColor backgroundColor) {
    state = state.copyWith(backgroundColor: backgroundColor);
  }

  void setLineSpacing(double lineSpacing) {
    state = state.copyWith(lineSpacing: lineSpacing);
  }

  void setTextAlign(TextAlign textAlign) {
    state = state.copyWith(textAlign: textAlign);
  }

  void setAutoScroll(bool autoScroll) {
    state = state.copyWith(autoScroll: autoScroll);
  }

  void setScrollSpeed(double scrollSpeed) {
    state = state.copyWith(scrollSpeed: scrollSpeed);
  }

  void toggleNightMode() {
    state = state.copyWith(enableNightMode: !state.enableNightMode);
  }
}

// Current book ID being read
final currentBookIdProvider = StateProvider<String?>((ref) => null);

// Current paragraph ID
final currentParagraphIdProvider = StateProvider<String?>((ref) => null);

// Current page number
final currentPageNumberProvider = StateProvider<int>((ref) => 0);

// Save reading progress action
final saveReadingProgressProvider = Provider<
    Future<Map<String, dynamic>> Function({
  required String bookId,
  required String paragraphId,
  String? sectionId,
  int? pageNumber,
  int? totalPages,
})>((ref) {
  final repository = ref.watch(bookReadingRepositoryProvider);
  return ({
    required String bookId,
    required String paragraphId,
    String? sectionId,
    int? pageNumber,
    int? totalPages,
  }) async {
    // Update local state
    ref.read(currentBookIdProvider.notifier).state = bookId;
    ref.read(currentParagraphIdProvider.notifier).state = paragraphId;
    if (pageNumber != null) {
      ref.read(currentPageNumberProvider.notifier).state = pageNumber;
    }

    // Save to backend
    return repository.saveReadingProgress(
      bookId: bookId,
      paragraphId: paragraphId,
      sectionId: sectionId,
      pageNumber: pageNumber,
      totalPages: totalPages,
    );
  };
});

// Create bookmark action
final createBookmarkProvider = Provider<
    Future<UserBookmark> Function({
  required String bookId,
  required String paragraphId,
  required int pageNumber,
  String? sectionTitle,
  String? note,
  String? color,
})>((ref) {
  final repository = ref.watch(bookReadingRepositoryProvider);
  return ({
    required String bookId,
    required String paragraphId,
    required int pageNumber,
    String? sectionTitle,
    String? note,
    String? color,
  }) async {
    return repository.createBookmark(
      bookId: bookId,
      paragraphId: paragraphId,
      pageNumber: pageNumber,
      sectionTitle: sectionTitle,
      note: note,
      color: color,
    );
  };
});

// Delete bookmark action
final deleteBookmarkProvider =
    Provider<Future<bool> Function(String)>((ref) {
  final repository = ref.watch(bookReadingRepositoryProvider);
  return (String bookmarkId) async {
    return repository.deleteBookmark(bookmarkId);
  };
});

// Add to collection action
final addToCollectionProvider = Provider<
    Future<bool> Function({
  required String bookId,
  String? collectionId,
})>((ref) {
  final repository = ref.watch(bookReadingRepositoryProvider);
  return ({
    required String bookId,
    String? collectionId,
  }) async {
    return repository.addToCollection(
      bookId: bookId,
      collectionId: collectionId,
    );
  };
});

// Mark section completed action
final markSectionCompletedProvider = Provider<
    Future<Map<String, dynamic>> Function({
  required String bookId,
  required String sectionId,
})>((ref) {
  final repository = ref.watch(bookReadingRepositoryProvider);
  return ({
    required String bookId,
    required String sectionId,
  }) async {
    return repository.markSectionCompleted(
      bookId: bookId,
      sectionId: sectionId,
    );
  };
});
