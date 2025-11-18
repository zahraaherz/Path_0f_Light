import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/auth_controller.dart';
import '../../providers/guest_access_providers.dart';
import '../../l10n/app_localizations.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authControllerProvider.notifier).signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithGoogle();

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<void> _handleAppleSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithApple();

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<void> _handleFacebookSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithFacebook();

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<void> _handleGuestSignIn() async {
    try {
      final guestService = ref.read(guestAccessServiceProvider);
      await guestService.signInAsGuest();

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.failedToContinueAsGuest(e.toString())),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) {
        final r = dialogContext.responsive;
        return AlertDialog(
          title: Text(
            'Reset Password',
            style: Theme.of(dialogContext).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter your email address to receive a password reset link.',
                style: Theme.of(dialogContext).textTheme.bodyMedium,
              ),
              SizedBox(height: r.spaceMedium),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: l10n.email,
                hintText: l10n.emailHint,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                await ref.read(authControllerProvider.notifier).sendPasswordResetEmail(email);
                if (context.mounted) {
                  Navigator.of(dialogContext).pop();
                }
              }
            },
            child: Text(l10n.sendResetLink),
          ),
        ],
      );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final authState = ref.watch(authControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    // Show error snackbar
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppTheme.error,
          ),
        );
      }
      if (next.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
            backgroundColor: AppTheme.success,
          ),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Islamic Pattern Decoration
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryTeal,
                          AppTheme.islamicGreen,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: 48,
                            color: Colors.white,
                          ),
                          SizedBox(height: r.spaceSmall),
                          Text(
                            'Path of Light',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: r.spaceLarge),

                  // Welcome Text
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.spaceSmall),
                  Text(
                    'Sign in to continue your journey',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.spaceLarge),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: l10n.email,
                      hintText: l10n.emailHint,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spaceMedium),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: l10n.password,
                      hintText: l10n.passwordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleEmailSignIn(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.spaceSmall),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      child: Text(l10n.forgotPassword),
                    ),
                  ),
                  SizedBox(height: r.spaceLarge),

                  // Sign In Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authState.isLoading ? null : _handleEmailSignIn,
                      child: authState.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(l10n.signIn),
                    ),
                  ),
                  SizedBox(height: r.spaceLarge),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: r.paddingMedium),
                        child: Text(
                          'OR CONTINUE WITH',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: r.spaceLarge),

                  // Social Sign In Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Google
                      _SocialSignInButton(
                        onPressed: authState.isLoading ? null : _handleGoogleSignIn,
                        icon: Icons.g_mobiledata,
                        label: 'Google',
                        color: const Color(0xFFDB4437),
                      ),

                      // Apple
                      _SocialSignInButton(
                        onPressed: authState.isLoading ? null : _handleAppleSignIn,
                        icon: Icons.apple,
                        label: 'Apple',
                        color: Colors.black,
                      ),

                      // Facebook
                      _SocialSignInButton(
                        onPressed: authState.isLoading ? null : _handleFacebookSignIn,
                        icon: Icons.facebook,
                        label: 'Facebook',
                        color: const Color(0xFF1877F2),
                      ),
                    ],
                  ),
                  SizedBox(height: r.spaceLarge),

                  // Guest Access Button
                  OutlinedButton.icon(
                    onPressed: authState.isLoading ? null : _handleGuestSignIn,
                    icon: const Icon(Icons.person_outline),
                    label: Text(l10n.continueAsGuest),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: r.paddingMedium),
                      side: BorderSide(
                        color: AppTheme.primaryTeal.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: r.spaceSmall),

                  // Guest Info Text
                  Text(
                    'Try the app without an account. Create one anytime to save your data permanently.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.spaceLarge),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: _navigateToRegister,
                        child: Text(l10n.signUp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color color;

  const _SocialSignInButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(r.radiusMedium),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
