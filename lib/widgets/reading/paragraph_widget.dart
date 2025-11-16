import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/library/book.dart';
import '../../models/library/paragraph.dart';
import '../../models/library/reading_models.dart';
import '../../providers/comments_providers.dart';
import '../comments/comments_sheet.dart';

class ParagraphWidget extends ConsumerStatefulWidget {
  final Paragraph paragraph;
  final Book book;
  final ReadingPreferences preferences;
  final bool isCurrentParagraph;

  const ParagraphWidget({
    Key? key,
    required this.paragraph,
    required this.book,
    required this.preferences,
    this.isCurrentParagraph = false,
  }) : super(key: key);

  @override
  ConsumerState<ParagraphWidget> createState() => _ParagraphWidgetState();
}

class _ParagraphWidgetState extends ConsumerState<ParagraphWidget> {
  bool _showCommentIndicator = false;

  @override
  void initState() {
    super.initState();
    _checkCommentsExist();
  }

  Future<void> _checkCommentsExist() async {
    // Check if this paragraph has comments
    try {
      final commentsAsync = ref.read(commentsListProvider(widget.paragraph.id));
      commentsAsync.when(
        data: (commentsList) {
          if (mounted && commentsList.totalComments > 0) {
            setState(() => _showCommentIndicator = true);
          }
        },
        loading: () {},
        error: (_, __) {},
      );
    } catch (e) {
      // Ignore error
    }
  }

  void _showContextMenu(BuildContext context, LongPressStartDetails details) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        details.globalPosition,
        details.globalPosition,
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.comment),
              SizedBox(width: 8),
              Text('Comment on this'),
            ],
          ),
          onTap: () => _showComments(),
        ),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.bookmark_add),
              SizedBox(width: 8),
              Text('Bookmark here'),
            ],
          ),
          onTap: () => _addBookmark(),
        ),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.report),
              SizedBox(width: 8),
              Text('Report issue'),
            ],
          ),
          onTap: () => _reportIssue(),
        ),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.copy),
              SizedBox(width: 8),
              Text('Copy text'),
            ],
          ),
          onTap: () => _copyText(),
        ),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.share),
              SizedBox(width: 8),
              Text('Share'),
            ],
          ),
          onTap: () => _shareText(),
        ),
      ],
    );
  }

  void _showComments() {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => CommentsSheet(
          bookId: widget.book.id,
          paragraphId: widget.paragraph.id,
          paragraphText: widget.paragraph.content.textAr,
        ),
      );
    });
  }

  void _addBookmark() {
    // This will be handled by parent
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Use bookmark button in app bar'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _reportIssue() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) => ReportParagraphDialog(
          bookId: widget.book.id,
          paragraphId: widget.paragraph.id,
        ),
      );
    });
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: widget.paragraph.content.textAr));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareText() {
    final shareText = '''
${widget.paragraph.content.textAr}

من كتاب: ${widget.book.titleAr}
المؤلف: ${widget.book.authorAr}
    ''';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = _getTextColor();
    final fontSize = widget.preferences.fontSizeValue;
    final fontFamily = _getFontFamily();

    return GestureDetector(
      onLongPressStart: (details) => _showContextMenu(context, details),
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.isCurrentParagraph
              ? Theme.of(context).primaryColor.withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: widget.isCurrentParagraph
              ? Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  width: 2,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section title if different from previous
            if (widget.paragraph.sectionTitleAr.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  widget.paragraph.sectionTitleAr,
                  style: TextStyle(
                    fontSize: fontSize + 2,
                    fontWeight: FontWeight.bold,
                    color: textColor.withOpacity(0.7),
                    fontFamily: fontFamily,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),

            // Paragraph text
            Text(
              widget.paragraph.content.textAr,
              style: TextStyle(
                fontSize: fontSize,
                height: widget.preferences.lineSpacing,
                color: textColor,
                fontFamily: fontFamily,
              ),
              textDirection: TextDirection.rtl,
              textAlign: _getTextAlign(),
            ),

            // Comment indicator
            if (_showCommentIndicator)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InkWell(
                  onTap: _showComments,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.comment,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Consumer(
                        builder: (context, ref, child) {
                          final commentsAsync =
                              ref.watch(commentsListProvider(widget.paragraph.id));
                          return commentsAsync.when(
                            data: (commentsList) => Text(
                              '${commentsList.totalComments} comments',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getTextColor() {
    switch (widget.preferences.backgroundColor) {
      case BackgroundColor.white:
      case BackgroundColor.sepia:
        return Colors.black;
      case BackgroundColor.dark:
      case BackgroundColor.black:
        return Colors.white;
    }
  }

  String _getFontFamily() {
    switch (widget.preferences.fontFamily) {
      case FontFamily.amiri:
        return 'Amiri';
      case FontFamily.scheherazade:
        return 'Scheherazade';
      case FontFamily.notoNaskh:
        return 'Noto Naskh Arabic';
      case FontFamily.traditional:
        return 'Traditional Arabic';
    }
  }

  TextAlign _getTextAlign() {
    switch (widget.preferences.textAlign) {
      case TextAlign.justified:
        return TextAlign.justify;
      case TextAlign.right:
        return TextAlign.right;
      case TextAlign.left:
        return TextAlign.left;
      case TextAlign.center:
        return TextAlign.center;
    }
  }
}

// Report paragraph dialog
class ReportParagraphDialog extends ConsumerStatefulWidget {
  final String bookId;
  final String paragraphId;

  const ReportParagraphDialog({
    Key? key,
    required this.bookId,
    required this.paragraphId,
  }) : super(key: key);

  @override
  ConsumerState<ReportParagraphDialog> createState() =>
      _ReportParagraphDialogState();
}

class _ReportParagraphDialogState extends ConsumerState<ReportParagraphDialog> {
  final _descriptionController = TextEditingController();
  String _selectedIssueType = 'typo';
  bool _isSubmitting = false;

  final List<Map<String, String>> _issueTypes = [
    {'value': 'typo', 'label': 'Typo/Spelling Error'},
    {'value': 'wrong_content', 'label': 'Wrong Content'},
    {'value': 'formatting', 'label': 'Formatting Issue'},
    {'value': 'translation', 'label': 'Translation Error'},
    {'value': 'other', 'label': 'Other'},
  ];

  Future<void> _submitReport() async {
    if (_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe the issue')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final reportParagraph = ref.read(reportParagraphProvider);
    final success = await reportParagraph(
      bookId: widget.bookId,
      paragraphId: widget.paragraphId,
      issueType: _selectedIssueType,
      description: _descriptionController.text.trim(),
    );

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Thank you for your report!'
                : 'Failed to submit report. Please try again.',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report Issue'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('What kind of issue did you find?'),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedIssueType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Issue Type',
              ),
              items: _issueTypes.map((type) {
                return DropdownMenuItem(
                  value: type['value'],
                  child: Text(type['label']!),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedIssueType = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Please describe the issue in detail...',
              ),
              maxLines: 4,
              maxLength: 500,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitReport,
          child: _isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
