import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import '../models/user/user_profile.dart';
import '../models/user/user_role.dart';

/// Exception class for user repository errors
class UserRepositoryException implements Exception {
  final String message;
  final String code;

  UserRepositoryException(this.message, this.code);

  @override
  String toString() => message;
}

/// Repository for managing user profile data and operations
class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final http.Client _httpClient;

  // Cloud Functions base URL - update this with your Firebase project
  static const String _functionsBaseUrl =
      'https://us-central1-YOUR-PROJECT-ID.cloudfunctions.net';

  UserRepository({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
    http.Client? httpClient,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _functions = functions ?? FirebaseFunctions.instance,
        _httpClient = httpClient ?? http.Client();

  /// Get user profile by ID
  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        return null;
      }

      return UserProfile.fromFirestore(doc);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to get user profile: ${e.toString()}',
        'get-profile-failed',
      );
    }
  }

  /// Stream user profile changes
  Stream<UserProfile?> streamUserProfile(String uid) {
    try {
      return _firestore.collection('users').doc(uid).snapshots().map((doc) {
        if (!doc.exists) return null;
        return UserProfile.fromFirestore(doc);
      });
    } catch (e) {
      throw UserRepositoryException(
        'Failed to stream user profile: ${e.toString()}',
        'stream-profile-failed',
      );
    }
  }

  /// Update user profile
  Future<void> updateUserProfile(
    String uid,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update(updates);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update user profile: ${e.toString()}',
        'update-profile-failed',
      );
    }
  }

  /// Update user language preference
  Future<Map<String, dynamic>> updateLanguage(
    String uid,
    String language,
  ) async {
    try {
      final callable = _functions.httpsCallable('updateUserLanguage');
      final result = await callable.call({'language': language});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update language: ${e.toString()}',
        'update-language-failed',
      );
    }
  }

  /// Update email verification status
  Future<void> updateEmailVerificationStatus(String uid, bool verified) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'emailVerified': verified,
      });
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update email verification: ${e.toString()}',
        'update-verification-failed',
      );
    }
  }

  /// Update phone verification status
  Future<void> updatePhoneVerificationStatus(String uid, bool verified) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'phoneVerified': verified,
      });
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update phone verification: ${e.toString()}',
        'update-verification-failed',
      );
    }
  }

  /// Link social provider (Google, Facebook, Apple)
  Future<Map<String, dynamic>> linkSocialProvider(
    String provider,
    String accessToken,
  ) async {
    try {
      final callable = _functions.httpsCallable('linkSocialProvider');
      final result = await callable.call({
        'provider': provider,
        'accessToken': accessToken,
      });
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to link provider: ${e.toString()}',
        'link-provider-failed',
      );
    }
  }

  /// Unlink authentication provider
  Future<Map<String, dynamic>> unlinkProvider(String provider) async {
    try {
      final callable = _functions.httpsCallable('unlinkAuthProvider');
      final result = await callable.call({'provider': provider});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to unlink provider: ${e.toString()}',
        'unlink-provider-failed',
      );
    }
  }

  /// Update user notification settings
  Future<void> updateNotificationSettings(
    String uid,
    NotificationSettings settings,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'settings.notifications': settings.toJson(),
      });
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update notification settings: ${e.toString()}',
        'update-settings-failed',
      );
    }
  }

  /// Update user privacy settings
  Future<void> updatePrivacySettings(
    String uid,
    PrivacySettings settings,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'settings.privacy': settings.toJson(),
      });
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update privacy settings: ${e.toString()}',
        'update-settings-failed',
      );
    }
  }

  /// Update user preferences
  Future<void> updateUserPreferences(
    String uid,
    UserPreferences preferences,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'settings.preferences': preferences.toJson(),
      });
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update preferences: ${e.toString()}',
        'update-preferences-failed',
      );
    }
  }

  /// Get user statistics
  Future<Map<String, dynamic>> getUserStats(String uid) async {
    try {
      final callable = _functions.httpsCallable('getUserStats');
      final result = await callable.call({'userId': uid});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to get user stats: ${e.toString()}',
        'get-stats-failed',
      );
    }
  }

  /// Mark profile as complete
  Future<void> markProfileComplete(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'profileComplete': true,
      });
    } catch (e) {
      throw UserRepositoryException(
        'Failed to mark profile complete: ${e.toString()}',
        'update-profile-failed',
      );
    }
  }

  /// Update last active timestamp
  Future<void> updateLastActive(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'lastActive': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Silently fail for last active updates
      print('Failed to update last active: $e');
    }
  }

  /// Update daily login streak
  Future<Map<String, dynamic>> updateDailyLogin() async {
    try {
      final callable = _functions.httpsCallable('updateDailyLogin');
      final result = await callable.call({});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update daily login: ${e.toString()}',
        'update-login-failed',
      );
    }
  }

  // Admin functions (require admin role)

  /// Get all users (admin only)
  Future<List<UserProfile>> getAllUsers({
    int limit = 50,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = _firestore.collection('users').limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => UserProfile.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw UserRepositoryException(
        'Failed to get users: ${e.toString()}',
        'get-users-failed',
      );
    }
  }

  /// Update user role (admin only)
  Future<Map<String, dynamic>> updateUserRole(
    String targetUserId,
    UserRole newRole,
  ) async {
    try {
      final callable = _functions.httpsCallable('updateUserRole');
      final result = await callable.call({
        'targetUserId': targetUserId,
        'newRole': newRole.value,
      });
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to update user role: ${e.toString()}',
        'update-role-failed',
      );
    }
  }

  /// Suspend user account (admin only)
  Future<Map<String, dynamic>> suspendUser(
    String targetUserId,
    String reason,
  ) async {
    try {
      final callable = _functions.httpsCallable('suspendUser');
      final result = await callable.call({
        'targetUserId': targetUserId,
        'reason': reason,
      });
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to suspend user: ${e.toString()}',
        'suspend-user-failed',
      );
    }
  }

  /// Reactivate user account (admin only)
  Future<Map<String, dynamic>> reactivateUser(String targetUserId) async {
    try {
      final callable = _functions.httpsCallable('reactivateUser');
      final result = await callable.call({'targetUserId': targetUserId});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to reactivate user: ${e.toString()}',
        'reactivate-user-failed',
      );
    }
  }

  /// Delete user account permanently (admin only)
  Future<Map<String, dynamic>> deleteUserAccount(String targetUserId) async {
    try {
      final callable = _functions.httpsCallable('deleteUserAccount');
      final result = await callable.call({'targetUserId': targetUserId});
      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to delete user: ${e.toString()}',
        'delete-user-failed',
      );
    }
  }

  /// Get user by email (admin only)
  Future<UserProfile?> getUserByEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return UserProfile.fromFirestore(snapshot.docs.first);
    } catch (e) {
      throw UserRepositoryException(
        'Failed to get user by email: ${e.toString()}',
        'get-user-failed',
      );
    }
  }

  /// Search users by display name (admin only)
  Future<List<UserProfile>> searchUsersByName(String searchTerm) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('displayName', isGreaterThanOrEqualTo: searchTerm)
          .where('displayName', isLessThan: searchTerm + 'z')
          .limit(20)
          .get();

      return snapshot.docs
          .map((doc) => UserProfile.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw UserRepositoryException(
        'Failed to search users: ${e.toString()}',
        'search-users-failed',
      );
    }
  }

  /// Dispose resources
  void dispose() {
    _httpClient.close();
  }
}
