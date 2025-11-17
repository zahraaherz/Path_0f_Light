import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/collection/collection_item.dart';
import '../models/collection/reminder.dart';
import '../models/collection/habit_tracker.dart';

/// Repository for managing user's personal collection
class CollectionRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // ===== Collections =====
  CollectionReference get _collectionItemsCollection =>
      _firestore.collection('collection_items');
  CollectionReference get _remindersCollection =>
      _firestore.collection('reminders');
  CollectionReference get _habitTrackersCollection =>
      _firestore.collection('habit_trackers');
  CollectionReference get _checklistItemsCollection =>
      _firestore.collection('checklist_items');

  String? get _currentUserId => _auth.currentUser?.uid;

  // ===== Collection Items =====

  /// Get all collection items for current user
  Future<List<CollectionItem>> getUserCollectionItems() async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _collectionItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CollectionItem.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading collection items: $e');
    }
  }

  /// Get collection items by category
  Future<List<CollectionItem>> getCollectionItemsByCategory(
      CollectionCategory category) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _collectionItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('category', isEqualTo: category.name)
          .orderBy('sort_order')
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CollectionItem.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading collection items by category: $e');
    }
  }

  /// Get collection items by type
  Future<List<CollectionItem>> getCollectionItemsByType(
      CollectionItemType type) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _collectionItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('type', isEqualTo: type.name)
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CollectionItem.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading collection items by type: $e');
    }
  }

  /// Get favorite collection items
  Future<List<CollectionItem>> getFavoriteCollectionItems() async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _collectionItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('is_favorite', isEqualTo: true)
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CollectionItem.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading favorite collection items: $e');
    }
  }

  /// Get recently accessed collection items
  Future<List<CollectionItem>> getRecentlyAccessedItems({int limit = 10}) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _collectionItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .orderBy('last_accessed', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CollectionItem.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading recently accessed items: $e');
    }
  }

  /// Search collection items
  Future<List<CollectionItem>> searchCollectionItems(String query) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final queryLower = query.toLowerCase();

      // Get all user's collection items
      final snapshot = await _collectionItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .get();

      final items = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CollectionItem.fromJson({'id': doc.id, ...data});
      }).toList();

      // Filter items based on query
      return items.where((item) {
        final title = item.title.toLowerCase();
        final arabicTitle = item.arabicTitle?.toLowerCase() ?? '';
        final arabicText = item.arabicText.toLowerCase();
        final translation = item.translation?.toLowerCase() ?? '';
        final tags = item.tags.join(' ').toLowerCase();

        return title.contains(queryLower) ||
            arabicTitle.contains(queryLower) ||
            arabicText.contains(queryLower) ||
            translation.contains(queryLower) ||
            tags.contains(queryLower);
      }).toList();
    } catch (e) {
      throw Exception('Error searching collection items: $e');
    }
  }

  /// Add a new collection item
  Future<String> addCollectionItem(CollectionItem item) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final docRef = await _collectionItemsCollection.add({
        ...item.toJson(),
        'user_id': _currentUserId,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error adding collection item: $e');
    }
  }

  /// Update a collection item
  Future<void> updateCollectionItem(CollectionItem item) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _collectionItemsCollection.doc(item.id).update({
        ...item.toJson(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating collection item: $e');
    }
  }

  /// Delete a collection item
  Future<void> deleteCollectionItem(String itemId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      // Delete associated reminders and habit trackers
      await _deleteAssociatedReminders(itemId);
      await _deleteAssociatedHabitTrackers(itemId);

      // Delete the collection item
      await _collectionItemsCollection.doc(itemId).delete();
    } catch (e) {
      throw Exception('Error deleting collection item: $e');
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String itemId, bool isFavorite) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _collectionItemsCollection.doc(itemId).update({
        'is_favorite': isFavorite,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error toggling favorite: $e');
    }
  }

  /// Update last accessed timestamp
  Future<void> updateLastAccessed(String itemId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _collectionItemsCollection.doc(itemId).update({
        'last_accessed': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating last accessed: $e');
    }
  }

  /// Update sort order
  Future<void> updateSortOrder(String itemId, int sortOrder) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _collectionItemsCollection.doc(itemId).update({
        'sort_order': sortOrder,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating sort order: $e');
    }
  }

  // ===== Reminders =====

  /// Get all reminders for a collection item
  Future<List<Reminder>> getRemindersForItem(String collectionItemId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _remindersCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('collection_item_id', isEqualTo: collectionItemId)
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Reminder.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading reminders: $e');
    }
  }

  /// Get all active reminders for the user
  Future<List<Reminder>> getActiveReminders() async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _remindersCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('is_enabled', isEqualTo: true)
          .orderBy('next_trigger')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Reminder.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading active reminders: $e');
    }
  }

  /// Add a new reminder
  Future<String> addReminder(Reminder reminder) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final docRef = await _remindersCollection.add({
        ...reminder.toJson(),
        'user_id': _currentUserId,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error adding reminder: $e');
    }
  }

  /// Update a reminder
  Future<void> updateReminder(Reminder reminder) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _remindersCollection.doc(reminder.id).update({
        ...reminder.toJson(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating reminder: $e');
    }
  }

  /// Delete a reminder
  Future<void> deleteReminder(String reminderId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _remindersCollection.doc(reminderId).delete();
    } catch (e) {
      throw Exception('Error deleting reminder: $e');
    }
  }

  /// Toggle reminder enabled status
  Future<void> toggleReminderEnabled(String reminderId, bool isEnabled) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _remindersCollection.doc(reminderId).update({
        'is_enabled': isEnabled,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error toggling reminder: $e');
    }
  }

  /// Delete all reminders for a collection item
  Future<void> _deleteAssociatedReminders(String collectionItemId) async {
    try {
      final snapshot = await _remindersCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('collection_item_id', isEqualTo: collectionItemId)
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      // Log error but don't throw - this is a cleanup operation
      print('Error deleting associated reminders: $e');
    }
  }

  // ===== Habit Trackers =====

  /// Get habit tracker for a collection item
  Future<HabitTracker?> getHabitTrackerForItem(String collectionItemId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _habitTrackersCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('collection_item_id', isEqualTo: collectionItemId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      final data = snapshot.docs.first.data() as Map<String, dynamic>;
      return HabitTracker.fromJson({'id': snapshot.docs.first.id, ...data});
    } catch (e) {
      throw Exception('Error loading habit tracker: $e');
    }
  }

  /// Get all habit trackers for the user
  Future<List<HabitTracker>> getAllHabitTrackers() async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _habitTrackersCollection
          .where('user_id', isEqualTo: _currentUserId)
          .orderBy('created_at', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return HabitTracker.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading habit trackers: $e');
    }
  }

  /// Add a new habit tracker
  Future<String> addHabitTracker(HabitTracker tracker) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final docRef = await _habitTrackersCollection.add({
        ...tracker.toJson(),
        'user_id': _currentUserId,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error adding habit tracker: $e');
    }
  }

  /// Update a habit tracker
  Future<void> updateHabitTracker(HabitTracker tracker) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _habitTrackersCollection.doc(tracker.id).update({
        ...tracker.toJson(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating habit tracker: $e');
    }
  }

  /// Increment habit count
  Future<void> incrementHabitCount(String trackerId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final doc = await _habitTrackersCollection.doc(trackerId).get();
      if (!doc.exists) throw Exception('Habit tracker not found');

      final data = doc.data() as Map<String, dynamic>;
      final tracker = HabitTracker.fromJson({'id': doc.id, ...data});

      final today = DateTime.now().toIso8601String().split('T')[0];
      final isNewDay = tracker.lastCompletedDate != today;

      // Update streak
      int newStreak = tracker.currentStreak;
      if (isNewDay) {
        final yesterday = DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String()
            .split('T')[0];
        if (tracker.lastCompletedDate == yesterday) {
          newStreak++;
        } else {
          newStreak = 1;
        }
      }

      final newCount = isNewDay ? 1 : tracker.currentCount + 1;
      final completionHistory = [...tracker.completionHistory];
      if (!completionHistory.contains(today)) {
        completionHistory.add(today);
      }

      await _habitTrackersCollection.doc(trackerId).update({
        'current_count': newCount,
        'current_streak': newStreak,
        'longest_streak': newStreak > tracker.longestStreak
            ? newStreak
            : tracker.longestStreak,
        'total_completions': tracker.totalCompletions + 1,
        'is_completed_today': newCount >= tracker.targetCount,
        'last_completed_date': today,
        'completion_history': completionHistory,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error incrementing habit count: $e');
    }
  }

  /// Delete a habit tracker
  Future<void> deleteHabitTracker(String trackerId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _habitTrackersCollection.doc(trackerId).delete();
    } catch (e) {
      throw Exception('Error deleting habit tracker: $e');
    }
  }

  /// Delete all habit trackers for a collection item
  Future<void> _deleteAssociatedHabitTrackers(String collectionItemId) async {
    try {
      final snapshot = await _habitTrackersCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('collection_item_id', isEqualTo: collectionItemId)
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      // Log error but don't throw - this is a cleanup operation
      print('Error deleting associated habit trackers: $e');
    }
  }

  // ===== Checklist Items =====

  /// Get checklist items for a specific date
  Future<List<ChecklistItem>> getChecklistItemsForDate(String date) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final snapshot = await _checklistItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('checklist_date', isEqualTo: date)
          .orderBy('sort_order')
          .orderBy('created_at')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ChecklistItem.fromJson({'id': doc.id, ...data});
      }).toList();
    } catch (e) {
      throw Exception('Error loading checklist items: $e');
    }
  }

  /// Add a checklist item
  Future<String> addChecklistItem(ChecklistItem item) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final docRef = await _checklistItemsCollection.add({
        ...item.toJson(),
        'user_id': _currentUserId,
        'created_at': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error adding checklist item: $e');
    }
  }

  /// Toggle checklist item completion
  Future<void> toggleChecklistItemCompletion(
      String itemId, bool isCompleted) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _checklistItemsCollection.doc(itemId).update({
        'is_completed': isCompleted,
        'completed_at':
            isCompleted ? FieldValue.serverTimestamp() : null,
      });
    } catch (e) {
      throw Exception('Error toggling checklist item: $e');
    }
  }

  /// Delete a checklist item
  Future<void> deleteChecklistItem(String itemId) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      await _checklistItemsCollection.doc(itemId).delete();
    } catch (e) {
      throw Exception('Error deleting checklist item: $e');
    }
  }

  /// Get completion statistics for a date range
  Future<Map<String, dynamic>> getCompletionStats(
      DateTime startDate, DateTime endDate) async {
    if (_currentUserId == null) {
      throw Exception('User must be logged in');
    }

    try {
      final start = startDate.toIso8601String().split('T')[0];
      final end = endDate.toIso8601String().split('T')[0];

      final snapshot = await _checklistItemsCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('checklist_date', isGreaterThanOrEqualTo: start)
          .where('checklist_date', isLessThanOrEqualTo: end)
          .get();

      final items = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ChecklistItem.fromJson({'id': doc.id, ...data});
      }).toList();

      final totalItems = items.length;
      final completedItems = items.where((item) => item.isCompleted).length;
      final completionPercentage =
          totalItems > 0 ? (completedItems / totalItems) * 100 : 0.0;

      return {
        'total_items': totalItems,
        'completed_items': completedItems,
        'completion_percentage': completionPercentage,
        'period_start': startDate,
        'period_end': endDate,
      };
    } catch (e) {
      throw Exception('Error loading completion stats: $e');
    }
  }
}
