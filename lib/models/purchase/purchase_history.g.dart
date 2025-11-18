// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseHistoryImpl _$$PurchaseHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseHistoryImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      packageId: json['packageId'] as String,
      type: $enumDecode(_$PurchaseTypeEnumMap, json['type']),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      status: $enumDecode(_$PurchaseStatusEnumMap, json['status']),
      transactionId: json['transactionId'] as String?,
      originalTransactionId: json['originalTransactionId'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      cancellationDate: json['cancellationDate'] == null
          ? null
          : DateTime.parse(json['cancellationDate'] as String),
      cancellationReason: json['cancellationReason'] as String?,
      isInTrialPeriod: json['isInTrialPeriod'] as bool?,
      isInIntroPeriod: json['isInIntroPeriod'] as bool?,
      store: json['store'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PurchaseHistoryImplToJson(
        _$PurchaseHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'packageId': instance.packageId,
      'type': _$PurchaseTypeEnumMap[instance.type]!,
      'price': instance.price,
      'currency': instance.currency,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'status': _$PurchaseStatusEnumMap[instance.status]!,
      'transactionId': instance.transactionId,
      'originalTransactionId': instance.originalTransactionId,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'cancellationDate': instance.cancellationDate?.toIso8601String(),
      'cancellationReason': instance.cancellationReason,
      'isInTrialPeriod': instance.isInTrialPeriod,
      'isInIntroPeriod': instance.isInIntroPeriod,
      'store': instance.store,
      'metadata': instance.metadata,
    };

const _$PurchaseTypeEnumMap = {
  PurchaseType.subscription: 'subscription',
  PurchaseType.lifetime: 'lifetime',
  PurchaseType.consumable: 'consumable',
};

const _$PurchaseStatusEnumMap = {
  PurchaseStatus.active: 'active',
  PurchaseStatus.expired: 'expired',
  PurchaseStatus.cancelled: 'cancelled',
  PurchaseStatus.refunded: 'refunded',
  PurchaseStatus.pending: 'pending',
};

_$UserSubscriptionImpl _$$UserSubscriptionImplFromJson(
        Map<String, dynamic> json) =>
    _$UserSubscriptionImpl(
      userId: json['userId'] as String,
      isPremium: json['isPremium'] as bool,
      currentProductId: json['currentProductId'] as String?,
      currentPackageId: json['currentPackageId'] as String?,
      subscriptionStartDate: json['subscriptionStartDate'] == null
          ? null
          : DateTime.parse(json['subscriptionStartDate'] as String),
      subscriptionExpiryDate: json['subscriptionExpiryDate'] == null
          ? null
          : DateTime.parse(json['subscriptionExpiryDate'] as String),
      trialStartDate: json['trialStartDate'] == null
          ? null
          : DateTime.parse(json['trialStartDate'] as String),
      trialExpiryDate: json['trialExpiryDate'] == null
          ? null
          : DateTime.parse(json['trialExpiryDate'] as String),
      willRenew: json['willRenew'] as bool?,
      store: json['store'] as String?,
      totalPurchases: (json['totalPurchases'] as num?)?.toInt(),
      lifetimeValue: (json['lifetimeValue'] as num?)?.toDouble(),
      lastPurchaseDate: json['lastPurchaseDate'] == null
          ? null
          : DateTime.parse(json['lastPurchaseDate'] as String),
      ownedProducts: (json['ownedProducts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserSubscriptionImplToJson(
        _$UserSubscriptionImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isPremium': instance.isPremium,
      'currentProductId': instance.currentProductId,
      'currentPackageId': instance.currentPackageId,
      'subscriptionStartDate':
          instance.subscriptionStartDate?.toIso8601String(),
      'subscriptionExpiryDate':
          instance.subscriptionExpiryDate?.toIso8601String(),
      'trialStartDate': instance.trialStartDate?.toIso8601String(),
      'trialExpiryDate': instance.trialExpiryDate?.toIso8601String(),
      'willRenew': instance.willRenew,
      'store': instance.store,
      'totalPurchases': instance.totalPurchases,
      'lifetimeValue': instance.lifetimeValue,
      'lastPurchaseDate': instance.lastPurchaseDate?.toIso8601String(),
      'ownedProducts': instance.ownedProducts,
    };

_$PurchasePackageImpl _$$PurchasePackageImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchasePackageImpl(
      id: json['id'] as String,
      identifier: json['identifier'] as String,
      productId: json['productId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      priceString: json['priceString'] as String,
      type: $enumDecode(_$PurchaseTypeEnumMap, json['type']),
      subscriptionPeriod: json['subscriptionPeriod'] as String?,
      introPrice: json['introPrice'] as String?,
      introPeriod: json['introPeriod'] as String?,
      introDuration: (json['introDuration'] as num?)?.toInt(),
      freeTrialPeriod: json['freeTrialPeriod'] as String?,
      isAvailable: json['isAvailable'] as bool?,
    );

Map<String, dynamic> _$$PurchasePackageImplToJson(
        _$PurchasePackageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identifier': instance.identifier,
      'productId': instance.productId,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'priceString': instance.priceString,
      'type': _$PurchaseTypeEnumMap[instance.type]!,
      'subscriptionPeriod': instance.subscriptionPeriod,
      'introPrice': instance.introPrice,
      'introPeriod': instance.introPeriod,
      'introDuration': instance.introDuration,
      'freeTrialPeriod': instance.freeTrialPeriod,
      'isAvailable': instance.isAvailable,
    };

_$PurchaseEventImpl _$$PurchaseEventImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseEventImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      eventType: $enumDecode(_$PurchaseEventTypeEnumMap, json['eventType']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      productId: json['productId'] as String?,
      packageId: json['packageId'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      transactionId: json['transactionId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PurchaseEventImplToJson(_$PurchaseEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'eventType': _$PurchaseEventTypeEnumMap[instance.eventType]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'productId': instance.productId,
      'packageId': instance.packageId,
      'price': instance.price,
      'currency': instance.currency,
      'transactionId': instance.transactionId,
      'metadata': instance.metadata,
    };

const _$PurchaseEventTypeEnumMap = {
  PurchaseEventType.purchaseInitiated: 'purchase_initiated',
  PurchaseEventType.purchaseCompleted: 'purchase_completed',
  PurchaseEventType.purchaseFailed: 'purchase_failed',
  PurchaseEventType.purchaseCancelled: 'purchase_cancelled',
  PurchaseEventType.subscriptionRenewed: 'subscription_renewed',
  PurchaseEventType.subscriptionExpired: 'subscription_expired',
  PurchaseEventType.trialStarted: 'trial_started',
  PurchaseEventType.trialEnded: 'trial_ended',
  PurchaseEventType.refundIssued: 'refund_issued',
  PurchaseEventType.restoreCompleted: 'restore_completed',
};
