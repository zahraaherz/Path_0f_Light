import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// Simplified auth user model for authentication state
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    @Default(false) bool emailVerified,
  }) = _AuthUser;

  /// Create from Firebase User
  factory AuthUser.fromFirebaseUser(firebase_auth.User user) {
    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      phoneNumber: user.phoneNumber,
      emailVerified: user.emailVerified,
    );
  }
}
