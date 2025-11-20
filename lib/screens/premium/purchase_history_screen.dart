import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../config/theme/app_theme.dart';
import '../../models/purchase/purchase_history.dart';
import '../../providers/purchase_providers.dart';
import '../../utils/responsive.dart';
import '../../l10n/app_localizations.dart';

class PurchaseHistoryScreen extends ConsumerWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = context.responsive;
    final l10n = AppLocalizations.of(context)!;
    final purchaseHistory = ref.watch(purchaseHistoryProvider);
    final subscription = ref.watch(userSubscriptionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.purchaseHistory),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Subscription Status Card
          subscription.when(
            data: (sub) {
              if (sub != null && sub.isPremium) {
                return _buildSubscriptionStatusCard(sub, r, context, l10n);
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // Purchase History List
          Expanded(
            child: purchaseHistory.when(
              data: (purchases) {
                if (purchases.isEmpty) {
                  return _buildEmptyState(r, context, l10n);
                }
                return _buildPurchaseList(purchases, r, context, l10n);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(l10n.errorMessage(error.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionStatusCard(
    UserSubscription subscription,
    Responsive r,
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Container(
      margin: EdgeInsets.all(r.paddingMedium),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.workspace_premium,
                color: Colors.white,
                size: r.iconLarge,
              ),
              SizedBox(width: r.spaceMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.premiumActive,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (subscription.currentProductId != null)
                      Text(
                        subscription.currentProductId!.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: r.spaceMedium),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          SizedBox(height: r.spaceMedium),
          _buildInfoRow(
            l10n.memberSince,
            _formatDate(subscription.subscriptionStartDate),
            r,
            context,
          ),
          if (subscription.subscriptionExpiryDate != null)
            _buildInfoRow(
              subscription.willRenew == true ? l10n.renewsOn : l10n.expiresOn,
              _formatDate(subscription.subscriptionExpiryDate),
              r,
              context,
            ),
          _buildInfoRow(
            l10n.totalPurchases,
            '${subscription.totalPurchases ?? 0}',
            r,
            context,
          ),
          if (subscription.lifetimeValue != null)
            _buildInfoRow(
              l10n.lifetimeValue,
              '\$${subscription.lifetimeValue!.toStringAsFixed(2)}',
              r,
              context,
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    Responsive r,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spaceXSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseList(
    List<PurchaseHistory> purchases,
    Responsive r,
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return ListView.builder(
      padding: EdgeInsets.all(r.paddingMedium),
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return _buildPurchaseCard(purchase, r, context, l10n);
      },
    );
  }

  Widget _buildPurchaseCard(
    PurchaseHistory purchase,
    Responsive r,
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final statusColor = _getStatusColor(purchase.status);
    final statusIcon = _getStatusIcon(purchase.status);

    return Card(
      margin: EdgeInsets.only(bottom: r.spaceMedium),
      child: ExpansionTile(
        leading: Container(
          padding: EdgeInsets.all(r.paddingSmall),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(r.radiusSmall),
          ),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(
          purchase.productId,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: r.spaceXSmall),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.paddingSmall,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(r.radiusSmall),
                  ),
                  child: Text(
                    purchase.status.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: r.fontSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: r.spaceSmall),
                Text(
                  _formatDate(purchase.purchaseDate),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
              ],
            ),
          ],
        ),
        trailing: Text(
          '${purchase.currency} ${purchase.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.goldAccent,
              ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(r.paddingMedium),
            child: Column(
              children: [
                _buildDetailRow(l10n.package, purchase.packageId, r, context),
                _buildDetailRow(l10n.type, purchase.type.name, r, context),
                if (purchase.transactionId != null)
                  _buildDetailRow(
                    l10n.transaction,
                    purchase.transactionId!,
                    r,
                    context,
                  ),
                if (purchase.expirationDate != null)
                  _buildDetailRow(
                    l10n.expires,
                    _formatDate(purchase.expirationDate),
                    r,
                    context,
                  ),
                if (purchase.store != null)
                  _buildDetailRow(l10n.store, purchase.store!, r, context),
                if (purchase.cancellationDate != null) ...[
                  _buildDetailRow(
                    l10n.cancelled,
                    _formatDate(purchase.cancellationDate),
                    r,
                    context,
                  ),
                  if (purchase.cancellationReason != null)
                    _buildDetailRow(
                      l10n.reason,
                      purchase.cancellationReason!,
                      r,
                      context,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    Responsive r,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spaceXSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(Responsive r, BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: r.iconLarge * 2,
              color: AppTheme.textSecondary,
            ),
            SizedBox(height: r.spaceMedium),
            Text(
              l10n.noPurchaseHistory,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: r.spaceSmall),
            Text(
              l10n.purchaseHistoryWillAppearHere,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.active:
        return AppTheme.success;
      case PurchaseStatus.expired:
        return AppTheme.warning;
      case PurchaseStatus.cancelled:
        return AppTheme.error;
      case PurchaseStatus.refunded:
        return AppTheme.error;
      case PurchaseStatus.pending:
        return AppTheme.info;
    }
  }

  IconData _getStatusIcon(PurchaseStatus status) {
    switch (status) {
      case PurchaseStatus.active:
        return Icons.check_circle;
      case PurchaseStatus.expired:
        return Icons.timer_off;
      case PurchaseStatus.cancelled:
        return Icons.cancel;
      case PurchaseStatus.refunded:
        return Icons.money_off;
      case PurchaseStatus.pending:
        return Icons.pending;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
