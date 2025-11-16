import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/library/comment_models.dart';
import '../../providers/comments_providers.dart';
import '../../providers/auth_providers.dart';

class CommentCard extends ConsumerStatefulWidget {
  final BookComment comment;
  final String bookId;
  final String paragraphId;
  final VoidCallback? onReply;
  final bool isReply;

  const CommentCard({
    Key? key,
    required this.comment,
    required this.bookId,
    required this.paragraphId,
    this.onReply,
    this.isReply = false,
  }) : super(key: key);

  @override
  ConsumerState<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends ConsumerState<CommentCard> {
  bool _isExpanded = false;
  bool _isEditing = false;
  final TextEditingController _editController = TextEditingController();

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  Future<void> _toggleLike() async {
    final toggleLike = ref.read(toggleCommentLikeProvider);
    await toggleLike(
      commentId: widget.comment.id,
      paragraphId: widget.paragraphId,
    );
  }

  Future<void> _deleteComment() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Comment'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final deleteComment = ref.read(deleteCommentProvider);
      final result = await deleteComment(
        commentId: widget.comment.id,
        paragraphId: widget.paragraphId,
      );

      if (result.success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment deleted')),
        );
      }
    }
  }

  Future<void> _editComment() async {
    if (!widget.comment.canEdit()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comments can only be edited within 5 minutes'),
        ),
      );
      return;
    }

    setState(() {
      _isEditing = true;
      _editController.text = widget.comment.text;
    });
  }

  Future<void> _saveEdit() async {
    if (_editController.text.trim().isEmpty) {
      return;
    }

    final updateComment = ref.read(updateCommentProvider);
    final result = await updateComment(
      commentId: widget.comment.id,
      text: _editController.text.trim(),
      paragraphId: widget.paragraphId,
    );

    if (mounted) {
      setState(() => _isEditing = false);

      if (result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment updated')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _cancelEdit() {
    setState(() => _isEditing = false);
  }

  void _showMoreMenu() {
    final currentUser = ref.read(authUserProvider);
    final isOwnComment = currentUser != null && widget.comment.isOwnedBy(currentUser.uid);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isOwnComment && widget.comment.canEdit())
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _editComment();
                },
              ),
            if (isOwnComment)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _deleteComment();
                },
              ),
            if (!isOwnComment)
              ListTile(
                leading: const Icon(Icons.flag, color: Colors.orange),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Report comment
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report functionality coming soon')),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authUserProvider);
    final isLiked = currentUser != null && widget.comment.isLikedBy(currentUser.uid);
    final isOwnComment = currentUser != null && widget.comment.isOwnedBy(currentUser.uid);

    return Container(
      padding: EdgeInsets.only(
        left: widget.isReply ? 48 : 16,
        right: 16,
        top: 12,
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User avatar
              CircleAvatar(
                radius: 18,
                backgroundImage: widget.comment.userPhoto != null
                    ? CachedNetworkImageProvider(widget.comment.userPhoto!)
                    : null,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: widget.comment.userPhoto == null
                    ? Text(
                        widget.comment.username[0].toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Comment content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username and timestamp
                    Row(
                      children: [
                        Text(
                          widget.comment.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.comment.getTimeAgo(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        if (widget.comment.isEdited)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              '(edited)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        if (widget.comment.isPrivate)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.lock,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Comment text or edit field
                    if (_isEditing)
                      Column(
                        children: [
                          TextField(
                            controller: _editController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Edit your comment...',
                            ),
                            maxLines: 3,
                            maxLength: 500,
                            autofocus: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _cancelEdit,
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _saveEdit,
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      Text(
                        widget.comment.text,
                        style: const TextStyle(fontSize: 14),
                      ),

                    const SizedBox(height: 8),

                    // Action buttons
                    Row(
                      children: [
                        // Like button
                        InkWell(
                          onTap: currentUser != null ? _toggleLike : null,
                          child: Row(
                            children: [
                              Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                size: 18,
                                color: isLiked ? Colors.red : Colors.grey[600],
                              ),
                              if (widget.comment.likes > 0) ...[
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.comment.likes}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Reply button
                        if (!widget.isReply && widget.onReply != null)
                          InkWell(
                            onTap: widget.onReply,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.reply,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Reply',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const Spacer(),

                        // More menu
                        InkWell(
                          onTap: _showMoreMenu,
                          child: Icon(
                            Icons.more_horiz,
                            size: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    // Replies
                    if (!widget.isReply && widget.comment.replies > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: InkWell(
                          onTap: () {
                            setState(() => _isExpanded = !_isExpanded);
                          },
                          child: Row(
                            children: [
                              Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _isExpanded
                                    ? 'Hide replies'
                                    : 'View ${widget.comment.replies} ${widget.comment.replies == 1 ? 'reply' : 'replies'}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Show replies if expanded
          if (_isExpanded && !widget.isReply)
            FutureBuilder<CommentsList>(
              future: ref
                  .read(commentsRepositoryProvider)
                  .getComments(paragraphId: widget.paragraphId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final replies = snapshot.data!.comments
                      .where((c) => c.parentCommentId == widget.comment.id)
                      .toList();

                  return Column(
                    children: replies
                        .map((reply) => CommentCard(
                              comment: reply,
                              bookId: widget.bookId,
                              paragraphId: widget.paragraphId,
                              isReply: true,
                            ))
                        .toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }
}
