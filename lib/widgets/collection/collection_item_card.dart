import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/collection/collection_item.dart';

/// Card widget to display a collection item
class CollectionItemCard extends StatelessWidget {
  final CollectionItem item;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onDelete;
  final bool isGridView;

  const CollectionItemCard({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.onDelete,
    this.isGridView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      return _buildGridCard(context);
    }

    return _buildListCard(context);
  }

  /// Build list card with swipe actions
  Widget _buildListCard(BuildContext context) {
    return Slidable(
      key: ValueKey(item.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onFavoriteToggle(),
            backgroundColor: item.isFavorite ? Colors.grey : Colors.amber,
            foregroundColor: Colors.white,
            icon: item.isFavorite ? Icons.star_border : Icons.star,
            label: item.isFavorite ? 'Unfavorite' : 'Favorite',
          ),
          SlidableAction(
            onPressed: (context) => onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Type icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getTypeColor(context).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getTypeIcon(),
                        size: 20,
                        color: _getTypeColor(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item.getCategoryName(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.getTypeName(),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Favorite icon
                    IconButton(
                      icon: Icon(
                        item.isFavorite ? Icons.star : Icons.star_border,
                        color: item.isFavorite ? Colors.amber : Colors.grey,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Arabic text preview
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.textPreview,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Amiri',
                          height: 1.8,
                        ),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Tags
                if (item.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: item.tags.take(3).map((tag) {
                      return Chip(
                        label: Text(tag),
                        labelStyle: Theme.of(context).textTheme.labelSmall,
                        visualDensity: VisualDensity.compact,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      );
                    }).toList(),
                  ),
                ],
                // Additional info
                if (item.sourceReference != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.source,
                        size: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.sourceReference!,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build grid card
  Widget _buildGridCard(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with type and favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTypeColor(context).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTypeIcon(),
                      size: 20,
                      color: _getTypeColor(context),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      item.isFavorite ? Icons.star : Icons.star_border,
                      color: item.isFavorite ? Colors.amber : Colors.grey,
                    ),
                    onPressed: onFavoriteToggle,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.getCategoryName(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              // Arabic text preview
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.textPreview,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'Amiri',
                        height: 1.6,
                      ),
                  textDirection: TextDirection.rtl,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get icon for collection item type
  IconData _getTypeIcon() {
    switch (item.type) {
      case CollectionItemType.dua:
        return Icons.hands_home_work;
      case CollectionItemType.surah:
        return Icons.menu_book;
      case CollectionItemType.ayah:
        return Icons.article;
      case CollectionItemType.ziyarat:
        return Icons.place;
      case CollectionItemType.hadith:
        return Icons.format_quote;
      case CollectionItemType.passage:
        return Icons.description;
      case CollectionItemType.dhikr:
        return Icons.refresh;
      case CollectionItemType.custom:
        return Icons.note;
    }
  }

  /// Get color for collection item type
  Color _getTypeColor(BuildContext context) {
    switch (item.type) {
      case CollectionItemType.dua:
        return Colors.blue;
      case CollectionItemType.surah:
        return Colors.green;
      case CollectionItemType.ayah:
        return Colors.teal;
      case CollectionItemType.ziyarat:
        return Colors.purple;
      case CollectionItemType.hadith:
        return Colors.orange;
      case CollectionItemType.passage:
        return Colors.brown;
      case CollectionItemType.dhikr:
        return Colors.indigo;
      case CollectionItemType.custom:
        return Colors.grey;
    }
  }
}
