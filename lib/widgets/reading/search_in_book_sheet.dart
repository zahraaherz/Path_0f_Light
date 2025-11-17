import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';
import '../../models/library/book.dart';
import '../../models/library/paragraph.dart';

/// Search result item with paragraph and match info
class SearchResult {
  final Paragraph paragraph;
  final int paragraphIndex;
  final String matchedText;
  final int matchCount;

  SearchResult({
    required this.paragraph,
    required this.paragraphIndex,
    required this.matchedText,
    required this.matchCount,
  });
}

/// Sheet for searching within a book
class SearchInBookSheet extends StatefulWidget {
  final Book book;
  final List<Paragraph> paragraphs;
  final Function(int) onResultTap;

  const SearchInBookSheet({
    Key? key,
    required this.book,
    required this.paragraphs,
    required this.onResultTap,
  }) : super(key: key);

  @override
  State<SearchInBookSheet> createState() => _SearchInBookSheetState();
}

class _SearchInBookSheetState extends State<SearchInBookSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;
  bool _caseSensitive = false;
  String _currentQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _currentQuery = '';
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _currentQuery = query;
    });

    final results = <SearchResult>[];
    final searchQuery = _caseSensitive ? query : query.toLowerCase();

    for (int i = 0; i < widget.paragraphs.length; i++) {
      final paragraph = widget.paragraphs[i];
      final textAr = _caseSensitive
          ? paragraph.content.textAr
          : paragraph.content.textAr.toLowerCase();
      final textEn = _caseSensitive
          ? (paragraph.content.textEn ?? '')
          : (paragraph.content.textEn ?? '').toLowerCase();

      // Count matches in Arabic text
      final matchesAr = _countMatches(textAr, searchQuery);
      final matchesEn = _countMatches(textEn, searchQuery);
      final totalMatches = matchesAr + matchesEn;

      if (totalMatches > 0) {
        // Get a snippet of the matched text
        final snippet = _getMatchSnippet(
          matchesAr > 0 ? paragraph.content.textAr : paragraph.content.textEn ?? '',
          query,
        );

        results.add(SearchResult(
          paragraph: paragraph,
          paragraphIndex: i,
          matchedText: snippet,
          matchCount: totalMatches,
        ));
      }
    }

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  int _countMatches(String text, String query) {
    if (text.isEmpty || query.isEmpty) return 0;
    int count = 0;
    int index = 0;
    while ((index = text.indexOf(query, index)) != -1) {
      count++;
      index += query.length;
    }
    return count;
  }

  String _getMatchSnippet(String text, String query) {
    final index = _caseSensitive
        ? text.indexOf(query)
        : text.toLowerCase().indexOf(query.toLowerCase());

    if (index == -1) return text.substring(0, text.length.clamp(0, 100));

    final start = (index - 40).clamp(0, text.length);
    final end = (index + query.length + 40).clamp(0, text.length);

    String snippet = text.substring(start, end);
    if (start > 0) snippet = '...$snippet';
    if (end < text.length) snippet = '$snippet...';

    return snippet;
  }

  Widget _highlightText(String text, String query) {
    if (query.isEmpty) return Text(text);

    final spans = <TextSpan>[];
    final lowerText = _caseSensitive ? text : text.toLowerCase();
    final lowerQuery = _caseSensitive ? query : query.toLowerCase();

    int currentIndex = 0;
    while (currentIndex < text.length) {
      final index = lowerText.indexOf(lowerQuery, currentIndex);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(currentIndex)));
        break;
      }

      // Add text before match
      if (index > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, index)));
      }

      // Add highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: const TextStyle(
          backgroundColor: AppTheme.warning,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));

      currentIndex = index + query.length;
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
      textDirection: _isArabic(text) ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  bool _isArabic(String text) {
    if (text.isEmpty) return false;
    // Check if the first character is Arabic
    final firstChar = text.codeUnitAt(0);
    return (firstChar >= 0x0600 && firstChar <= 0x06FF) ||
        (firstChar >= 0x0750 && firstChar <= 0x077F);
  }

  @override
  Widget build(BuildContext context) {
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
                  'Search in Book',
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

          // Search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search for text...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: _performSearch,
            ),
          ),

          // Search options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text(
                      'Case sensitive',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: _caseSensitive,
                    onChanged: (value) {
                      setState(() {
                        _caseSensitive = value ?? false;
                      });
                      if (_currentQuery.isNotEmpty) {
                        _performSearch(_currentQuery);
                      }
                    },
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                if (_searchResults.isNotEmpty)
                  Text(
                    '${_searchResults.length} result${_searchResults.length > 1 ? 's' : ''}',
                    style: TextStyle(
                      color: AppTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),

          const Divider(),

          // Search results
          Expanded(
            child: _buildResultsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    if (_currentQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Search for text in this book',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.paragraphs.length} paragraphs available',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
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
      padding: const EdgeInsets.all(8),
      itemCount: _searchResults.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${result.matchCount}',
                  style: const TextStyle(
                    color: AppTheme.primaryTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  result.matchCount == 1 ? 'match' : 'matches',
                  style: TextStyle(
                    color: AppTheme.primaryTeal,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            result.paragraph.sectionTitleAr,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _highlightText(result.matchedText, _currentQuery),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_forward,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 4),
              Text(
                'p.${result.paragraph.pageNumber}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          onTap: () {
            widget.onResultTap(result.paragraphIndex);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
