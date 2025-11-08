import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user/auth_user.dart';
import '../models/user/user_profile.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';

/// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Provider for UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

/// Provider for Firebase Auth state changes
final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

/// Provider for current auth user (simplified model)
final currentAuthUserProvider = Provider<AuthUser?>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      if (user == null) return null;
      return AuthUser.fromFirebaseUser(user);
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider for current user ID
final currentUserIdProvider = Provider<String?>((ref) {
  final authUser = ref.watch(currentAuthUserProvider);
  return authUser?.uid;
});

/// Provider for current user profile (full Firestore profile)
final currentUserProfileProvider = StreamProvider<UserProfile?>((ref) {
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) {
    return Stream.value(null);
  }

  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.streamUserProfile(userId);
});

/// Provider for checking if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authUser = ref.watch(currentAuthUserProvider);
  return authUser != null;
});

/// Provider for checking if user profile is complete
final isProfileCompleteProvider = Provider<bool>((ref) {
  final userProfile = ref.watch(currentUserProfileProvider);

  return userProfile.when(
    data: (profile) => profile?.profileComplete ?? false,
    loading: () => false,
    error: (_, __) => false,
  );
});

/// Provider for checking if email is verified
final isEmailVerifiedProvider = Provider<bool>((ref) {
  final authUser = ref.watch(currentAuthUserProvider);
  return authUser?.emailVerified ?? false;
});
