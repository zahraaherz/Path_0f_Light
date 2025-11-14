import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/collection/collection_item.dart';
import '../../providers/collection_providers.dart';
import '../../widgets/collection/collection_item_card.dart';
import '../../widgets/collection/checklist_view_widget.dart';
import '../../widgets/collection/add_to_collection_dialog.dart';

/// My Collection Screen - User's Personal Library
class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewMode = ref.watch(collectionViewModeProvider);
    final searchQuery = ref.watch(collectionSearchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
        elevation: 0,
        actions: [
          // View mode toggle
          IconButton(
            icon: Icon(
              viewMode == 'list'
                  ? Icons.grid_view
                  : viewMode == 'grid'
                      ? Icons.checklist
                      : Icons.list,
            ),
            onPressed: () {
              final currentMode = ref.read(collectionViewModeProvider);
              final nextMode = currentMode == 'list'
                  ? 'grid'
                  : currentMode == 'grid'
                      ? 'checklist'
                      : 'list';
              ref.read(collectionViewModeProvider.notifier).state = nextMode;
            },
            tooltip: 'Change view mode',
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
            tooltip: 'Search',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Favorites'),
            Tab(text: 'Morning'),
            Tab(text: 'Evening'),
            Tab(text: 'Friday'),
            Tab(text: 'Ramadhan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All items
          _buildCollectionView(null),
          // Favorites
          _buildFavoritesView(),
          // Morning
          _buildCategoryView(CollectionCategory.morning),
          // Evening
          _buildCategoryView(CollectionCategory.evening),
          // Friday
          _buildCategoryView(CollectionCategory.friday),
          // Ramadhan
          _buildCategoryView(CollectionCategory.ramadhan),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add to Collection'),
      ),
    );
  }

  /// Build collection view based on view mode
  Widget _buildCollectionView(CollectionCategory? category) {
    final viewMode = ref.watch(collectionViewModeProvider);

    if (viewMode == 'checklist') {
      return const ChecklistViewWidget();
    }

    return _buildItemsList(category);
  }

  /// Build items list
  Widget _buildItemsList(CollectionCategory? category) {
    final collectionItemsAsync = category == null
        ? ref.watch(userCollectionItemsProvider)
        : ref.watch(collectionItemsByCategoryProvider(category));
    final viewMode = ref.watch(collectionViewModeProvider);

    return collectionItemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.refresh(userCollectionItemsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.collections_bookmark_outlined,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  category == null
                      ? 'Your collection is empty'
                      : 'No items in this category',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add du\'as, surahs, ziyarats, and more',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => _showAddDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ],
            ),
          );
        }

        if (viewMode == 'grid') {
          return _buildGridView(items);
        }

        return _buildListView(items);
      },
    );
  }

  /// Build list view
  Widget _buildListView(List<CollectionItem> items) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userCollectionItemsProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return CollectionItemCard(
            item: item,
            onTap: () => _viewItemDetails(item),
            onFavoriteToggle: () => _toggleFavorite(item),
            onDelete: () => _deleteItem(item),
          );
        },
      ),
    );
  }

  /// Build grid view
  Widget _buildGridView(List<CollectionItem> items) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userCollectionItemsProvider);
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return CollectionItemCard(
            item: item,
            isGridView: true,
            onTap: () => _viewItemDetails(item),
            onFavoriteToggle: () => _toggleFavorite(item),
            onDelete: () => _deleteItem(item),
          );
        },
      ),
    );
  }

  /// Build category view
  Widget _buildCategoryView(CollectionCategory category) {
    return _buildItemsList(category);
  }

  /// Build favorites view
  Widget _buildFavoritesView() {
    final favoritesAsync = ref.watch(favoriteCollectionItemsProvider);
    final viewMode = ref.watch(collectionViewModeProvider);

    return favoritesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_border,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the star icon on items to add them here',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (viewMode == 'grid') {
          return _buildGridView(items);
        }

        return _buildListView(items);
      },
    );
  }

  /// Show add to collection dialog
  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddToCollectionDialog(),
    );
  }

  /// Show search dialog
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Collection'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search by title, text, or tags...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
          onSubmitted: (value) {
            ref.read(collectionSearchQueryProvider.notifier).state = value;
            Navigator.of(context).pop();
            _showSearchResults(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(collectionSearchQueryProvider.notifier).state =
                  _searchController.text;
              Navigator.of(context).pop();
              _showSearchResults(context);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  /// Show search results
  void _showSearchResults(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _SearchResultsScreen(),
      ),
    );
  }

  /// View item details
  void _viewItemDetails(CollectionItem item) {
    // Update last accessed
    ref.read(collectionRepositoryProvider).updateLastAccessed(item.id);

    // Navigate to details screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _CollectionItemDetailsScreen(item: item),
      ),
    );
  }

  /// Toggle favorite status
  void _toggleFavorite(CollectionItem item) {
    ref.read(toggleFavoriteProvider(
      (itemId: item.id, isFavorite: !item.isFavorite),
    ));
  }

  /// Delete item
  void _deleteItem(CollectionItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete "${item.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(deleteCollectionItemProvider(item.id));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item deleted')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Search results screen
class _SearchResultsScreen extends ConsumerWidget {
  const _SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(collectionSearchQueryProvider);
    final searchResultsAsync =
        ref.watch(searchCollectionItemsProvider(searchQuery));

    return Scaffold(
      appBar: AppBar(
        title: Text('Search: "$searchQuery"'),
      ),
      body: searchResultsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No results found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return CollectionItemCard(
                item: item,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          _CollectionItemDetailsScreen(item: item),
                    ),
                  );
                },
                onFavoriteToggle: () {
                  ref.read(toggleFavoriteProvider(
                    (itemId: item.id, isFavorite: !item.isFavorite),
                  ));
                },
                onDelete: () {
                  ref.read(deleteCollectionItemProvider(item.id));
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// Collection item details screen (placeholder)
class _CollectionItemDetailsScreen extends StatelessWidget {
  final CollectionItem item;

  const _CollectionItemDetailsScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.arabicTitle != null) ...[
              Text(
                item.arabicTitle!,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Amiri',
                    ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),
            ],
            Text(
              item.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            // Arabic text
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.arabicText,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontFamily: 'Amiri',
                      height: 2.0,
                    ),
                textDirection: TextDirection.rtl,
              ),
            ),
            if (item.translation != null) ...[
              const SizedBox(height: 24),
              Text(
                'Translation',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                item.translation!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            if (item.transliteration != null) ...[
              const SizedBox(height: 24),
              Text(
                'Transliteration',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                item.transliteration!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
            if (item.sourceReference != null) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.source, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    item.sourceReference!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
            if (item.notes != null && item.notes!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Notes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                item.notes!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (item.tags.isNotEmpty) ...[
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
