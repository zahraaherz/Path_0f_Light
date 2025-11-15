import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/comments_providers.dart';

class CommentInputWidget extends ConsumerStatefulWidget {
  final String bookId;
  final String paragraphId;
  final String? parentCommentId;
  final String? replyToUsername;
  final VoidCallback? onCancelReply;
  final VoidCallback? onCommentPosted;

  const CommentInputWidget({
    Key? key,
    required this.bookId,
    required this.paragraphId,
    this.parentCommentId,
    this.replyToUsername,
    this.onCancelReply,
    this.onCommentPosted,
  }) : super(key: key);

  @override
  ConsumerState<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends ConsumerState<CommentInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPrivate = false;
  bool _isPosting = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _postComment() async {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    if (_controller.text.length > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comment cannot exceed 500 characters')),
      );
      return;
    }

    setState(() => _isPosting = true);

    final createComment = ref.read(createCommentProvider);
    final result = await createComment(
      bookId: widget.bookId,
      paragraphId: widget.paragraphId,
      text: _controller.text.trim(),
      isPrivate: _isPrivate,
      parentCommentId: widget.parentCommentId,
    );

    setState(() => _isPosting = false);

    if (mounted) {
      if (result.success) {
        _controller.clear();
        setState(() => _isPrivate = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.message +
                  (result.comment?.isPrivate == true
                      ? ' (Private)'
                      : result.energyEarned != null && result.energyEarned! > 0
                          ? ' (+${result.energyEarned} energy)'
                          : ''),
            ),
            backgroundColor: Colors.green,
          ),
        );

        widget.onCommentPosted?.call();
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

  @override
  Widget build(BuildContext context) {
    final isReply = widget.parentCommentId != null;
    final characterCount = _controller.text.length;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Reply indicator
          if (isReply)
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.reply, size: 16, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Replying to ${widget.replyToUsername}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: widget.onCancelReply,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

          // Input row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Text field
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: isReply ? 'Write a reply...' : 'Write a comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    suffixIcon: characterCount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              '$characterCount/500',
                              style: TextStyle(
                                fontSize: 12,
                                color: characterCount > 500
                                    ? Colors.red
                                    : Colors.grey[600],
                              ),
                            ),
                          )
                        : null,
                  ),
                  maxLines: null,
                  maxLength: 500,
                  buildCounter: (context,
                          {required currentLength, required isFocused, maxLength}) =>
                      null,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) {
                    setState(() {}); // Rebuild for character count
                  },
                ),
              ),

              const SizedBox(width: 8),

              // Send button
              Container(
                decoration: BoxDecoration(
                  color: _controller.text.trim().isNotEmpty && !_isPosting
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: _isPosting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.send, color: Colors.white),
                  onPressed:
                      _controller.text.trim().isNotEmpty && !_isPosting
                          ? _postComment
                          : null,
                ),
              ),
            ],
          ),

          // Privacy toggle
          if (!isReply)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Checkbox(
                    value: _isPrivate,
                    onChanged: (value) {
                      setState(() => _isPrivate = value ?? false);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _isPrivate = !_isPrivate);
                      },
                      child: Row(
                        children: [
                          Icon(
                            _isPrivate ? Icons.lock : Icons.public,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _isPrivate
                                ? 'Private (only you can see)'
                                : 'Public (+1 energy)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
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
    );
  }
}
