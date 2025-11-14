import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/collection/habit_tracker.dart';
import '../../providers/collection_providers.dart';

/// Widget to display daily checklist with completion tracking
class ChecklistViewWidget extends ConsumerWidget {
  const ChecklistViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checklistItemsAsync = ref.watch(todayChecklistItemsProvider);
    final completionStatsAsync = ref.watch(todayCompletionStatsProvider);

    return Column(
      children: [
        // Stats header
        completionStatsAsync.when(
          loading: () => const LinearProgressIndicator(),
          error: (error, stack) => const SizedBox.shrink(),
          data: (stats) => _buildStatsHeader(context, stats),
        ),
        // Checklist items
        Expanded(
          child: checklistItemsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
            data: (items) {
              if (items.isEmpty) {
                return _buildEmptyState(context);
              }
              return _buildChecklistItems(context, ref, items);
            },
          ),
        ),
      ],
    );
  }

  /// Build stats header
  Widget _buildStatsHeader(BuildContext context, Map<String, dynamic> stats) {
    final totalItems = stats['total_items'] as int;
    final completedItems = stats['completed_items'] as int;
    final percentage = stats['completion_percentage'] as double;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Progress',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completedItems of $totalItems completed',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              CircularProgressIndicator(
                value: percentage / 100,
                backgroundColor:
                    Theme.of(context).colorScheme.surface.withOpacity(0.3),
                strokeWidth: 8,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8,
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${percentage.toStringAsFixed(0)}% Complete',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  /// Build checklist items
  Widget _buildChecklistItems(
    BuildContext context,
    WidgetRef ref,
    List<ChecklistItem> items,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: CheckboxListTile(
            title: Text(
              item.title,
              style: TextStyle(
                decoration: item.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: item.isCompleted
                    ? Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6)
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: item.arabicTitle != null
                ? Text(
                    item.arabicTitle!,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      decoration: item.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: item.isCompleted
                          ? Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6)
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                    textDirection: TextDirection.rtl,
                  )
                : null,
            value: item.isCompleted,
            onChanged: (value) {
              if (value != null) {
                ref.read(toggleChecklistItemCompletionProvider(
                  (itemId: item.id, isCompleted: value),
                ));
              }
            },
            secondary: item.isCompleted
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Theme.of(context).colorScheme.outline,
                  ),
          ),
        );
      },
    );
  }

  /// Build empty state
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist,
            size: 80,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No items in today\'s checklist',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Add items from your collection to track daily',
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
}
