import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/library/book_page.dart';

/// Repository for managing book pages with images
class BookPagesRepository {
  final FirebaseFirestore _firestore;

  BookPagesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Get all pages for a book
  Future<List<BookPage>> getBookPages(String bookId) async {
    try {
      final snapshot = await _firestore
          .collection('book_pages')
          .where('book_id', isEqualTo: bookId)
          .orderBy('page_number')
          .get();

      return snapshot.docs
          .map((doc) => BookPage.fromJson({
                ...doc.data(),
                'page_id': doc.id,
              }))
          .toList();
    } catch (e) {
      debugPrint('Error fetching book pages: $e');
      rethrow;
    }
  }

  /// Get a specific page
  Future<BookPage?> getPage(String pageId) async {
    try {
      final doc = await _firestore.collection('book_pages').doc(pageId).get();

      if (!doc.exists) return null;

      return BookPage.fromJson({
        ...doc.data()!,
        'page_id': doc.id,
      });
    } catch (e) {
      debugPrint('Error fetching page: $e');
      return null;
    }
  }

  /// Get pages in a range
  Future<List<BookPage>> getPageRange(
    String bookId,
    int startPage,
    int endPage,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('book_pages')
          .where('book_id', isEqualTo: bookId)
          .where('page_number', isGreaterThanOrEqualTo: startPage)
          .where('page_number', isLessThanOrEqualTo: endPage)
          .orderBy('page_number')
          .get();

      return snapshot.docs
          .map((doc) => BookPage.fromJson({
                ...doc.data(),
                'page_id': doc.id,
              }))
          .toList();
    } catch (e) {
      debugPrint('Error fetching page range: $e');
      rethrow;
    }
  }

  /// Stream book pages (useful for real-time updates)
  Stream<List<BookPage>> streamBookPages(String bookId) {
    return _firestore
        .collection('book_pages')
        .where('book_id', isEqualTo: bookId)
        .orderBy('page_number')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BookPage.fromJson({
                  ...doc.data(),
                  'page_id': doc.id,
                }))
            .toList());
  }

  /// Search pages by text content
  Future<List<BookPage>> searchPagesByText(
    String bookId,
    String searchQuery,
  ) async {
    try {
      // Note: This requires text_content to be indexed
      // For better performance, consider using Algolia or similar
      final snapshot = await _firestore
          .collection('book_pages')
          .where('book_id', isEqualTo: bookId)
          .where('has_ocr', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => BookPage.fromJson({
                ...doc.data(),
                'page_id': doc.id,
              }))
          .where((page) =>
              page.textContent != null &&
              page.textContent!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint('Error searching pages: $e');
      rethrow;
    }
  }

  /// Get page count for a book
  Future<int> getPageCount(String bookId) async {
    try {
      final snapshot = await _firestore
          .collection('book_pages')
          .where('book_id', isEqualTo: bookId)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint('Error getting page count: $e');
      return 0;
    }
  }

  /// Update page OCR text
  Future<void> updatePageText(String pageId, String textContent) async {
    try {
      final wordCount = textContent.split(RegExp(r'\s+')).length;
      final characterCount = textContent.length;

      await _firestore.collection('book_pages').doc(pageId).update({
        'text_content': textContent,
        'word_count': wordCount,
        'character_count': characterCount,
        'has_ocr': true,
      });
    } catch (e) {
      debugPrint('Error updating page text: $e');
      rethrow;
    }
  }

  /// Delete all pages for a book
  Future<void> deleteBookPages(String bookId) async {
    try {
      final batch = _firestore.batch();
      final snapshot = await _firestore
          .collection('book_pages')
          .where('book_id', isEqualTo: bookId)
          .get();

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      debugPrint('Error deleting book pages: $e');
      rethrow;
    }
  }
}
