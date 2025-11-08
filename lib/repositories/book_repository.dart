import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/library/book_models.dart';

class BookRepositoryException implements Exception {
  final String message;
  final String code;

  BookRepositoryException(this.message, this.code);

  @override
  String toString() => 'BookRepositoryException: $message (code: $code)';
}

class BookRepository {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  BookRepository({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _functions = functions ?? FirebaseFunctions.instance;

  /// Search for books
  Future<List<Book>> searchBooks({
    String? searchTerm,
    String language = 'en',
    ContentStatus status = ContentStatus.published,
    int limit = 20,
  }) async {
    try {
      final callable = _functions.httpsCallable('searchBooks');
      final result = await callable.call({
        'searchTerm': searchTerm,
        'language': language,
        'status': status.name,
        'limit': limit,
      });

      final data = result.data as Map<String, dynamic>;
      final books = (data['books'] as List)
          .map((bookData) => Book.fromFirestore(
                bookData['id'] as String,
                Map<String, dynamic>.from(bookData),
              ))
          .toList();

      return books;
    } catch (e) {
      throw BookRepositoryException(
        'Failed to search books: ${e.toString()}',
        'search-books-failed',
      );
    }
  }

  /// Get all published books (for browse)
  Future<List<Book>> getPublishedBooks({int limit = 50}) async {
    try {
      return await searchBooks(
        status: ContentStatus.published,
        limit: limit,
      );
    } catch (e) {
      throw BookRepositoryException(
        'Failed to get published books: ${e.toString()}',
        'get-published-books-failed',
      );
    }
  }

  /// Get book details with sections
  Future<Map<String, dynamic>> getBookDetails(String bookId) async {
    try {
      final callable = _functions.httpsCallable('getBookDetails');
      final result = await callable.call({'bookId': bookId});

      final data = result.data as Map<String, dynamic>;

      // Parse book
      final bookData = data['book'] as Map<String, dynamic>;
      final book = Book.fromFirestore(
        bookData['id'] as String,
        Map<String, dynamic>.from(bookData),
      );

      // Parse sections
      final sections = (data['sections'] as List)
          .map((sectionData) => BookSection.fromFirestore(
                sectionData['id'] as String,
                Map<String, dynamic>.from(sectionData),
              ))
          .toList();

      return {
        'book': book,
        'sections': sections,
      };
    } catch (e) {
      throw BookRepositoryException(
        'Failed to get book details: ${e.toString()}',
        'get-book-details-failed',
      );
    }
  }

  /// Get paragraphs for a section
  Future<List<Paragraph>> getSectionParagraphs({
    required String sectionId,
    int? limit,
  }) async {
    try {
      Query query = _firestore
          .collection('paragraphs')
          .where('section_id', isEqualTo: sectionId)
          .orderBy('paragraph_number');

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => Paragraph.fromFirestore(
                doc.id,
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
    } catch (e) {
      throw BookRepositoryException(
        'Failed to get section paragraphs: ${e.toString()}',
        'get-section-paragraphs-failed',
      );
    }
  }

  /// Get a single paragraph
  Future<Paragraph?> getParagraph(String paragraphId) async {
    try {
      final doc = await _firestore.collection('paragraphs').doc(paragraphId).get();

      if (!doc.exists) {
        return null;
      }

      return Paragraph.fromFirestore(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
    } catch (e) {
      throw BookRepositoryException(
        'Failed to get paragraph: ${e.toString()}',
        'get-paragraph-failed',
      );
    }
  }

  /// Get books by category/topic
  Future<List<Book>> getBooksByTopic(String topic) async {
    try {
      final snapshot = await _firestore
          .collection('books')
          .where('content_status', isEqualTo: 'published')
          .get();

      // Filter by topic (requires querying sections)
      final books = <Book>[];
      for (final doc in snapshot.docs) {
        final book = Book.fromFirestore(
          doc.id,
          doc.data(),
        );

        // Check if any section has this topic
        final sectionsSnapshot = await _firestore
            .collection('sections')
            .where('book_id', isEqualTo: book.id)
            .where('topics', arrayContains: topic)
            .limit(1)
            .get();

        if (sectionsSnapshot.docs.isNotEmpty) {
          books.add(book);
        }
      }

      return books;
    } catch (e) {
      throw BookRepositoryException(
        'Failed to get books by topic: ${e.toString()}',
        'get-books-by-topic-failed',
      );
    }
  }

  /// Stream book updates
  Stream<Book> watchBook(String bookId) {
    return _firestore.collection('books').doc(bookId).snapshots().map(
          (doc) => Book.fromFirestore(
            doc.id,
            doc.data() as Map<String, dynamic>,
          ),
        );
  }

  /// Get reading progress for a user
  Future<ReadingProgress?> getReadingProgress(
    String userId,
    String bookId,
  ) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('reading_progress')
          .doc(bookId)
          .get();

      if (!doc.exists) {
        return null;
      }

      return ReadingProgress.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw BookRepositoryException(
        'Failed to get reading progress: ${e.toString()}',
        'get-reading-progress-failed',
      );
    }
  }

  /// Update reading progress
  Future<void> updateReadingProgress({
    required String userId,
    required String bookId,
    required String sectionId,
    required int currentParagraph,
    required int totalParagraphs,
    required int completedParagraphs,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('reading_progress')
          .doc(bookId)
          .set({
        'bookId': bookId,
        'sectionId': sectionId,
        'currentParagraph': currentParagraph,
        'totalParagraphs': totalParagraphs,
        'completedParagraphs': completedParagraphs,
        'lastReadAt': Timestamp.now(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw BookRepositoryException(
        'Failed to update reading progress: ${e.toString()}',
        'update-reading-progress-failed',
      );
    }
  }

  /// Mark paragraph as read
  Future<void> markParagraphAsRead({
    required String userId,
    required String bookId,
    required String paragraphId,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('read_paragraphs')
          .doc(paragraphId)
          .set({
        'paragraphId': paragraphId,
        'bookId': bookId,
        'readAt': Timestamp.now(),
      });
    } catch (e) {
      throw BookRepositoryException(
        'Failed to mark paragraph as read: ${e.toString()}',
        'mark-paragraph-read-failed',
      );
    }
  }

  /// Check if paragraph is read
  Future<bool> isParagraphRead(String userId, String paragraphId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('read_paragraphs')
          .doc(paragraphId)
          .get();

      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  /// Get user's reading statistics
  Future<Map<String, dynamic>> getReadingStats(String userId) async {
    try {
      // Get total books read
      final progressSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('reading_progress')
          .get();

      final totalBooksStarted = progressSnapshot.docs.length;
      final completedBooks = progressSnapshot.docs
          .where((doc) {
            final data = doc.data();
            final completed = data['completedParagraphs'] ?? 0;
            final total = data['totalParagraphs'] ?? 0;
            return total > 0 && completed >= total;
          })
          .length;

      // Get total paragraphs read
      final readParagraphsSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('read_paragraphs')
          .get();

      final totalParagraphsRead = readParagraphsSnapshot.docs.length;

      return {
        'totalBooksStarted': totalBooksStarted,
        'completedBooks': completedBooks,
        'totalParagraphsRead': totalParagraphsRead,
        'currentlyReading': totalBooksStarted - completedBooks,
      };
    } catch (e) {
      throw BookRepositoryException(
        'Failed to get reading stats: ${e.toString()}',
        'get-reading-stats-failed',
      );
    }
  }
}

/// Provider for book repository
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepository();
});
