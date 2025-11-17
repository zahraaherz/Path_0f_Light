import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../models/user/auth_user.dart' as app_models;

/// Exception class for authentication errors
class AuthException implements Exception {
  final String message;
  final String code;

  AuthException(this.message, this.code);

  @override
  String toString() => message;
}

/// Repository for handling all authentication operations
class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  /// Get current Firebase user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Get current auth user as app model
  app_models.AuthUser? get currentAuthUser {
    final user = currentUser;
    if (user == null) return null;
    return app_models.AuthUser.fromFirebaseUser(user);
  }

  /// Register with email and password
  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name if provided
      if (displayName != null && credential.user != null) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
      }

      // Send email verification
      await credential.user?.sendEmailVerification();

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException('Registration failed: ${e.toString()}', 'unknown');
    }
  }

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException('Sign in failed: ${e.toString()}', 'unknown');
    }
  }

  /// Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw AuthException('Google sign in was cancelled', 'cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Google sign in failed: ${e.toString()}', 'google-signin-failed');
    }
  }

  /// Sign in with Apple
  Future<UserCredential> signInWithApple() async {
    try {
      // Request credential for the currently signed in Apple account
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an OAuth credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with the Apple credential
      final userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      // Update display name if provided and not already set
      if (userCredential.user != null &&
          userCredential.user!.displayName == null) {
        final fullName = appleCredential.givenName != null &&
                appleCredential.familyName != null
            ? '${appleCredential.givenName} ${appleCredential.familyName}'
            : null;

        if (fullName != null) {
          await userCredential.user!.updateDisplayName(fullName);
          await userCredential.user!.reload();
        }
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Apple sign in failed: ${e.toString()}', 'apple-signin-failed');
    }
  }

  /// Sign in with Facebook
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status != LoginStatus.success) {
        throw AuthException('Facebook sign in was cancelled', 'cancelled');
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Sign in to Firebase with the Facebook credential
      return await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException('Facebook sign in failed: ${e.toString()}',
          'facebook-signin-failed');
    }
  }

  /// Sign in with phone number
  /// Returns a verification ID that should be used with [verifyPhoneNumber]
  Future<String> signInWithPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    String? verificationId;

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: (String verId, int? resendToken) {
        verificationId = verId;
        codeSent(verId, resendToken);
      },
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );

    if (verificationId == null) {
      throw AuthException(
          'Phone verification failed', 'phone-verification-failed');
    }

    return verificationId!;
  }

  /// Verify phone number with SMS code
  Future<UserCredential> verifyPhoneNumberWithCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Phone verification failed: ${e.toString()}', 'verification-failed');
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Failed to send email verification: ${e.toString()}', 'unknown');
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Failed to send password reset email: ${e.toString()}', 'unknown');
    }
  }

  /// Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Failed to update password: ${e.toString()}', 'unknown');
    }
  }

  /// Update email
  Future<void> updateEmail(String newEmail) async {
    try {
      await currentUser?.verifyBeforeUpdateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException('Failed to update email: ${e.toString()}', 'unknown');
    }
  }

  /// Update display name
  Future<void> updateDisplayName(String displayName) async {
    try {
      await currentUser?.updateDisplayName(displayName);
      await currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Failed to update display name: ${e.toString()}', 'unknown');
    }
  }

  /// Update photo URL
  Future<void> updatePhotoURL(String photoURL) async {
    try {
      await currentUser?.updatePhotoURL(photoURL);
      await currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Failed to update photo URL: ${e.toString()}', 'unknown');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      // Sign out from Google if signed in
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      // Sign out from Facebook
      await FacebookAuth.instance.logOut();
      // Sign out from Firebase
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed: ${e.toString()}', 'signout-failed');
    }
  }

  /// Delete account
  Future<void> deleteAccount() async {
    try {
      await currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Failed to delete account: ${e.toString()}', 'unknown');
    }
  }

  /// Re-authenticate with email and password (required for sensitive operations)
  Future<void> reauthenticateWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw AuthException(
          'Re-authentication failed: ${e.toString()}', 'reauth-failed');
    }
  }

  /// Handle Firebase Auth exceptions
  AuthException _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException('No user found with this email', e.code);
      case 'wrong-password':
        return AuthException('Wrong password', e.code);
      case 'invalid-email':
        return AuthException('Invalid email address', e.code);
      case 'user-disabled':
        return AuthException('This account has been disabled', e.code);
      case 'email-already-in-use':
        return AuthException('Email is already in use', e.code);
      case 'operation-not-allowed':
        return AuthException('Operation not allowed', e.code);
      case 'weak-password':
        return AuthException('Password is too weak', e.code);
      case 'requires-recent-login':
        return AuthException(
            'Please sign in again to perform this action', e.code);
      case 'network-request-failed':
        return AuthException('Network error. Please check your connection',
            e.code);
      default:
        return AuthException(e.message ?? 'Authentication failed', e.code);
    }
  }
}
