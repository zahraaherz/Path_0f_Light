import 'package:cloud_functions/cloud_functions.dart';
import '../models/library/reading_models.dart';

/// Repository for managing book reading progress and bookmarks
class BookReadingRepository {
  final FirebaseFunctions _functions;

  BookReadingRepository({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  /// Save reading progress
  Future<Map<String, dynamic>> saveReadingProgress({
    required String bookId,
    required String paragraphId,
    String? sectionId,
    int? pageNumber,
    int? totalPages,
  }) async {
    try {
      final result = await _functions.httpsCallable('saveReadingProgress').call({
        'bookId': bookId,
        'paragraphId': paragraphId,
        'sectionId': sectionId,
        'pageNumber': pageNumber,
        'totalPages': totalPages,
      });

      return result.data as Map<String, dynamic>;
    } catch (e) {
      print('Error saving reading progress: $e');
      rethrow;
    }
  }

  /// Mark a section as completed
  Future<Map<String, dynamic>> markSectionCompleted({
    required String bookId,
    required String sectionId,
  }) async {
    try {
      final result = await _functions.httpsCallable('markSectionCompleted').call({
        'bookId': bookId,
        'sectionId': sectionId,
      });

      return result.data as Map<String, dynamic>;
    } catch (e) {
      print('Error marking section completed: $e');
      rethrow;
    }
  }

  /// Create a bookmark
  Future<UserBookmark> createBookmark({
    required String bookId,
    required String paragraphId,
    required int pageNumber,
    String? sectionTitle,
    String? note,
    String? color,
  }) async {
    try {
      final result = await _functions.httpsCallable('createBookmark').call({
        'bookId': bookId,
        'paragraphId': paragraphId,
        'pageNumber': pageNumber,
        'sectionTitle': sectionTitle,
        'note': note,
        'color': color ?? 'default',
      });

      if (result.data['success'] == true) {
        return UserBookmark.fromJson(result.data['bookmark'] as Map<String, dynamic>);
      }

      throw Exception('Failed to create bookmark');
    } catch (e) {
      print('Error creating bookmark: $e');
      rethrow;
    }
  }

  /// Delete a bookmark
  Future<bool> deleteBookmark(String bookmarkId) async {
    try {
      final result = await _functions.httpsCallable('deleteBookmark').call({
        'bookmarkId': bookmarkId,
      });

      return result.data['success'] == true;
    } catch (e) {
      print('Error deleting bookmark: $e');
      return false;
    }
  }

  /// Add book to collection
  Future<bool> addToCollection({
    required String bookId,
    String? collectionId,
  }) async {
    try {
      final result = await _functions.httpsCallable('addToCollection').call({
        'bookId': bookId,
        'collectionId': collectionId,
      });

      return result.data['success'] == true;
    } catch (e) {
      print('Error adding to collection: $e');
      return false;
    }
  }
}
