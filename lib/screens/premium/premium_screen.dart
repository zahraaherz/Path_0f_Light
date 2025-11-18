import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final r = context.responsive;
    final packagesAsync = ref.watch(availablePackagesProvider);
    final hasPremiumAsync = ref.watch(hasPremiumAccessProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.premium),
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
            child: Text(l10n.restore),
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
                  return _buildNoProductsCard(r, l10n);
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.goldAccent.withOpacity(0.05),
        border: Border.all(
          color: AppTheme.goldAccent.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(r.paddingMedium),
            decoration: BoxDecoration(
              color: AppTheme.goldAccent.withOpacity(0.1),
              border: Border.all(
                color: AppTheme.goldAccent.withOpacity(0.3),
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium,
              size: r.iconLarge * 1.5,
              color: AppTheme.goldAccent,
            ),
          ),
          SizedBox(height: r.spaceMedium),
          Text(
            l10n.premiumTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.goldAccent,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spaceSmall),
          Text(
            l10n.premiumSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(Responsive r) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.premiumFeatures,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: r.spaceMedium),
          _buildFeatureItem(
            icon: Icons.bolt,
            title: '200 ${l10n.maxEnergy}',
            subtitle: l10n.maxEnergyDesc,
            r: r,
          ),
          _buildFeatureItem(
            icon: Icons.speed,
            title: '2x ${l10n.fasterRefill}',
            subtitle: '10 ${l10n.fasterRefillDesc} 5',
            r: r,
          ),
          _buildFeatureItem(
            icon: Icons.block,
            title: l10n.adFreeExperience,
            subtitle: l10n.adFreeDesc,
            r: r,
          ),
          _buildFeatureItem(
            icon: Icons.stars,
            title: l10n.exclusiveBadges,
            subtitle: l10n.exclusiveBadgesDesc,
            r: r,
          ),
          _buildFeatureItem(
            icon: Icons.support,
            title: l10n.prioritySupport,
            subtitle: l10n.prioritySupportDesc,
            r: r,
          ),
        ],
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
              color: AppTheme.primaryTeal.withOpacity(0.1),
              border: Border.all(
                color: AppTheme.primaryTeal.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(r.radiusSmall),
            ),
            child: Icon(icon, color: AppTheme.primaryTeal),
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
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        color: AppTheme.success.withOpacity(0.05),
        border: Border.all(
          color: AppTheme.success.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(r.paddingSmall),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              border: Border.all(
                color: AppTheme.success.withOpacity(0.3),
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: AppTheme.success, size: r.iconMedium),
          ),
          SizedBox(width: r.spaceMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.premiumActive,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.success,
                      ),
                ),
                Text(
                  l10n.thankYouSupport,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList(List<Package> packages, Responsive r) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.chooseYourPlan,
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
    final l10n = AppLocalizations.of(context)!;
    // Determine if this is the recommended plan (annual)
    final isRecommended = package.packageType == PackageType.annual;

    String planName = l10n.premium;
    String planDuration = '';
    String savingsText = '';

    // Determine package details based on type
    if (package.packageType == PackageType.monthly) {
      planName = l10n.monthlyPremium;
      planDuration = l10n.billedMonthly;
    } else if (package.packageType == PackageType.annual) {
      planName = l10n.yearlyPremium;
      planDuration = l10n.billedAnnually;
      savingsText = l10n.savePercent(30);
    } else if (package.packageType == PackageType.lifetime) {
      planName = l10n.lifetimePremium;
      planDuration = l10n.oneTimePayment;
      savingsText = l10n.bestValue;
    }

    return Container(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecommended
              ? AppTheme.goldAccent.withOpacity(0.5)
              : AppTheme.primaryTeal.withOpacity(0.3),
          width: isRecommended ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
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
                              color: AppTheme.primaryTeal,
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
                    color: AppTheme.goldAccent.withOpacity(0.1),
                    border: Border.all(
                      color: AppTheme.goldAccent.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(r.radiusSmall),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stars, size: r.paddingMedium, color: AppTheme.goldAccent),
                      SizedBox(width: r.spaceXSmall),
                      Text(
                        l10n.mostPopular,
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
                    backgroundColor: isRecommended ? AppTheme.primaryTeal : null,
                    padding: EdgeInsets.symmetric(vertical: r.paddingMedium),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          l10n.subscribeNow,
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

  Widget _buildNoProductsCard(Responsive r, AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.info.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: [
          Icon(Icons.info_outline, size: r.iconLarge, color: AppTheme.info),
          SizedBox(height: r.spaceMedium),
          Text(
            l10n.noProductsAvailable,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: r.spaceSmall),
          Text(
            l10n.checkConnection,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spaceMedium),
          ElevatedButton(
            onPressed: () => ref.invalidate(availablePackagesProvider),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String error, Responsive r) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.error.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: r.iconLarge, color: AppTheme.error),
          SizedBox(height: r.spaceMedium),
          Text(
            l10n.errorLoadingProducts,
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
    );
  }

  Widget _buildTermsSection(Responsive r) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Text(
          l10n.subscriptionTerms,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: r.spaceSmall),
        Text(
          l10n.manageSubscription,
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

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.purchaseSuccessful),
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
    final l10n = AppLocalizations.of(context)!;
    try {
      final controller = ref.read(purchaseControllerProvider);
      await controller.restorePurchases();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.purchasesRestored),
          backgroundColor: AppTheme.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorRestoringPurchases(e.toString())),
          backgroundColor: AppTheme.error,
        ),
      );
    }
  }
}
