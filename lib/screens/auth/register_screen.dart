import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import '../../utils/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/auth_controller.dart';
import '../../providers/guest_access_providers.dart';
import '../home/home_screen.dart';
import '../../l10n/app_localizations.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.agreeToTerms),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    // Check if current user is anonymous (guest)
    final currentUser = FirebaseAuth.instance.currentUser;
    final isGuest = currentUser != null && currentUser.isAnonymous;

    bool success;
    if (isGuest) {
      // Link anonymous account to email
      try {
        final guestService = ref.read(guestAccessServiceProvider);
        await guestService.linkToEmailAccount(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        success = true;
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.failedToLinkAccount(e.toString())),
              backgroundColor: AppTheme.error,
            ),
          );
        }
        return;
      }
    } else {
      // Regular registration
      success = await ref.read(authControllerProvider.notifier).registerWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _nameController.text.trim(),
      );
    }

    if (success && mounted) {
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          final r = dialogContext.responsive;
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.check_circle, color: AppTheme.success, size: 32),
                SizedBox(width: r.spaceSmall),
                Text(isGuest ? l10n.accountLinked : l10n.accountCreated),
              ],
            ),
          content: Text(
            isGuest
              ? l10n.accountLinkedMessage
              : l10n.accountCreatedMessage,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: Text(l10n.continueButton),
            ),
          ],
        );
        },
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    // Use the regular sign-in method which will handle guest account linking
    final success = await ref.read(authControllerProvider.notifier).signInWithGoogle();

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<void> _handleAppleSignIn() async {
    // Use the regular sign-in method which will handle guest account linking
    final success = await ref.read(authControllerProvider.notifier).signInWithApple();

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  Future<void> _handleFacebookSignIn() async {
    // Use the regular sign-in method which will handle guest account linking
    final success = await ref.read(authControllerProvider.notifier).signInWithFacebook();

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
    final authState = ref.watch(authControllerProvider);

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: AppTheme.error),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createAccount),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.primaryTeal,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryTeal, AppTheme.islamicGreen],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Icon(Icons.person_add, size: 48, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: r.spaceLarge),
                  Text(l10n.joinPathOfLight, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                  SizedBox(height: r.spaceSmall),
                  Text(l10n.createAccountToStart,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
                      textAlign: TextAlign.center),
                  SizedBox(height: r.spaceLarge),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: l10n.fullName, hintText: l10n.enterYourName, prefixIcon: const Icon(Icons.person_outline)),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    validator: (v) => Validators.displayName(v, l10n),
                  ),
                  SizedBox(height: r.spaceMedium),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: l10n.email, hintText: l10n.emailHint, prefixIcon: const Icon(Icons.email_outlined)),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.email(v, l10n),
                  ),
                  SizedBox(height: r.spaceMedium),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: l10n.password,
                      hintText: l10n.passwordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.password(v, l10n),
                  ),
                  SizedBox(height: r.spaceMedium),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: l10n.confirmPassword,
                      hintText: l10n.passwordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                    ),
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleRegister(),
                    validator: (v) => Validators.confirmPassword(v, _passwordController.text, l10n),
                  ),
                  SizedBox(height: r.spaceMedium),
                  Row(
                    children: [
                      Checkbox(value: _agreeToTerms, onChanged: (v) => setState(() => _agreeToTerms = v ?? false), activeColor: AppTheme.primaryTeal),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _agreeToTerms = !_agreeToTerms),
                          child: Text.rich(
                            TextSpan(
                              text: l10n.iAgreeToThe,
                              style: Theme.of(context).textTheme.bodySmall,
                              children: [
                                TextSpan(
                                  text: l10n.termsOfService,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.primaryTeal, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                                ),
                                TextSpan(text: l10n.and),
                                TextSpan(
                                  text: l10n.privacyPolicy,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.primaryTeal, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: r.spaceLarge),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authState.isLoading ? null : _handleRegister,
                      child: authState.isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                          : Text(l10n.createAccount),
                    ),
                  ),
                  SizedBox(height: r.spaceLarge),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(padding: EdgeInsets.symmetric(horizontal: r.paddingMedium), child: Text(l10n.orSignUpWith, style: Theme.of(context).textTheme.bodySmall)),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: r.spaceLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SocialSignInButton(onPressed: authState.isLoading ? null : _handleGoogleSignIn, icon: Icons.g_mobiledata, label: 'Google', color: const Color(0xFFDB4437)),
                      _SocialSignInButton(onPressed: authState.isLoading ? null : _handleAppleSignIn, icon: Icons.apple, label: 'Apple', color: Colors.black),
                      _SocialSignInButton(onPressed: authState.isLoading ? null : _handleFacebookSignIn, icon: Icons.facebook, label: 'Facebook', color: const Color(0xFF1877F2)),
                    ],
                  ),
                  SizedBox(height: r.spaceLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.alreadyHaveAccount, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.signIn)),
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

  const _SocialSignInButton({required this.onPressed, required this.icon, required this.label, required this.color});

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
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: 28)),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
