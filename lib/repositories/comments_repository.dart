import 'package:cloud_functions/cloud_functions.dart';
import '../models/library/comment_models.dart';

/// Repository for managing book comments and paragraph reports
class CommentsRepository {
  final FirebaseFunctions _functions;

  CommentsRepository({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  /// Create a comment on a paragraph
  Future<CommentActionResult> createComment({
    required String bookId,
    required String paragraphId,
    required String text,
    bool isPrivate = false,
    String? parentCommentId,
  }) async {
    try {
      final result = await _functions.httpsCallable('createComment').call({
        'bookId': bookId,
        'paragraphId': paragraphId,
        'text': text,
        'isPrivate': isPrivate,
        'parentCommentId': parentCommentId,
      });

      return CommentActionResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error creating comment: $e');
      return CommentActionResult(
        success: false,
        message: 'Failed to create comment',
        error: e.toString(),
      );
    }
  }

  /// Update/edit a comment
  Future<CommentActionResult> updateComment({
    required String commentId,
    required String text,
  }) async {
    try {
      final result = await _functions.httpsCallable('updateComment').call({
        'commentId': commentId,
        'text': text,
      });

      return CommentActionResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error updating comment: $e');
      return CommentActionResult(
        success: false,
        message: 'Failed to update comment',
        error: e.toString(),
      );
    }
  }

  /// Delete a comment
  Future<CommentActionResult> deleteComment(String commentId) async {
    try {
      final result = await _functions.httpsCallable('deleteComment').call({
        'commentId': commentId,
      });

      return CommentActionResult.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      print('Error deleting comment: $e');
      return CommentActionResult(
        success: false,
        message: 'Failed to delete comment',
        error: e.toString(),
      );
    }
  }

  /// Toggle like on a comment
  Future<Map<String, dynamic>> toggleCommentLike(String commentId) async {
    try {
      final result = await _functions.httpsCallable('toggleCommentLike').call({
        'commentId': commentId,
      });

      return result.data as Map<String, dynamic>;
    } catch (e) {
      print('Error toggling comment like: $e');
      rethrow;
    }
  }

  /// Get comments for a paragraph
  Future<CommentsList> getComments({
    required String paragraphId,
    bool includePrivate = false,
    int limit = 20,
    String? lastDocId,
  }) async {
    try {
      final result = await _functions.httpsCallable('getComments').call({
        'paragraphId': paragraphId,
        'includePrivate': includePrivate,
        'limit': limit,
        'lastDocId': lastDocId,
      });

      if (result.data['success'] == true) {
        final comments = (result.data['comments'] as List<dynamic>)
            .map((json) => BookComment.fromJson(json as Map<String, dynamic>))
            .toList();

        return CommentsList(
          comments: comments,
          replies: [], // Replies are included in comments
          totalComments: comments.length,
          hasMore: result.data['hasMore'] == true,
          lastDocumentId: result.data['lastDocId'] as String?,
        );
      }

      return const CommentsList(
        comments: [],
        replies: [],
        totalComments: 0,
        hasMore: false,
      );
    } catch (e) {
      print('Error getting comments: $e');
      rethrow;
    }
  }

  /// Report a paragraph issue
  Future<bool> reportParagraph({
    required String bookId,
    required String paragraphId,
    required String issueType,
    required String description,
  }) async {
    try {
      final result = await _functions.httpsCallable('reportParagraph').call({
        'bookId': bookId,
        'paragraphId': paragraphId,
        'issueType': issueType,
        'description': description,
      });

      return result.data['success'] == true;
    } catch (e) {
      print('Error reporting paragraph: $e');
      return false;
    }
  }
}
