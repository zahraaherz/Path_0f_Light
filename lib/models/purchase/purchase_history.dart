import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_history.freezed.dart';
part 'purchase_history.g.dart';

/// Purchase history entry for tracking all purchases
@freezed
class PurchaseHistory with _$PurchaseHistory {
  const factory PurchaseHistory({
    required String id,
    required String userId,
    required String productId,
    required String packageId,
    required PurchaseType type,
    required double price,
    required String currency,
    required DateTime purchaseDate,
    required PurchaseStatus status,
    String? transactionId,
    String? originalTransactionId,
    DateTime? expirationDate,
    DateTime? cancellationDate,
    String? cancellationReason,
    bool? isInTrialPeriod,
    bool? isInIntroPeriod,
    String? store, // 'app_store' or 'play_store'
    Map<String, dynamic>? metadata,
  }) = _PurchaseHistory;

  factory PurchaseHistory.fromJson(Map<String, dynamic> json) =>
      _$PurchaseHistoryFromJson(json);
}

/// Type of purchase
enum PurchaseType {
  @JsonValue('subscription')
  subscription,
  @JsonValue('lifetime')
  lifetime,
  @JsonValue('consumable')
  consumable,
}

/// Status of the purchase
enum PurchaseStatus {
  @JsonValue('active')
  active,
  @JsonValue('expired')
  expired,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('refunded')
  refunded,
  @JsonValue('pending')
  pending,
}

/// User subscription status
@freezed
class UserSubscription with _$UserSubscription {
  const factory UserSubscription({
    required String userId,
    required bool isPremium,
    String? currentProductId,
    String? currentPackageId,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionExpiryDate,
    DateTime? trialStartDate,
    DateTime? trialExpiryDate,
    bool? willRenew,
    String? store,
    int? totalPurchases,
    double? lifetimeValue,
    DateTime? lastPurchaseDate,
    @Default([]) List<String> ownedProducts,
  }) = _UserSubscription;

  factory UserSubscription.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionFromJson(json);
}

/// Package information
@freezed
class PurchasePackage with _$PurchasePackage {
  const factory PurchasePackage({
    required String id,
    required String identifier,
    required String productId,
    required String title,
    required String description,
    required double price,
    required String currency,
    required String priceString,
    required PurchaseType type,
    String? subscriptionPeriod,
    String? introPrice,
    String? introPeriod,
    int? introDuration,
    String? freeTrialPeriod,
    bool? isAvailable,
  }) = _PurchasePackage;

  factory PurchasePackage.fromJson(Map<String, dynamic> json) =>
      _$PurchasePackageFromJson(json);
}

/// Purchase event for analytics
@freezed
class PurchaseEvent with _$PurchaseEvent {
  const factory PurchaseEvent({
    required String id,
    required String userId,
    required PurchaseEventType eventType,
    required DateTime timestamp,
    String? productId,
    String? packageId,
    double? price,
    String? currency,
    String? transactionId,
    Map<String, dynamic>? metadata,
  }) = _PurchaseEvent;

  factory PurchaseEvent.fromJson(Map<String, dynamic> json) =>
      _$PurchaseEventFromJson(json);
}

/// Types of purchase events
enum PurchaseEventType {
  @JsonValue('purchase_initiated')
  purchaseInitiated,
  @JsonValue('purchase_completed')
  purchaseCompleted,
  @JsonValue('purchase_failed')
  purchaseFailed,
  @JsonValue('purchase_cancelled')
  purchaseCancelled,
  @JsonValue('subscription_renewed')
  subscriptionRenewed,
  @JsonValue('subscription_expired')
  subscriptionExpired,
  @JsonValue('trial_started')
  trialStarted,
  @JsonValue('trial_ended')
  trialEnded,
  @JsonValue('refund_issued')
  refundIssued,
  @JsonValue('restore_completed')
  restoreCompleted,
}
