import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/library/comment_models.dart';
import '../repositories/comments_repository.dart';

// Repository provider
final commentsRepositoryProvider = Provider<CommentsRepository>((ref) {
  return CommentsRepository();
});

// Current paragraph ID for comments
final currentCommentParagraphIdProvider = StateProvider<String?>((ref) => null);

// Comments list provider for a specific paragraph
final commentsListProvider =
    FutureProvider.autoDispose.family<CommentsList, String>((ref, paragraphId) async {
  final repository = ref.watch(commentsRepositoryProvider);
  return repository.getComments(
    paragraphId: paragraphId,
    includePrivate: true,
  );
});

// Create comment action
final createCommentProvider = Provider<
    Future<CommentActionResult> Function({
  required String bookId,
  required String paragraphId,
  required String text,
  bool isPrivate,
  String? parentCommentId,
})>((ref) {
  final repository = ref.watch(commentsRepositoryProvider);
  return ({
    required String bookId,
    required String paragraphId,
    required String text,
    bool isPrivate = false,
    String? parentCommentId,
  }) async {
    final result = await repository.createComment(
      bookId: bookId,
      paragraphId: paragraphId,
      text: text,
      isPrivate: isPrivate,
      parentCommentId: parentCommentId,
    );

    // Invalidate comments list to refresh
    if (result.success) {
      ref.invalidate(commentsListProvider(paragraphId));
    }

    return result;
  };
});

// Update comment action
final updateCommentProvider = Provider<
    Future<CommentActionResult> Function({
  required String commentId,
  required String text,
  required String paragraphId,
})>((ref) {
  final repository = ref.watch(commentsRepositoryProvider);
  return ({
    required String commentId,
    required String text,
    required String paragraphId,
  }) async {
    final result = await repository.updateComment(
      commentId: commentId,
      text: text,
    );

    // Invalidate comments list to refresh
    if (result.success) {
      ref.invalidate(commentsListProvider(paragraphId));
    }

    return result;
  };
});

// Delete comment action
final deleteCommentProvider = Provider<
    Future<CommentActionResult> Function({
  required String commentId,
  required String paragraphId,
})>((ref) {
  final repository = ref.watch(commentsRepositoryProvider);
  return ({
    required String commentId,
    required String paragraphId,
  }) async {
    final result = await repository.deleteComment(commentId);

    // Invalidate comments list to refresh
    if (result.success) {
      ref.invalidate(commentsListProvider(paragraphId));
    }

    return result;
  };
});

// Toggle like on comment action
final toggleCommentLikeProvider = Provider<
    Future<bool> Function({
  required String commentId,
  required String paragraphId,
})>((ref) {
  final repository = ref.watch(commentsRepositoryProvider);
  return ({
    required String commentId,
    required String paragraphId,
  }) async {
    final result = await repository.toggleCommentLike(commentId);

    // Invalidate comments list to refresh
    ref.invalidate(commentsListProvider(paragraphId));

    return result['success'] == true;
  };
});

// Report paragraph action
final reportParagraphProvider = Provider<
    Future<bool> Function({
  required String bookId,
  required String paragraphId,
  required String issueType,
  required String description,
})>((ref) {
  final repository = ref.watch(commentsRepositoryProvider);
  return ({
    required String bookId,
    required String paragraphId,
    required String issueType,
    required String description,
  }) async {
    return repository.reportParagraph(
      bookId: bookId,
      paragraphId: paragraphId,
      issueType: issueType,
      description: description,
    );
  };
});
