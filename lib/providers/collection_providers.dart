import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/collection/collection_item.dart';
import '../models/collection/reminder.dart';
import '../models/collection/habit_tracker.dart';
import '../repositories/collection_repository.dart';

// ===== Repository Provider =====

/// Collection repository provider
final collectionRepositoryProvider = Provider<CollectionRepository>((ref) {
  return CollectionRepository();
});

// ===== Collection Items Providers =====

/// Get all collection items for the current user
final userCollectionItemsProvider =
    FutureProvider.autoDispose<List<CollectionItem>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getUserCollectionItems();
});

/// Get collection items by category
final collectionItemsByCategoryProvider = FutureProvider.autoDispose
    .family<List<CollectionItem>, CollectionCategory>((ref, category) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getCollectionItemsByCategory(category);
});

/// Get collection items by type
final collectionItemsByTypeProvider = FutureProvider.autoDispose
    .family<List<CollectionItem>, CollectionItemType>((ref, type) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getCollectionItemsByType(type);
});

/// Get favorite collection items
final favoriteCollectionItemsProvider =
    FutureProvider.autoDispose<List<CollectionItem>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getFavoriteCollectionItems();
});

/// Get recently accessed collection items
final recentlyAccessedItemsProvider = FutureProvider.autoDispose
    .family<List<CollectionItem>, int>((ref, limit) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getRecentlyAccessedItems(limit: limit);
});

/// Search collection items
final searchCollectionItemsProvider =
    FutureProvider.autoDispose.family<List<CollectionItem>, String>(
        (ref, query) async {
  if (query.isEmpty) return [];

  final repository = ref.watch(collectionRepositoryProvider);
  return repository.searchCollectionItems(query);
});

// ===== Selected Category Provider =====

/// Currently selected category for filtering
final selectedCategoryProvider =
    StateProvider<CollectionCategory?>((ref) => null);

/// Currently selected type for filtering
final selectedTypeProvider = StateProvider<CollectionItemType?>((ref) => null);

/// Search query provider
final collectionSearchQueryProvider = StateProvider<String>((ref) => '');

// ===== Collection Actions =====

/// Add a collection item
final addCollectionItemProvider =
    FutureProvider.autoDispose.family<String, CollectionItem>(
        (ref, item) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final id = await repository.addCollectionItem(item);

  // Invalidate the collection items list to refresh
  ref.invalidate(userCollectionItemsProvider);

  return id;
});

/// Update a collection item
final updateCollectionItemProvider =
    FutureProvider.autoDispose.family<void, CollectionItem>((ref, item) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.updateCollectionItem(item);

  // Invalidate the collection items list to refresh
  ref.invalidate(userCollectionItemsProvider);
});

/// Delete a collection item
final deleteCollectionItemProvider =
    FutureProvider.autoDispose.family<void, String>((ref, itemId) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.deleteCollectionItem(itemId);

  // Invalidate the collection items list to refresh
  ref.invalidate(userCollectionItemsProvider);
});

/// Toggle favorite status
final toggleFavoriteProvider = FutureProvider.autoDispose
    .family<void, ({String itemId, bool isFavorite})>((ref, params) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.toggleFavorite(params.itemId, params.isFavorite);

  // Invalidate the collection items list to refresh
  ref.invalidate(userCollectionItemsProvider);
  ref.invalidate(favoriteCollectionItemsProvider);
});

// ===== Reminders Providers =====

/// Get reminders for a specific collection item
final remindersForItemProvider = FutureProvider.autoDispose
    .family<List<Reminder>, String>((ref, collectionItemId) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getRemindersForItem(collectionItemId);
});

/// Get all active reminders for the user
final activeRemindersProvider =
    FutureProvider.autoDispose<List<Reminder>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getActiveReminders();
});

/// Add a reminder
final addReminderProvider =
    FutureProvider.autoDispose.family<String, Reminder>((ref, reminder) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final id = await repository.addReminder(reminder);

  // Invalidate reminders list to refresh
  ref.invalidate(activeRemindersProvider);

  return id;
});

/// Update a reminder
final updateReminderProvider =
    FutureProvider.autoDispose.family<void, Reminder>((ref, reminder) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.updateReminder(reminder);

  // Invalidate reminders list to refresh
  ref.invalidate(activeRemindersProvider);
});

/// Delete a reminder
final deleteReminderProvider =
    FutureProvider.autoDispose.family<void, String>((ref, reminderId) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.deleteReminder(reminderId);

  // Invalidate reminders list to refresh
  ref.invalidate(activeRemindersProvider);
});

/// Toggle reminder enabled status
final toggleReminderEnabledProvider = FutureProvider.autoDispose
    .family<void, ({String reminderId, bool isEnabled})>((ref, params) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.toggleReminderEnabled(params.reminderId, params.isEnabled);

  // Invalidate reminders list to refresh
  ref.invalidate(activeRemindersProvider);
});

