import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/purchase/purchase_history.dart';

/// Repository for managing purchase data in Firestore
class PurchaseRepository {
  final FirebaseFirestore _firestore;

  PurchaseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _purchaseHistoryCollection =>
      _firestore.collection('purchase_history');
  CollectionReference get _userSubscriptionsCollection =>
      _firestore.collection('user_subscriptions');
  CollectionReference get _purchaseEventsCollection =>
      _firestore.collection('purchase_events');

  /// Save purchase to history
  Future<void> savePurchaseHistory(PurchaseHistory purchase) async {
    try {
      await _purchaseHistoryCollection.doc(purchase.id).set(
            purchase.toJson(),
            SetOptions(merge: true),
          );
      debugPrint('Purchase history saved: ${purchase.id}');
    } catch (e) {
      debugPrint('Error saving purchase history: $e');
      rethrow;
    }
  }

  /// Get user's purchase history
  Stream<List<PurchaseHistory>> getUserPurchaseHistory(String userId) {
    return _purchaseHistoryCollection
        .where('userId', isEqualTo: userId)
        .orderBy('purchaseDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PurchaseHistory.fromJson(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
    });
  }

  /// Get specific purchase by ID
  Future<PurchaseHistory?> getPurchaseById(String purchaseId) async {
    try {
      final doc = await _purchaseHistoryCollection.doc(purchaseId).get();
      if (!doc.exists) return null;

      return PurchaseHistory.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error getting purchase: $e');
      return null;
    }
  }

  /// Update purchase status
  Future<void> updatePurchaseStatus(
    String purchaseId,
    PurchaseStatus status, {
    DateTime? cancellationDate,
    String? cancellationReason,
  }) async {
    try {
      final Map<String, dynamic> updates = {
        'status': status.name,
      };

      if (cancellationDate != null) {
        updates['cancellationDate'] = Timestamp.fromDate(cancellationDate);
      }
      if (cancellationReason != null) {
        updates['cancellationReason'] = cancellationReason;
      }

      await _purchaseHistoryCollection.doc(purchaseId).update(updates);
      debugPrint('Purchase status updated: $purchaseId -> $status');
    } catch (e) {
      debugPrint('Error updating purchase status: $e');
      rethrow;
    }
  }

  /// Save/Update user subscription status
  Future<void> saveUserSubscription(UserSubscription subscription) async {
    try {
      await _userSubscriptionsCollection.doc(subscription.userId).set(
            subscription.toJson(),
            SetOptions(merge: true),
          );
      debugPrint('User subscription saved: ${subscription.userId}');
    } catch (e) {
      debugPrint('Error saving user subscription: $e');
      rethrow;
    }
  }

  /// Get user subscription status
  Future<UserSubscription?> getUserSubscription(String userId) async {
    try {
      final doc = await _userSubscriptionsCollection.doc(userId).get();
      if (!doc.exists) {
        // Return default non-premium status
        return UserSubscription(
          userId: userId,
          isPremium: false,
        );
      }

      return UserSubscription.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error getting user subscription: $e');
      return null;
    }
  }

  /// Stream user subscription status
  Stream<UserSubscription?> streamUserSubscription(String userId) {
    return _userSubscriptionsCollection
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return UserSubscription(
          userId: userId,
          isPremium: false,
        );
      }
      return UserSubscription.fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }

  /// Log purchase event
  Future<void> logPurchaseEvent(PurchaseEvent event) async {
    try {
      await _purchaseEventsCollection.add(event.toJson());
      debugPrint('Purchase event logged: ${event.eventType}');
    } catch (e) {
      debugPrint('Error logging purchase event: $e');
    }
  }

  /// Get user's purchase events
  Stream<List<PurchaseEvent>> getUserPurchaseEvents(
    String userId, {
    int limit = 50,
  }) {
    return _purchaseEventsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PurchaseEvent.fromJson(
                {
                  'id': doc.id,
                  ...doc.data() as Map<String, dynamic>,
                },
              ))
          .toList();
    });
  }

  /// Get active subscriptions count
  Future<int> getActiveSubscriptionsCount() async {
    try {
      final snapshot = await _userSubscriptionsCollection
          .where('isPremium', isEqualTo: true)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      debugPrint('Error getting active subscriptions count: $e');
      return 0;
    }
  }

  /// Get total revenue (approximate from purchase history)
  Future<double> getTotalRevenue() async {
    try {
      final snapshot = await _purchaseHistoryCollection
          .where('status', whereIn: [PurchaseStatus.active.name])
          .get();

      double total = 0;
      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        total += (data['price'] as num?)?.toDouble() ?? 0;
      }

      return total;
    } catch (e) {
      debugPrint('Error calculating total revenue: $e');
      return 0;
    }
  }

  /// Get user's lifetime value
  Future<double> getUserLifetimeValue(String userId) async {
    try {
      final snapshot = await _purchaseHistoryCollection
          .where('userId', isEqualTo: userId)
          .where('status', whereIn: [
        PurchaseStatus.active.name,
        PurchaseStatus.expired.name
      ]).get();

      double total = 0;
      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        total += (data['price'] as num?)?.toDouble() ?? 0;
      }

      return total;
    } catch (e) {
      debugPrint('Error calculating user lifetime value: $e');
      return 0;
    }
  }

  /// Check if purchase exists
  Future<bool> purchaseExists(String transactionId) async {
    try {
      final snapshot = await _purchaseHistoryCollection
          .where('transactionId', isEqualTo: transactionId)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking purchase existence: $e');
      return false;
    }
  }

  /// Get purchases by product ID
  Future<List<PurchaseHistory>> getPurchasesByProduct(
    String userId,
    String productId,
  ) async {
    try {
      final snapshot = await _purchaseHistoryCollection
          .where('userId', isEqualTo: userId)
          .where('productId', isEqualTo: productId)
          .orderBy('purchaseDate', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => PurchaseHistory.fromJson(
                doc.data() as Map<String, dynamic>,
              ))
          .toList();
    } catch (e) {
      debugPrint('Error getting purchases by product: $e');
      return [];
    }
  }

  /// Update subscription expiry
  Future<void> updateSubscriptionExpiry(
    String userId,
    DateTime? expiryDate,
    bool willRenew,
  ) async {
    try {
      await _userSubscriptionsCollection.doc(userId).update({
        'subscriptionExpiryDate':
            expiryDate != null ? Timestamp.fromDate(expiryDate) : null,
        'willRenew': willRenew,
        'isPremium': expiryDate != null && expiryDate.isAfter(DateTime.now()),
      });
      debugPrint('Subscription expiry updated for user: $userId');
    } catch (e) {
      debugPrint('Error updating subscription expiry: $e');
      rethrow;
    }
  }

  /// Delete old events (cleanup)
  Future<void> deleteOldEvents({int daysToKeep = 90}) async {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));
      final snapshot = await _purchaseEventsCollection
          .where('timestamp', isLessThan: Timestamp.fromDate(cutoffDate))
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      debugPrint('Deleted ${snapshot.docs.length} old events');
    } catch (e) {
      debugPrint('Error deleting old events: $e');
    }
  }
}
