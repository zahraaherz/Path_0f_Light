import 'package:flutter/material.dart';
import '../../models/library/book.dart';
import '../../models/library/paragraph.dart';

class TableOfContentsSheet extends StatelessWidget {
  final Book book;
  final List<Paragraph> paragraphs;
  final Function(int) onSectionTap;

  const TableOfContentsSheet({
    Key? key,
    required this.book,
    required this.paragraphs,
    required this.onSectionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Group paragraphs by section
    final sections = <String, List<Paragraph>>{};
    for (final paragraph in paragraphs) {
      final sectionKey = '${paragraph.sectionId}_${paragraph.sectionTitleAr}';
      sections.putIfAbsent(sectionKey, () => []).add(paragraph);
    }

    final sectionEntries = sections.entries.toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
                  'Table of Contents',
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

          const Divider(),

          // Sections list
          Expanded(
            child: sectionEntries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No sections available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: sectionEntries.length,
                    itemBuilder: (context, index) {
                      final entry = sectionEntries[index];
                      final firstParagraph = entry.value.first;
                      final paragraphCount = entry.value.length;
                      final firstParagraphIndex =
                          paragraphs.indexOf(firstParagraph);

                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                            ),
                          ),
                          ),
                        ),
                        title: Text(
                          firstParagraph.sectionTitleAr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        subtitle: Text(
                          '$paragraphCount paragraphs',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                        ),
                        onTap: () => onSectionTap(firstParagraphIndex),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