// ===== Habit Trackers Providers =====

/// Get habit tracker for a specific collection item
final habitTrackerForItemProvider = FutureProvider.autoDispose
    .family<HabitTracker?, String>((ref, collectionItemId) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getHabitTrackerForItem(collectionItemId);
});

/// Get all habit trackers for the user
final allHabitTrackersProvider =
    FutureProvider.autoDispose<List<HabitTracker>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getAllHabitTrackers();
});

/// Add a habit tracker
final addHabitTrackerProvider = FutureProvider.autoDispose
    .family<String, HabitTracker>((ref, tracker) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final id = await repository.addHabitTracker(tracker);

  // Invalidate habit trackers list to refresh
  ref.invalidate(allHabitTrackersProvider);

  return id;
});

/// Update a habit tracker
final updateHabitTrackerProvider = FutureProvider.autoDispose
    .family<void, HabitTracker>((ref, tracker) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.updateHabitTracker(tracker);

  // Invalidate habit trackers list to refresh
  ref.invalidate(allHabitTrackersProvider);
});

/// Increment habit count
final incrementHabitCountProvider =
    FutureProvider.autoDispose.family<void, String>((ref, trackerId) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.incrementHabitCount(trackerId);

  // Invalidate habit trackers list to refresh
  ref.invalidate(allHabitTrackersProvider);
});

/// Delete a habit tracker
final deleteHabitTrackerProvider =
    FutureProvider.autoDispose.family<void, String>((ref, trackerId) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.deleteHabitTracker(trackerId);

  // Invalidate habit trackers list to refresh
  ref.invalidate(allHabitTrackersProvider);
});

// ===== Checklist Items Providers =====

/// Get checklist items for today
final todayChecklistItemsProvider =
    FutureProvider.autoDispose<List<ChecklistItem>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final today = DateTime.now().toIso8601String().split('T')[0];
  return repository.getChecklistItemsForDate(today);
});

/// Get checklist items for a specific date
final checklistItemsForDateProvider = FutureProvider.autoDispose
    .family<List<ChecklistItem>, String>((ref, date) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getChecklistItemsForDate(date);
});

/// Add a checklist item
final addChecklistItemProvider = FutureProvider.autoDispose
    .family<String, ChecklistItem>((ref, item) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final id = await repository.addChecklistItem(item);

  // Invalidate checklist items to refresh
  ref.invalidate(todayChecklistItemsProvider);

  return id;
});

/// Toggle checklist item completion
final toggleChecklistItemCompletionProvider = FutureProvider.autoDispose
    .family<void, ({String itemId, bool isCompleted})>((ref, params) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.toggleChecklistItemCompletion(
      params.itemId, params.isCompleted);

  // Invalidate checklist items to refresh
  ref.invalidate(todayChecklistItemsProvider);
});

/// Delete a checklist item
final deleteChecklistItemProvider =
    FutureProvider.autoDispose.family<void, String>((ref, itemId) async {
  final repository = ref.watch(collectionRepositoryProvider);
  await repository.deleteChecklistItem(itemId);

  // Invalidate checklist items to refresh
  ref.invalidate(todayChecklistItemsProvider);
});

// ===== Statistics Providers =====

/// Get completion statistics for a date range
final completionStatsProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, ({DateTime start, DateTime end})>(
        (ref, params) async {
  final repository = ref.watch(collectionRepositoryProvider);
  return repository.getCompletionStats(params.start, params.end);
});

/// Get today's completion stats
final todayCompletionStatsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final today = DateTime.now();
  final startOfDay = DateTime(today.year, today.month, today.day);
  final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);
  return repository.getCompletionStats(startOfDay, endOfDay);
});

/// Get this week's completion stats
final weekCompletionStatsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));
  return repository.getCompletionStats(startOfWeek, endOfWeek);
});

/// Get this month's completion stats
final monthCompletionStatsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(collectionRepositoryProvider);
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 0);
  return repository.getCompletionStats(startOfMonth, endOfMonth);
});

// ===== UI State Providers =====

/// Currently viewing checklist date
final selectedChecklistDateProvider = StateProvider<String>((ref) {
  return DateTime.now().toIso8601String().split('T')[0];
});

/// Show completed items in checklist
final showCompletedItemsProvider = StateProvider<bool>((ref) => true);

/// Current view mode (list, grid, checklist)
final collectionViewModeProvider =
    StateProvider<String>((ref) => 'list'); // list, grid, checklist

/// Sort order for collection items
final collectionSortOrderProvider =
    StateProvider<String>((ref) => 'date'); // date, title, category, favorite
