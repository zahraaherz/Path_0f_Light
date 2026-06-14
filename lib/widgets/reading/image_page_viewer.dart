import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../models/library/book_page.dart';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';

/// Widget to display book pages as images with zoom/pan support
class ImagePageViewer extends StatefulWidget {
  final List<BookPage> pages;
  final int initialPage;
  final bool showPageNumber;
  final bool showText;

  const ImagePageViewer({
    super.key,
    required this.pages,
    this.initialPage = 0,
    this.showPageNumber = true,
    this.showText = false,
  });

  @override
  State<ImagePageViewer> createState() => _ImagePageViewerState();
}

class _ImagePageViewerState extends State<ImagePageViewer> {
  late PageController _pageController;
  late int _currentPage;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPage(int pageNumber) {
    if (pageNumber >= 0 && pageNumber < widget.pages.length) {
      _pageController.jumpToPage(pageNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _showControls
          ? AppBar(
              backgroundColor: Colors.black87,
              title: Text(
                'Page ${_currentPage + 1} of ${widget.pages.length}',
                style: const TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                IconButton(
                  icon: const Icon(Icons.grid_view),
                  onPressed: () => _showPageGrid(context, r),
                  tooltip: 'Page Grid',
                ),
              ],
            )
          : null,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // Page viewer
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                final page = widget.pages[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(page.imageUrl),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 3.0,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: 'page_${page.pageId}',
                  ),
                );
              },
              itemCount: widget.pages.length,
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                  color: AppTheme.primaryTeal,
                ),
              ),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),

            // Navigation controls
            if (_showControls) ...[
              // Previous button
              Positioned(
                left: r.paddingMedium,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    iconSize: r.iconLarge,
                    onPressed: _currentPage > 0 ? _previousPage : null,
                  ),
                ),
              ),

              // Next button
              Positioned(
                right: r.paddingMedium,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                    iconSize: r.iconLarge,
                    onPressed: _currentPage < widget.pages.length - 1
                        ? _nextPage
                        : null,
                  ),
                ),
              ),

              // Page indicator
              if (widget.showPageNumber)
                Positioned(
                  bottom: r.paddingLarge,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.paddingMedium,
                        vertical: r.paddingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(r.radiusMedium),
                      ),
                      child: Text(
                        '${_currentPage + 1} / ${widget.pages.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              // Text content (if available and enabled)
              if (widget.showText && widget.pages[_currentPage].hasText)
                Positioned(
                  bottom: r.paddingLarge * 3,
                  left: r.paddingLarge,
                  right: r.paddingLarge,
                  child: Container(
                    padding: EdgeInsets.all(r.paddingMedium),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(r.radiusMedium),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.text_fields,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: r.spaceSmall),
                            const Text(
                              'Extracted Text:',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: r.spaceSmall),
                        Text(
                          widget.pages[_currentPage].textPreview,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  void _showPageGrid(BuildContext context, Responsive r) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      builder: (context) => Container(
        padding: EdgeInsets.all(r.paddingMedium),
        child: Column(
          children: [
            Text(
              'Go to Page',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            SizedBox(height: r.spaceMedium),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: r.spaceSmall,
                  mainAxisSpacing: r.spaceSmall,
                  childAspectRatio: 0.7,
                ),
                itemCount: widget.pages.length,
                itemBuilder: (context, index) {
                  final page = widget.pages[index];
                  final isCurrentPage = index == _currentPage;

                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _goToPage(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isCurrentPage
                              ? AppTheme.primaryTeal
                              : Colors.white30,
                          width: isCurrentPage ? 3 : 1,
                        ),
                        borderRadius: BorderRadius.circular(r.radiusSmall),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(r.radiusSmall),
                                topRight: Radius.circular(r.radiusSmall),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: page.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(r.paddingXSmall),
                            color: isCurrentPage
                                ? AppTheme.primaryTeal
                                : Colors.white10,
                            child: Text(
                              '${page.pageNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: r.fontSmall,
                                fontWeight: isCurrentPage
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
