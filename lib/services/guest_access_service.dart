import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service to handle anonymous (guest) authentication and account linking
class GuestAccessService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sign in as a guest (anonymous user)
  /// Returns the user credential
  Future<UserCredential> signInAsGuest() async {
    try {
      final userCredential = await _auth.signInAnonymously();

      // Track when user started as guest
      await _trackGuestSignIn(userCredential.user!);

      return userCredential;
    } catch (e) {
      throw Exception('Failed to sign in as guest: $e');
    }
  }

  /// Check if current user is a guest
  bool get isGuestUser {
    final user = _auth.currentUser;
    return user != null && user.isAnonymous;
  }

  /// Get current user or null
  User? get currentUser => _auth.currentUser;

  /// Link anonymous account to email/password
  /// This converts the guest account to a permanent account
  Future<UserCredential> linkToEmailAccount({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is signed in');
    }

    if (!user.isAnonymous) {
      throw Exception('User is already a permanent account');
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      final userCredential = await user.linkWithCredential(credential);

      // Track successful conversion
      await _trackGuestConversion('email');

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception(
          'This email is already registered. Please sign in instead.',
        );
      } else if (e.code == 'invalid-email') {
        throw Exception('Invalid email address');
      } else if (e.code == 'weak-password') {
        throw Exception('Password is too weak');
      }
      throw Exception('Failed to link account: ${e.message}');
    }
  }

  /// Link anonymous account to Google account
  Future<UserCredential> linkToGoogleAccount(AuthCredential googleCredential) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is signed in');
    }

    if (!user.isAnonymous) {
      throw Exception('User is already a permanent account');
    }

    try {
      final userCredential = await user.linkWithCredential(googleCredential);

      // Track successful conversion
      await _trackGuestConversion('google');

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        throw Exception(
          'This Google account is already linked to another user.',
        );
      }
      throw Exception('Failed to link Google account: ${e.message}');
    }
  }

  /// Link anonymous account to Apple account
  Future<UserCredential> linkToAppleAccount(AuthCredential appleCredential) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is signed in');
    }

    if (!user.isAnonymous) {
      throw Exception('User is already a permanent account');
    }

    try {
      final userCredential = await user.linkWithCredential(appleCredential);

      // Track successful conversion
      await _trackGuestConversion('apple');

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        throw Exception(
          'This Apple account is already linked to another user.',
        );
      }
      throw Exception('Failed to link Apple account: ${e.message}');
    }
  }

  /// Get guest session statistics
  Future<GuestSessionStats> getGuestStats() async {
    final user = _auth.currentUser;

    if (user == null || !user.isAnonymous) {
      return GuestSessionStats.empty();
    }

    try {
      // Get guest metadata
      final metadataDoc = await _firestore
          .collection('guest_metadata')
          .doc(user.uid)
          .get();

      if (!metadataDoc.exists) {
        return GuestSessionStats.empty();
      }

      final data = metadataDoc.data()!;
      final createdAt = (data['created_at'] as Timestamp).toDate();
      final daysSinceCreation = DateTime.now().difference(createdAt).inDays;

      // Get collection item count
      final collectionSnapshot = await _firestore
          .collection('collection_items')
          .where('user_id', isEqualTo: user.uid)
          .count()
          .get();

      return GuestSessionStats(
        daysSinceCreation: daysSinceCreation,
        itemsCreated: collectionSnapshot.count,
        firstSignIn: createdAt,
      );
    } catch (e) {
      return GuestSessionStats.empty();
    }
  }

  /// Check if user should be prompted to create account
  /// Returns true if user has been guest for a while or created many items
  Future<bool> shouldPromptUpgrade() async {
    if (!isGuestUser) return false;

    final stats = await getGuestStats();

    // Prompt if:
    // - Been guest for 3+ days
    // - Created 10+ items
    // - Created 5+ items and been guest for 1+ day
    return stats.daysSinceCreation >= 3 ||
        stats.itemsCreated >= 10 ||
        (stats.itemsCreated >= 5 && stats.daysSinceCreation >= 1);
  }

  /// Get personalized upgrade message based on usage
  Future<String> getUpgradeMessage() async {
    final stats = await getGuestStats();

    if (stats.itemsCreated >= 10) {
      return 'You\'ve saved ${stats.itemsCreated} items! Create an account to never lose them.';
    } else if (stats.daysSinceCreation >= 7) {
      return 'You\'ve been with us for ${stats.daysSinceCreation} days! Secure your data with an account.';
    } else if (stats.itemsCreated >= 5) {
      return 'Sign up to sync your ${stats.itemsCreated} items across all devices!';
    } else {
      return 'Create an account to save your collection permanently!';
    }
  }

  /// Track when user signs in as guest
  Future<void> _trackGuestSignIn(User user) async {
    try {
      await _firestore.collection('guest_metadata').doc(user.uid).set({
        'user_id': user.uid,
        'created_at': FieldValue.serverTimestamp(),
        'is_guest': true,
      });
    } catch (e) {
      // Non-critical, don't throw
      print('Failed to track guest sign-in: $e');
    }
  }

  /// Track when guest converts to permanent account
  Future<void> _trackGuestConversion(String method) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final metadataDoc = await _firestore
          .collection('guest_metadata')
          .doc(user.uid)
          .get();

      if (metadataDoc.exists) {
        final createdAt = metadataDoc.data()?['created_at'] as Timestamp?;
        final daysSinceCreation = createdAt != null
            ? DateTime.now().difference(createdAt.toDate()).inDays
            : 0;

        // Get item count
        final collectionSnapshot = await _firestore
            .collection('collection_items')
            .where('user_id', isEqualTo: user.uid)
            .count()
            .get();

        // Update metadata
        await _firestore.collection('guest_metadata').doc(user.uid).update({
          'converted_at': FieldValue.serverTimestamp(),
          'conversion_method': method,
          'days_as_guest': daysSinceCreation,
          'items_at_conversion': collectionSnapshot.count,
          'is_guest': false,
        });
      }
    } catch (e) {
      // Non-critical, don't throw
      print('Failed to track guest conversion: $e');
    }
  }

  /// Delete guest account and all associated data
  Future<void> deleteGuestAccount() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is signed in');
    }

    if (!user.isAnonymous) {
      throw Exception('Can only delete guest accounts this way');
    }

    try {
      // Delete all user data
      await _deleteUserData(user.uid);

      // Delete the user account
      await user.delete();
    } catch (e) {
      throw Exception('Failed to delete guest account: $e');
    }
  }

  /// Delete all user data from Firestore
  Future<void> _deleteUserData(String userId) async {
    final batch = _firestore.batch();

    // Delete collection items
    final collectionItems = await _firestore
        .collection('collection_items')
        .where('user_id', isEqualTo: userId)
        .get();
    for (final doc in collectionItems.docs) {
      batch.delete(doc.reference);
    }

    // Delete reminders
    final reminders = await _firestore
        .collection('reminders')
        .where('user_id', isEqualTo: userId)
        .get();
    for (final doc in reminders.docs) {
      batch.delete(doc.reference);
    }

    // Delete habit trackers
    final habits = await _firestore
        .collection('habit_trackers')
        .where('user_id', isEqualTo: userId)
        .get();
    for (final doc in habits.docs) {
      batch.delete(doc.reference);
    }

    // Delete checklist items
    final checklists = await _firestore
        .collection('checklist_items')
        .where('user_id', isEqualTo: userId)
        .get();
    for (final doc in checklists.docs) {
      batch.delete(doc.reference);
    }

    // Delete metadata
    batch.delete(_firestore.collection('guest_metadata').doc(userId));

    await batch.commit();
  }
}

/// Statistics about a guest user's session
class GuestSessionStats {
  final int daysSinceCreation;
  final int itemsCreated;
  final DateTime? firstSignIn;

  const GuestSessionStats({
    required this.daysSinceCreation,
    required this.itemsCreated,
    this.firstSignIn,
  });

  factory GuestSessionStats.empty() {
    return const GuestSessionStats(
      daysSinceCreation: 0,
      itemsCreated: 0,
      firstSignIn: null,
    );
  }

  bool get isEmpty => daysSinceCreation == 0 && itemsCreated == 0;
}
