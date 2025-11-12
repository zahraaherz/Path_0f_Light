import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/auth_repository.dart';
import 'auth_providers.dart';

/// State for authentication operations
class AuthState {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const AuthState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      successMessage: successMessage,
    );
  }

  /// Clear messages
  AuthState clearMessages() {
    return AuthState(isLoading: isLoading);
  }
}

/// Controller for authentication operations
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository) : super(const AuthState());

  /// Register with email and password
  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.registerWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Registration successful! Please verify your email.',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Sign in with email and password
  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Sign in successful!',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.signInWithGoogle();

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Signed in with Google successfully!',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.signInWithApple();

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Signed in with Apple successfully!',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Sign in with Facebook
  Future<bool> signInWithFacebook() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.signInWithFacebook();

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Signed in with Facebook successfully!',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.sendPasswordResetEmail(email);

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Password reset email sent! Check your inbox.',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Send email verification
  Future<bool> sendEmailVerification() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.sendEmailVerification();

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Verification email sent! Check your inbox.',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Sign out
  Future<bool> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.signOut();

      state = state.copyWith(
        isLoading: false,
        successMessage: 'Signed out successfully!',
      );
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  /// Clear messages
  void clearMessages() {
    state = state.clearMessages();
  }
}

/// Provider for AuthController
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository);
});
