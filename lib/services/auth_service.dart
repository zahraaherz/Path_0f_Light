import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_of_light/models/user_model.dart';
import 'package:path_of_light/models/user_progress.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document
      if (userCredential.user != null) {
        await _createUserDocument(
          userCredential.user!,
          displayName: displayName,
        );
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update last login
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).update({
          'last_login_at': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(User user, {required String displayName}) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final exists = await userDoc.get();

    if (!exists.exists) {
      final userModel = UserModel(
        id: user.uid,
        email: user.email ?? '',
        displayName: displayName,
        photoUrl: user.photoURL,
        preferredLanguage: 'ar',
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        isActive: true,
      );

      await userDoc.set(userModel.toFirestore());

      // Create initial user progress
      await _createInitialUserProgress(user.uid);
    }
  }

  // Create initial user progress document
  Future<void> _createInitialUserProgress(String userId) async {
    final progressDoc = _firestore.collection('user_progress').doc(userId);

    final userProgress = UserProgress(
      userId: userId,
      totalPoints: 0,
      currentLevel: 1,
      totalQuestionsAnswered: 0,
      totalCorrectAnswers: 0,
      totalWrongAnswers: 0,
      batterySystem: BatterySystem(
        currentHearts: 5,
        maxHearts: 5,
      ),
      dailyStreak: DailyStreak(
        currentStreak: 0,
        longestStreak: 0,
      ),
      categoryProgress: {},
      achievementIds: [],
      completedLevels: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await progressDoc.set(userProgress.toFirestore());
  }

  // Get user document
  Future<UserModel?> getUserDocument(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting user document: $e');
      return null;
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoUrl,
    String? preferredLanguage,
  }) async {
    if (currentUser == null) return;

    Map<String, dynamic> updates = {
      'updated_at': FieldValue.serverTimestamp(),
    };

    if (displayName != null) updates['display_name'] = displayName;
    if (photoUrl != null) updates['photo_url'] = photoUrl;
    if (preferredLanguage != null) updates['preferred_language'] = preferredLanguage;

    await _firestore.collection('users').doc(currentUser!.uid).update(updates);
  }

  // Handle auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
}
