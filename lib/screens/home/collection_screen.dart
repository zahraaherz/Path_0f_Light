import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/collection/collection_item.dart';
import '../../providers/collection_providers.dart';
import '../../providers/guest_access_providers.dart';
import '../../widgets/collection/collection_item_card.dart';
import '../../widgets/collection/checklist_view_widget.dart';
import '../../widgets/collection/add_to_collection_dialog.dart';
import '../auth/register_screen.dart';
import '../../l10n/app_localizations.dart';

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
    final r = context.responsive;
    final viewMode = ref.watch(collectionViewModeProvider);
    final searchQuery = ref.watch(collectionSearchQueryProvider);
    final isGuest = ref.watch(isGuestUserProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myCollection),
        elevation: 0,
        actions: [
          // Show "Sign Up" button for guest users
          if (isGuest)
            TextButton.icon(
              onPressed: () => _showUpgradeDialog(context),
              icon: const Icon(Icons.person_add, color: Colors.white),
              label: Text(l10n.signUp, style: const TextStyle(color: Colors.white)),
            ),
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
            tooltip: l10n.changeViewMode,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
            tooltip: l10n.search,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: l10n.all),
            Tab(text: l10n.favorites),
            Tab(text: l10n.morning),
            Tab(text: l10n.evening),
            Tab(text: l10n.friday),
            Tab(text: l10n.ramadhan),
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
        label: Text(l10n.addToCollection),
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
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
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
            SizedBox(height: r.spaceMedium),
            Text('${l10n.error}: $error'),
            SizedBox(height: r.spaceMedium),
            ElevatedButton(
              onPressed: () => ref.refresh(userCollectionItemsProvider),
              child: Text(l10n.retry),
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
                SizedBox(height: r.spaceMedium),
                Text(
                  category == null
                      ? l10n.yourCollectionIsEmpty
                      : l10n.noItemsInThisCategory,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: r.spaceSmall),
                Text(
                  l10n.addDuasSurahsZiyarats,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                ),
                SizedBox(height: r.spaceLarge),
                ElevatedButton.icon(
                  onPressed: () => _showAddDialog(context),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.addItem),
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
    final r = context.responsive;
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userCollectionItemsProvider);
      },
      child: ListView.builder(
        padding: EdgeInsets.all(r.paddingMedium),
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
    final r = context.responsive;
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userCollectionItemsProvider);
      },
      child: GridView.builder(
        padding: EdgeInsets.all(r.paddingMedium),
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
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final favoritesAsync = ref.watch(favoriteCollectionItemsProvider);
    final viewMode = ref.watch(collectionViewModeProvider);

    return favoritesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
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
                SizedBox(height: r.spaceMedium),
                Text(
                  l10n.noFavoritesYet,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: r.spaceSmall),
                Text(
                  l10n.tapStarIconToAdd,
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.searchCollection),
        content: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: l10n.searchByTitleTextTags,
            prefixIcon: const Icon(Icons.search),
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
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(collectionSearchQueryProvider.notifier).state =
                  _searchController.text;
              Navigator.of(context).pop();
              _showSearchResults(context);
            },
            child: Text(l10n.search),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteItem),
        content: Text(l10n.areYouSureDeleteItem(item.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(deleteCollectionItemProvider(item.id));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.itemDeleted)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  /// Show upgrade dialog for guest users
  void _showUpgradeDialog(BuildContext context) async {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final guestService = ref.read(guestAccessServiceProvider);
    final upgradeMessage = await guestService.getUpgradeMessage();
    final stats = await guestService.getGuestStats();

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.upgrade,
              color: Theme.of(context).colorScheme.primary,
              size: 32,
            ),
            SizedBox(width: r.spaceSmall),
            Text(l10n.createAccount),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              upgradeMessage,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: r.spaceMedium),
            if (stats.itemsCreated > 0) ...[
              _buildStatRow(
                context,
                Icons.collections_bookmark,
                l10n.itemsSaved(stats.itemsCreated),
              ),
              SizedBox(height: r.spaceSmall),
            ],
            if (stats.daysSinceCreation > 0) ...[
              _buildStatRow(
                context,
                Icons.calendar_today,
                l10n.daysAsGuest(stats.daysSinceCreation),
              ),
              SizedBox(height: r.spaceMedium),
            ],
            const Divider(),
            SizedBox(height: r.spaceMedium),
            Text(
              l10n.benefitsOfAccount,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: r.spaceSmall),
            _buildBenefitRow(context, l10n.syncAcrossDevices),
            _buildBenefitRow(context, l10n.neverLoseData),
            _buildBenefitRow(context, l10n.accessFromAllDevices),
            _buildBenefitRow(context, l10n.backupAndRestore),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.maybeLater),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            },
            child: Text(l10n.createAccount),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, IconData icon, String text) {
    final r = context.responsive;
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.secondary),
        SizedBox(width: r.spaceSmall),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildBenefitRow(BuildContext context, String text) {
    final r = context.responsive;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: r.spaceSmall),
          Text(text, style: Theme.of(context).textTheme.bodySmall),
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
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final searchQuery = ref.watch(collectionSearchQueryProvider);
    final searchResultsAsync =
        ref.watch(searchCollectionItemsProvider(searchQuery));

    return searchResultsAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(
          title: Text(l10n.searchCollection),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: Text(l10n.searchCollection),
        ),
        body: Center(child: Text('${l10n.error}: $error')),
      ),
      data: (items) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.searchResults(items.length, searchQuery)),
          ),
          body: items.isEmpty
              ? Center(
                  child: Text(l10n.noResultsFound),
                )
              : ListView.builder(
            padding: EdgeInsets.all(r.paddingMedium),
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
          ),
        );
      },
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
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.paddingMedium),
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
              SizedBox(height: r.spaceMedium),
            ],
            Text(
              item.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: r.spaceLarge),
            // Arabic text
            Container(
              padding: EdgeInsets.all(r.paddingMedium),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(r.radiusMedium),
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
              SizedBox(height: r.spaceLarge),
              Text(
                l10n.translation,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: r.spaceSmall),
              Text(
                item.translation!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
            if (item.transliteration != null) ...[
              SizedBox(height: r.spaceLarge),
              Text(
                l10n.transliteration,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: r.spaceSmall),
              Text(
                item.transliteration!,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
            if (item.sourceReference != null) ...[
              SizedBox(height: r.spaceLarge),
              Row(
                children: [
                  const Icon(Icons.source, size: 20),
                  SizedBox(width: r.spaceSmall),
                  Text(
                    item.sourceReference!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
            if (item.notes != null && item.notes!.isNotEmpty) ...[
              SizedBox(height: r.spaceLarge),
              Text(
                l10n.notes,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: r.spaceSmall),
              Text(
                item.notes!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            if (item.tags.isNotEmpty) ...[
              SizedBox(height: r.spaceLarge),
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
