import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/library/comment_models.dart';
import '../../providers/comments_providers.dart';
import '../../providers/auth_providers.dart';
import 'comment_card.dart';
import 'comment_input_widget.dart';

class CommentsSheet extends ConsumerStatefulWidget {
  final String bookId;
  final String paragraphId;
  final String paragraphText;

  const CommentsSheet({
    Key? key,
    required this.bookId,
    required this.paragraphId,
    required this.paragraphText,
  }) : super(key: key);

  @override
  ConsumerState<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends ConsumerState<CommentsSheet> {
  final ScrollController _scrollController = ScrollController();
  bool _showInput = false;
  String? _replyToCommentId;
  String? _replyToUsername;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onReply(String commentId, String username) {
    setState(() {
      _replyToCommentId = commentId;
      _replyToUsername = username;
      _showInput = true;
    });
  }

  void _cancelReply() {
    setState(() {
      _replyToCommentId = null;
      _replyToUsername = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authUserProvider);
    final commentsAsync = ref.watch(commentsListProvider(widget.paragraphId));
    final isAuthenticated = authUser != null;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Paragraph preview
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              widget.paragraphText.length > 150
                  ? '${widget.paragraphText.substring(0, 150)}...'
                  : widget.paragraphText,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              textDirection: TextDirection.rtl,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const Divider(),

          // Comments list
          Expanded(
            child: commentsAsync.when(
              data: (commentsList) {
                if (commentsList.comments.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No comments yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Be the first to comment!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: commentsList.comments.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final comment = commentsList.comments[index];
                    return CommentCard(
                      comment: comment,
                      bookId: widget.bookId,
                      paragraphId: widget.paragraphId,
                      onReply: () => _onReply(comment.id, comment.username),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load comments',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        ref.invalidate(commentsListProvider(widget.paragraphId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Comment input or login prompt
          if (isAuthenticated)
            CommentInputWidget(
              bookId: widget.bookId,
              paragraphId: widget.paragraphId,
              parentCommentId: _replyToCommentId,
              replyToUsername: _replyToUsername,
              onCancelReply: _cancelReply,
              onCommentPosted: () {
                _cancelReply();
                // Scroll to top to see new comment
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sign in to comment',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to login screen
                      // TODO: Navigate to login
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
