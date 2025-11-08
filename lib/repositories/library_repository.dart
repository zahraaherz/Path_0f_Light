import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/library/book.dart';
import '../models/library/section.dart';
import '../models/library/paragraph.dart';
import '../models/library/bookmark.dart';
import '../models/library/reading_progress.dart';

/// Repository for managing library data (books, sections, paragraphs)
class LibraryRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  LibraryRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // ===== Collections =====
  CollectionReference get _booksCollection => _firestore.collection('books');
  CollectionReference get _sectionsCollection =>
      _firestore.collection('sections');
  CollectionReference get _paragraphsCollection =>
      _firestore.collection('paragraphs');
  CollectionReference get _bookmarksCollection =>
      _firestore.collection('bookmarks');
  CollectionReference get _highlightsCollection =>
      _firestore.collection('highlights');
  CollectionReference get _readingProgressCollection =>
      _firestore.collection('reading_progress');

  String? get _currentUserId => _auth.currentUser?.uid;

  // ===== Books =====

  /// Get all published books
  Future<List<Book>> getPublishedBooks() async {
    try {
      final snapshot = await _booksCollection
          .where('content_status', isEqualTo: 'published')
          .orderBy('title_ar')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Book.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading books: $e');
    }
  }

  /// Get a book by ID
  Future<Book?> getBook(String bookId) async {
    try {
      final doc = await _booksCollection.doc(bookId).get();
      if (!doc.exists) return null;

      final data = doc.data() as Map<String, dynamic>;
      return Book.fromJson({'id': doc.id, ...data});
    } catch (e) {
      throw Exception('Error loading book: $e');
    }
  }

  /// Search books by title or author
  Future<List<Book>> searchBooks(String query,
      {String? languageCode}) async {
    try {
      final queryLower = query.toLowerCase();

      // Note: For production, consider using Algolia or Elasticsearch for better search
      final snapshot = await _booksCollection
          .where('content_status', isEqualTo: 'published')
          .get();

      final books = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Book.fromJson({'id': doc.id, ...data});
      }).toList();

      // Filter books based on query
      return books.where((book) {
        final titleAr = book.titleAr.toLowerCase();
        final titleEn = book.titleEn.toLowerCase();
        final authorAr = book.authorAr.toLowerCase();
        final authorEn = book.authorEn.toLowerCase();

        return titleAr.contains(queryLower) ||
            titleEn.contains(queryLower) ||
            authorAr.contains(queryLower) ||
            authorEn.contains(queryLower);
      }).toList();
    } catch (e) {
      throw Exception('Error searching books: $e');
    }
  }

  /// Get recently added books
  Future<List<Book>> getRecentBooks({int limit = 10}) async {
    try {
      final snapshot = await _booksCollection
          .where('content_status', isEqualTo: 'published')
          .orderBy('created_at', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Book.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading recent books: $e');
    }
  }

  // ===== Sections =====

  /// Get all sections for a book
  Future<List<Section>> getBookSections(String bookId) async {
    try {
      final snapshot = await _sectionsCollection
          .where('book_id', isEqualTo: bookId)
          .orderBy('section_number')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Section.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading sections: $e');
    }
  }

  /// Get a specific section
  Future<Section?> getSection(String sectionId) async {
    try {
      final doc = await _sectionsCollection.doc(sectionId).get();
      if (!doc.exists) return null;

      final data = doc.data() as Map<String, dynamic>;
      return Section.fromJson({'id': doc.id, ...data});
    } catch (e) {
      throw Exception('Error loading section: $e');
    }
  }

  // ===== Paragraphs =====

  /// Get all paragraphs for a section
  Future<List<Paragraph>> getSectionParagraphs(String sectionId) async {
    try {
      final snapshot = await _paragraphsCollection
          .where('section_id', isEqualTo: sectionId)
          .orderBy('paragraph_number')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Paragraph.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading paragraphs: $e');
    }
  }

  /// Get a specific paragraph
  Future<Paragraph?> getParagraph(String paragraphId) async {
    try {
      final doc = await _paragraphsCollection.doc(paragraphId).get();
      if (!doc.exists) return null;

      final data = doc.data() as Map<String, dynamic>;
      return Paragraph.fromJson({'id': doc.id, ...data});
    } catch (e) {
      throw Exception('Error loading paragraph: $e');
    }
  }

  /// Search paragraphs within a book
  Future<List<Paragraph>> searchParagraphsInBook(
      String bookId, String query) async {
    try {
      final queryLower = query.toLowerCase();

      final snapshot =
          await _paragraphsCollection.where('book_id', isEqualTo: bookId).get();

      final paragraphs = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Paragraph.fromJson({'id': doc.id, ...data});
      }).toList();

      // Filter paragraphs based on query
      return paragraphs.where((para) {
        final textAr = para.content.textAr.toLowerCase();
        final textEn = para.content.textEn?.toLowerCase() ?? '';
        final keywords = para.allKeywords.join(' ').toLowerCase();

        return textAr.contains(queryLower) ||
            textEn.contains(queryLower) ||
            keywords.contains(queryLower);
      }).toList();
    } catch (e) {
      throw Exception('Error searching paragraphs: $e');
    }
  }

  // ===== Bookmarks =====

  /// Get user's bookmarks
  Future<List<Bookmark>> getUserBookmarks() async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final snapshot = await _bookmarksCollection
          .where('user_id', isEqualTo: userId)
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Bookmark.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading bookmarks: $e');
    }
  }

  /// Get bookmarks for a specific book
  Future<List<Bookmark>> getBookBookmarks(String bookId) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final snapshot = await _bookmarksCollection
          .where('user_id', isEqualTo: userId)
          .where('book_id', isEqualTo: bookId)
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Bookmark.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading book bookmarks: $e');
    }
  }

  /// Add a bookmark
  Future<void> addBookmark(Bookmark bookmark) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final bookmarkData = bookmark.toJson()
        ..remove('id')
        ..['created_at'] = FieldValue.serverTimestamp()
        ..['updated_at'] = FieldValue.serverTimestamp();

      await _bookmarksCollection.add(bookmarkData);
    } catch (e) {
      throw Exception('Error adding bookmark: $e');
    }
  }

  /// Update a bookmark
  Future<void> updateBookmark(String bookmarkId, Bookmark bookmark) async {
    try {
      final bookmarkData = bookmark.toJson()
        ..remove('id')
        ..['updated_at'] = FieldValue.serverTimestamp();

      await _bookmarksCollection.doc(bookmarkId).update(bookmarkData);
    } catch (e) {
      throw Exception('Error updating bookmark: $e');
    }
  }

  /// Delete a bookmark
  Future<void> deleteBookmark(String bookmarkId) async {
    try {
      await _bookmarksCollection.doc(bookmarkId).delete();
    } catch (e) {
      throw Exception('Error deleting bookmark: $e');
    }
  }

  // ===== Reading Progress =====

  /// Get user's reading progress for a book
  Future<ReadingProgress?> getReadingProgress(String bookId) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final snapshot = await _readingProgressCollection
          .where('user_id', isEqualTo: userId)
          .where('book_id', isEqualTo: bookId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      final doc = snapshot.docs.first;
      final data = doc.data() as Map<String, dynamic>;
      return ReadingProgress.fromJson({'id': doc.id, ...data});
    } catch (e) {
      throw Exception('Error loading reading progress: $e');
    }
  }

  /// Get all user's reading progress
  Future<List<ReadingProgress>> getAllReadingProgress() async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final snapshot = await _readingProgressCollection
          .where('user_id', isEqualTo: userId)
          .orderBy('last_read_date', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ReadingProgress.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading reading progress: $e');
    }
  }

  /// Update reading progress
  Future<void> updateReadingProgress(ReadingProgress progress) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final progressData = progress.toJson()
        ..remove('id')
        ..['last_read_date'] = FieldValue.serverTimestamp();

      final snapshot = await _readingProgressCollection
          .where('user_id', isEqualTo: userId)
          .where('book_id', isEqualTo: progress.bookId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        // Create new progress
        await _readingProgressCollection.add(progressData);
      } else {
        // Update existing progress
        await _readingProgressCollection
            .doc(snapshot.docs.first.id)
            .update(progressData);
      }
    } catch (e) {
      throw Exception('Error updating reading progress: $e');
    }
  }

  /// Mark paragraph as read
  Future<void> markParagraphAsRead(
      String bookId, String paragraphId) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final snapshot = await _readingProgressCollection
          .where('user_id', isEqualTo: userId)
          .where('book_id', isEqualTo: bookId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        // Create new progress if it doesn't exist
        final book = await getBook(bookId);
        if (book == null) throw Exception('Book not found');

        await _readingProgressCollection.add({
          'user_id': userId,
          'book_id': bookId,
          'book_title_ar': book.titleAr,
          'book_title_en': book.titleEn,
          'paragraphs_read': [paragraphId],
          'total_paragraphs': book.totalParagraphs,
          'progress_percentage': (1 / book.totalParagraphs) * 100,
          'last_read_date': FieldValue.serverTimestamp(),
          'started_at': FieldValue.serverTimestamp(),
        });
      } else {
        // Update existing progress
        final doc = snapshot.docs.first;
        await doc.reference.update({
          'paragraphs_read': FieldValue.arrayUnion([paragraphId]),
          'last_read_date': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Error marking paragraph as read: $e');
    }
  }

  // ===== Recently Read =====

  /// Get recently read books
  Future<List<ReadingProgress>> getRecentlyReadBooks({int limit = 5}) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    try {
      final snapshot = await _readingProgressCollection
          .where('user_id', isEqualTo: userId)
          .orderBy('last_read_date', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ReadingProgress.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading recently read books: $e');
    }
  }
}
