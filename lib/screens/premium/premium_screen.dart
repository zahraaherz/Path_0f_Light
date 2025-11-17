import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../config/theme/app_theme.dart';
import '../../providers/purchase_providers.dart';
import '../../utils/responsive.dart';
import 'purchase_history_screen.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final packagesAsync = ref.watch(availablePackagesProvider);
    final hasPremiumAsync = ref.watch(hasPremiumAccessProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PurchaseHistoryScreen(),
                ),
              );
            },
            tooltip: 'Purchase History',
          ),
          TextButton(
            onPressed: _restorePurchases,
            child: const Text('Restore'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Premium Header
            _buildPremiumHeader(r),

            SizedBox(height: r.spaceLarge),

            // Premium Features
            _buildFeaturesSection(r),

            SizedBox(height: r.spaceLarge),

            // Premium Status
            hasPremiumAsync.when(
              data: (hasPremium) {
                if (hasPremium) {
                  return Column(
                    children: [
                      _buildPremiumActiveCard(r),
                      SizedBox(height: r.spaceLarge),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),

            // Available Packages
            packagesAsync.when(
              data: (packages) {
                if (packages.isEmpty) {
                  return _buildNoProductsCard(r);
                }
                return _buildProductsList(packages, r);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _buildErrorCard(error.toString(), r),
            ),

            SizedBox(height: r.spaceLarge),

            // Terms and Conditions
            _buildTermsSection(r),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHeader(Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.goldAccent, AppTheme.goldLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: [
          Icon(
            Icons.workspace_premium,
            size: r.iconLarge * 2,
            color: Colors.white,
          ),
          SizedBox(height: r.spaceMedium),
          Text(
            'Path of Light Premium',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spaceSmall),
          Text(
            'Unlock the full Islamic learning experience',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(Responsive r) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premium Features',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: r.spaceMedium),
            _buildFeatureItem(
              icon: Icons.bolt,
              title: '200 Max Energy',
              subtitle: 'Double your learning capacity',
              r: r,
            ),
            _buildFeatureItem(
              icon: Icons.speed,
              title: '2x Faster Refill',
              subtitle: '10 energy per hour instead of 5',
              r: r,
            ),
            _buildFeatureItem(
              icon: Icons.block,
              title: 'Ad-Free Experience',
              subtitle: 'No interruptions, pure learning',
              r: r,
            ),
            _buildFeatureItem(
              icon: Icons.stars,
              title: 'Exclusive Badges',
              subtitle: 'Show your premium status',
              r: r,
            ),
            _buildFeatureItem(
              icon: Icons.support,
              title: 'Priority Support',
              subtitle: 'Get help when you need it',
              r: r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Responsive r,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: r.spaceMedium),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(r.paddingSmall),
            decoration: BoxDecoration(
              color: AppTheme.goldAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(r.radiusSmall),
            ),
            child: Icon(icon, color: AppTheme.goldAccent),
          ),
          SizedBox(width: r.spaceMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumActiveCard(Responsive r) {
    return Card(
      color: AppTheme.success.withValues(alpha: 0.1),
      child: Padding(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: AppTheme.success, size: r.iconLarge),
            SizedBox(width: r.spaceMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Active',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.success,
                        ),
                  ),
                  Text(
                    'Thank you for your support!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsList(List<Package> packages, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Choose Your Plan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: r.spaceMedium),
        ...packages.map((package) => _buildPackageCard(package, r)),
      ],
    );
  }

  Widget _buildPackageCard(Package package, Responsive r) {
    // Determine if this is the recommended plan (annual)
    final isRecommended = package.packageType == PackageType.annual;

    String planName = 'Premium';
    String planDuration = '';
    String savingsText = '';

    // Determine package details based on type
    if (package.packageType == PackageType.monthly) {
      planName = 'Monthly Premium';
      planDuration = 'Billed monthly';
    } else if (package.packageType == PackageType.annual) {
      planName = 'Yearly Premium';
      planDuration = 'Billed annually';
      savingsText = 'Save 30%';
    } else if (package.packageType == PackageType.lifetime) {
      planName = 'Lifetime Premium';
      planDuration = 'One-time payment';
      savingsText = 'Best Value';
    }

    return Card(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      elevation: isRecommended ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium),
        side: isRecommended
            ? BorderSide(color: AppTheme.goldAccent, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: _isProcessing ? null : () => _purchasePackage(package),
        borderRadius: BorderRadius.circular(r.radiusMedium),
        child: Padding(
          padding: EdgeInsets.all(r.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          planName,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: r.spaceXSmall),
                        Text(
                          planDuration,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        package.storeProduct.priceString,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.goldAccent,
                            ),
                      ),
                      if (savingsText.isNotEmpty) ...[
                        SizedBox(height: r.spaceXSmall),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: r.paddingSmall,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.success,
                            borderRadius: BorderRadius.circular(r.radiusSmall),
                          ),
                          child: Text(
                            savingsText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: r.fontSmall,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              if (isRecommended) ...[
                SizedBox(height: r.spaceSmall),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.paddingSmall,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.goldAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(r.radiusSmall),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stars, size: r.paddingMedium, color: AppTheme.goldAccent),
                      SizedBox(width: r.spaceXSmall),
                      Text(
                        'Most Popular',
                        style: TextStyle(
                          color: AppTheme.goldAccent,
                          fontSize: r.fontSmall,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: r.spaceMedium),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : () => _purchasePackage(package),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRecommended ? AppTheme.goldAccent : null,
                    padding: EdgeInsets.symmetric(vertical: r.paddingMedium),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          'Subscribe Now',
                          style: TextStyle(
                            fontSize: r.fontMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoProductsCard(Responsive r) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          children: [
            Icon(Icons.info_outline, size: r.iconLarge, color: AppTheme.info),
            SizedBox(height: r.spaceMedium),
            Text(
              'No products available',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: r.spaceSmall),
            Text(
              'Please check your internet connection and try again.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.spaceMedium),
            ElevatedButton(
              onPressed: () => ref.invalidate(availablePackagesProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error, Responsive r) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: r.iconLarge, color: AppTheme.error),
            SizedBox(height: r.spaceMedium),
            Text(
              'Error loading products',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: r.spaceSmall),
            Text(
              error,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsSection(Responsive r) {
    return Column(
      children: [
        Text(
          'By subscribing, you agree to our Terms of Service and Privacy Policy. '
          'Subscriptions automatically renew unless canceled at least 24 hours before the end of the current period.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: r.spaceSmall),
        Text(
          'Manage your subscription in your device settings.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> _purchasePackage(Package package) async {
    setState(() => _isProcessing = true);

    try {
      final controller = ref.read(purchaseControllerProvider);
      await controller.purchasePackage(package);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Purchase successful! Thank you for supporting Path of Light.'),
          backgroundColor: AppTheme.success,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      String errorMessage = 'Purchase failed. Please try again.';
      if (e.toString().contains('cancelled')) {
        errorMessage = 'Purchase was cancelled.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppTheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _restorePurchases() async {
    try {
      final controller = ref.read(purchaseControllerProvider);
      await controller.restorePurchases();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Purchases restored successfully!'),
          backgroundColor: AppTheme.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error restoring purchases: ${e.toString()}'),
          backgroundColor: AppTheme.error,
        ),
      );
    }
  }
}
