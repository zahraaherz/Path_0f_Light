// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchaseHistory _$PurchaseHistoryFromJson(Map<String, dynamic> json) {
  return _PurchaseHistory.fromJson(json);
}

/// @nodoc
mixin _$PurchaseHistory {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get packageId => throw _privateConstructorUsedError;
  PurchaseType get type => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  PurchaseStatus get status => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get originalTransactionId => throw _privateConstructorUsedError;
  DateTime? get expirationDate => throw _privateConstructorUsedError;
  DateTime? get cancellationDate => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;
  bool? get isInTrialPeriod => throw _privateConstructorUsedError;
  bool? get isInIntroPeriod => throw _privateConstructorUsedError;
  String? get store =>
      throw _privateConstructorUsedError; // 'app_store' or 'play_store'
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PurchaseHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseHistoryCopyWith<PurchaseHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseHistoryCopyWith<$Res> {
  factory $PurchaseHistoryCopyWith(
          PurchaseHistory value, $Res Function(PurchaseHistory) then) =
      _$PurchaseHistoryCopyWithImpl<$Res, PurchaseHistory>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      String packageId,
      PurchaseType type,
      double price,
      String currency,
      DateTime purchaseDate,
      PurchaseStatus status,
      String? transactionId,
      String? originalTransactionId,
      DateTime? expirationDate,
      DateTime? cancellationDate,
      String? cancellationReason,
      bool? isInTrialPeriod,
      bool? isInIntroPeriod,
      String? store,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$PurchaseHistoryCopyWithImpl<$Res, $Val extends PurchaseHistory>
    implements $PurchaseHistoryCopyWith<$Res> {
  _$PurchaseHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? packageId = null,
    Object? type = null,
    Object? price = null,
    Object? currency = null,
    Object? purchaseDate = null,
    Object? status = null,
    Object? transactionId = freezed,
    Object? originalTransactionId = freezed,
    Object? expirationDate = freezed,
    Object? cancellationDate = freezed,
    Object? cancellationReason = freezed,
    Object? isInTrialPeriod = freezed,
    Object? isInIntroPeriod = freezed,
    Object? store = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      packageId: null == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PurchaseType,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTransactionId: freezed == originalTransactionId
          ? _value.originalTransactionId
          : originalTransactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationDate: freezed == cancellationDate
          ? _value.cancellationDate
          : cancellationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      isInTrialPeriod: freezed == isInTrialPeriod
          ? _value.isInTrialPeriod
          : isInTrialPeriod // ignore: cast_nullable_to_non_nullable
              as bool?,
      isInIntroPeriod: freezed == isInIntroPeriod
          ? _value.isInIntroPeriod
          : isInIntroPeriod // ignore: cast_nullable_to_non_nullable
              as bool?,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseHistoryImplCopyWith<$Res>
    implements $PurchaseHistoryCopyWith<$Res> {
  factory _$$PurchaseHistoryImplCopyWith(_$PurchaseHistoryImpl value,
          $Res Function(_$PurchaseHistoryImpl) then) =
      __$$PurchaseHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      String packageId,
      PurchaseType type,
      double price,
      String currency,
      DateTime purchaseDate,
      PurchaseStatus status,
      String? transactionId,
      String? originalTransactionId,
      DateTime? expirationDate,
      DateTime? cancellationDate,
      String? cancellationReason,
      bool? isInTrialPeriod,
      bool? isInIntroPeriod,
      String? store,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$PurchaseHistoryImplCopyWithImpl<$Res>
    extends _$PurchaseHistoryCopyWithImpl<$Res, _$PurchaseHistoryImpl>
    implements _$$PurchaseHistoryImplCopyWith<$Res> {
  __$$PurchaseHistoryImplCopyWithImpl(
      _$PurchaseHistoryImpl _value, $Res Function(_$PurchaseHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? packageId = null,
    Object? type = null,
    Object? price = null,
    Object? currency = null,
    Object? purchaseDate = null,
    Object? status = null,
    Object? transactionId = freezed,
    Object? originalTransactionId = freezed,
    Object? expirationDate = freezed,
    Object? cancellationDate = freezed,
    Object? cancellationReason = freezed,
    Object? isInTrialPeriod = freezed,
    Object? isInIntroPeriod = freezed,
    Object? store = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$PurchaseHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      packageId: null == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PurchaseType,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      originalTransactionId: freezed == originalTransactionId
          ? _value.originalTransactionId
          : originalTransactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationDate: freezed == cancellationDate
          ? _value.cancellationDate
          : cancellationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      isInTrialPeriod: freezed == isInTrialPeriod
          ? _value.isInTrialPeriod
          : isInTrialPeriod // ignore: cast_nullable_to_non_nullable
              as bool?,
      isInIntroPeriod: freezed == isInIntroPeriod
          ? _value.isInIntroPeriod
          : isInIntroPeriod // ignore: cast_nullable_to_non_nullable
              as bool?,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseHistoryImpl implements _PurchaseHistory {
  const _$PurchaseHistoryImpl(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.packageId,
      required this.type,
      required this.price,
      required this.currency,
      required this.purchaseDate,
      required this.status,
      this.transactionId,
      this.originalTransactionId,
      this.expirationDate,
      this.cancellationDate,
      this.cancellationReason,
      this.isInTrialPeriod,
      this.isInIntroPeriod,
      this.store,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$PurchaseHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String productId;
  @override
  final String packageId;
  @override
  final PurchaseType type;
  @override
  final double price;
  @override
  final String currency;
  @override
  final DateTime purchaseDate;
  @override
  final PurchaseStatus status;
  @override
  final String? transactionId;
  @override
  final String? originalTransactionId;
  @override
  final DateTime? expirationDate;
  @override
  final DateTime? cancellationDate;
  @override
  final String? cancellationReason;
  @override
  final bool? isInTrialPeriod;
  @override
  final bool? isInIntroPeriod;
  @override
  final String? store;
// 'app_store' or 'play_store'
  final Map<String, dynamic>? _metadata;
// 'app_store' or 'play_store'
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PurchaseHistory(id: $id, userId: $userId, productId: $productId, packageId: $packageId, type: $type, price: $price, currency: $currency, purchaseDate: $purchaseDate, status: $status, transactionId: $transactionId, originalTransactionId: $originalTransactionId, expirationDate: $expirationDate, cancellationDate: $cancellationDate, cancellationReason: $cancellationReason, isInTrialPeriod: $isInTrialPeriod, isInIntroPeriod: $isInIntroPeriod, store: $store, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.originalTransactionId, originalTransactionId) ||
                other.originalTransactionId == originalTransactionId) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.cancellationDate, cancellationDate) ||
                other.cancellationDate == cancellationDate) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason) &&
            (identical(other.isInTrialPeriod, isInTrialPeriod) ||
                other.isInTrialPeriod == isInTrialPeriod) &&
            (identical(other.isInIntroPeriod, isInIntroPeriod) ||
                other.isInIntroPeriod == isInIntroPeriod) &&
            (identical(other.store, store) || other.store == store) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      productId,
      packageId,
      type,
      price,
      currency,
      purchaseDate,
      status,
      transactionId,
      originalTransactionId,
      expirationDate,
      cancellationDate,
      cancellationReason,
      isInTrialPeriod,
      isInIntroPeriod,
      store,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PurchaseHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseHistoryImplCopyWith<_$PurchaseHistoryImpl> get copyWith =>
      __$$PurchaseHistoryImplCopyWithImpl<_$PurchaseHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseHistoryImplToJson(
      this,
    );
  }
}

abstract class _PurchaseHistory implements PurchaseHistory {
  const factory _PurchaseHistory(
      {required final String id,
      required final String userId,
      required final String productId,
      required final String packageId,
      required final PurchaseType type,
      required final double price,
      required final String currency,
      required final DateTime purchaseDate,
      required final PurchaseStatus status,
      final String? transactionId,
      final String? originalTransactionId,
      final DateTime? expirationDate,
      final DateTime? cancellationDate,
      final String? cancellationReason,
      final bool? isInTrialPeriod,
      final bool? isInIntroPeriod,
      final String? store,
      final Map<String, dynamic>? metadata}) = _$PurchaseHistoryImpl;

  factory _PurchaseHistory.fromJson(Map<String, dynamic> json) =
      _$PurchaseHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get productId;
  @override
  String get packageId;
  @override
  PurchaseType get type;
  @override
  double get price;
  @override
  String get currency;
  @override
  DateTime get purchaseDate;
  @override
  PurchaseStatus get status;
  @override
  String? get transactionId;
  @override
  String? get originalTransactionId;
  @override
  DateTime? get expirationDate;
  @override
  DateTime? get cancellationDate;
  @override
  String? get cancellationReason;
  @override
  bool? get isInTrialPeriod;
  @override
  bool? get isInIntroPeriod;
  @override
  String? get store; // 'app_store' or 'play_store'
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PurchaseHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseHistoryImplCopyWith<_$PurchaseHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSubscription _$UserSubscriptionFromJson(Map<String, dynamic> json) {
  return _UserSubscription.fromJson(json);
}

/// @nodoc
mixin _$UserSubscription {
  String get userId => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  String? get currentProductId => throw _privateConstructorUsedError;
  String? get currentPackageId => throw _privateConstructorUsedError;
  DateTime? get subscriptionStartDate => throw _privateConstructorUsedError;
  DateTime? get subscriptionExpiryDate => throw _privateConstructorUsedError;
  DateTime? get trialStartDate => throw _privateConstructorUsedError;
  DateTime? get trialExpiryDate => throw _privateConstructorUsedError;
  bool? get willRenew => throw _privateConstructorUsedError;
  String? get store => throw _privateConstructorUsedError;
  int? get totalPurchases => throw _privateConstructorUsedError;
  double? get lifetimeValue => throw _privateConstructorUsedError;
  DateTime? get lastPurchaseDate => throw _privateConstructorUsedError;
  List<String> get ownedProducts => throw _privateConstructorUsedError;

  /// Serializes this UserSubscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSubscriptionCopyWith<UserSubscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSubscriptionCopyWith<$Res> {
  factory $UserSubscriptionCopyWith(
          UserSubscription value, $Res Function(UserSubscription) then) =
      _$UserSubscriptionCopyWithImpl<$Res, UserSubscription>;
  @useResult
  $Res call(
      {String userId,
      bool isPremium,
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
      List<String> ownedProducts});
}

/// @nodoc
class _$UserSubscriptionCopyWithImpl<$Res, $Val extends UserSubscription>
    implements $UserSubscriptionCopyWith<$Res> {
  _$UserSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? isPremium = null,
    Object? currentProductId = freezed,
    Object? currentPackageId = freezed,
    Object? subscriptionStartDate = freezed,
    Object? subscriptionExpiryDate = freezed,
    Object? trialStartDate = freezed,
    Object? trialExpiryDate = freezed,
    Object? willRenew = freezed,
    Object? store = freezed,
    Object? totalPurchases = freezed,
    Object? lifetimeValue = freezed,
    Object? lastPurchaseDate = freezed,
    Object? ownedProducts = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      currentProductId: freezed == currentProductId
          ? _value.currentProductId
          : currentProductId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPackageId: freezed == currentPackageId
          ? _value.currentPackageId
          : currentPackageId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStartDate: freezed == subscriptionStartDate
          ? _value.subscriptionStartDate
          : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionExpiryDate: freezed == subscriptionExpiryDate
          ? _value.subscriptionExpiryDate
          : subscriptionExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialStartDate: freezed == trialStartDate
          ? _value.trialStartDate
          : trialStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialExpiryDate: freezed == trialExpiryDate
          ? _value.trialExpiryDate
          : trialExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      willRenew: freezed == willRenew
          ? _value.willRenew
          : willRenew // ignore: cast_nullable_to_non_nullable
              as bool?,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPurchases: freezed == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as int?,
      lifetimeValue: freezed == lifetimeValue
          ? _value.lifetimeValue
          : lifetimeValue // ignore: cast_nullable_to_non_nullable
              as double?,
      lastPurchaseDate: freezed == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ownedProducts: null == ownedProducts
          ? _value.ownedProducts
          : ownedProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSubscriptionImplCopyWith<$Res>
    implements $UserSubscriptionCopyWith<$Res> {
  factory _$$UserSubscriptionImplCopyWith(_$UserSubscriptionImpl value,
          $Res Function(_$UserSubscriptionImpl) then) =
      __$$UserSubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      bool isPremium,
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
      List<String> ownedProducts});
}

/// @nodoc
class __$$UserSubscriptionImplCopyWithImpl<$Res>
    extends _$UserSubscriptionCopyWithImpl<$Res, _$UserSubscriptionImpl>
    implements _$$UserSubscriptionImplCopyWith<$Res> {
  __$$UserSubscriptionImplCopyWithImpl(_$UserSubscriptionImpl _value,
      $Res Function(_$UserSubscriptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? isPremium = null,
    Object? currentProductId = freezed,
    Object? currentPackageId = freezed,
    Object? subscriptionStartDate = freezed,
    Object? subscriptionExpiryDate = freezed,
    Object? trialStartDate = freezed,
    Object? trialExpiryDate = freezed,
    Object? willRenew = freezed,
    Object? store = freezed,
    Object? totalPurchases = freezed,
    Object? lifetimeValue = freezed,
    Object? lastPurchaseDate = freezed,
    Object? ownedProducts = null,
  }) {
    return _then(_$UserSubscriptionImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      currentProductId: freezed == currentProductId
          ? _value.currentProductId
          : currentProductId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPackageId: freezed == currentPackageId
          ? _value.currentPackageId
          : currentPackageId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStartDate: freezed == subscriptionStartDate
          ? _value.subscriptionStartDate
          : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionExpiryDate: freezed == subscriptionExpiryDate
          ? _value.subscriptionExpiryDate
          : subscriptionExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialStartDate: freezed == trialStartDate
          ? _value.trialStartDate
          : trialStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialExpiryDate: freezed == trialExpiryDate
          ? _value.trialExpiryDate
          : trialExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      willRenew: freezed == willRenew
          ? _value.willRenew
          : willRenew // ignore: cast_nullable_to_non_nullable
              as bool?,
      store: freezed == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPurchases: freezed == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as int?,
      lifetimeValue: freezed == lifetimeValue
          ? _value.lifetimeValue
          : lifetimeValue // ignore: cast_nullable_to_non_nullable
              as double?,
      lastPurchaseDate: freezed == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ownedProducts: null == ownedProducts
          ? _value._ownedProducts
          : ownedProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSubscriptionImpl implements _UserSubscription {
  const _$UserSubscriptionImpl(
      {required this.userId,
      required this.isPremium,
      this.currentProductId,
      this.currentPackageId,
      this.subscriptionStartDate,
      this.subscriptionExpiryDate,
      this.trialStartDate,
      this.trialExpiryDate,
      this.willRenew,
      this.store,
      this.totalPurchases,
      this.lifetimeValue,
      this.lastPurchaseDate,
      final List<String> ownedProducts = const []})
      : _ownedProducts = ownedProducts;

  factory _$UserSubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSubscriptionImplFromJson(json);

  @override
  final String userId;
  @override
  final bool isPremium;
  @override
  final String? currentProductId;
  @override
  final String? currentPackageId;
  @override
  final DateTime? subscriptionStartDate;
  @override
  final DateTime? subscriptionExpiryDate;
  @override
  final DateTime? trialStartDate;
  @override
  final DateTime? trialExpiryDate;
  @override
  final bool? willRenew;
  @override
  final String? store;
  @override
  final int? totalPurchases;
  @override
  final double? lifetimeValue;
  @override
  final DateTime? lastPurchaseDate;
  final List<String> _ownedProducts;
  @override
  @JsonKey()
  List<String> get ownedProducts {
    if (_ownedProducts is EqualUnmodifiableListView) return _ownedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ownedProducts);
  }

  @override
  String toString() {
    return 'UserSubscription(userId: $userId, isPremium: $isPremium, currentProductId: $currentProductId, currentPackageId: $currentPackageId, subscriptionStartDate: $subscriptionStartDate, subscriptionExpiryDate: $subscriptionExpiryDate, trialStartDate: $trialStartDate, trialExpiryDate: $trialExpiryDate, willRenew: $willRenew, store: $store, totalPurchases: $totalPurchases, lifetimeValue: $lifetimeValue, lastPurchaseDate: $lastPurchaseDate, ownedProducts: $ownedProducts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSubscriptionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.currentProductId, currentProductId) ||
                other.currentProductId == currentProductId) &&
            (identical(other.currentPackageId, currentPackageId) ||
                other.currentPackageId == currentPackageId) &&
            (identical(other.subscriptionStartDate, subscriptionStartDate) ||
                other.subscriptionStartDate == subscriptionStartDate) &&
            (identical(other.subscriptionExpiryDate, subscriptionExpiryDate) ||
                other.subscriptionExpiryDate == subscriptionExpiryDate) &&
            (identical(other.trialStartDate, trialStartDate) ||
                other.trialStartDate == trialStartDate) &&
            (identical(other.trialExpiryDate, trialExpiryDate) ||
                other.trialExpiryDate == trialExpiryDate) &&
            (identical(other.willRenew, willRenew) ||
                other.willRenew == willRenew) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.totalPurchases, totalPurchases) ||
                other.totalPurchases == totalPurchases) &&
            (identical(other.lifetimeValue, lifetimeValue) ||
                other.lifetimeValue == lifetimeValue) &&
            (identical(other.lastPurchaseDate, lastPurchaseDate) ||
                other.lastPurchaseDate == lastPurchaseDate) &&
            const DeepCollectionEquality()
                .equals(other._ownedProducts, _ownedProducts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      isPremium,
      currentProductId,
      currentPackageId,
      subscriptionStartDate,
      subscriptionExpiryDate,
      trialStartDate,
      trialExpiryDate,
      willRenew,
      store,
      totalPurchases,
      lifetimeValue,
      lastPurchaseDate,
      const DeepCollectionEquality().hash(_ownedProducts));

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSubscriptionImplCopyWith<_$UserSubscriptionImpl> get copyWith =>
      __$$UserSubscriptionImplCopyWithImpl<_$UserSubscriptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSubscriptionImplToJson(
      this,
    );
  }
}

abstract class _UserSubscription implements UserSubscription {
  const factory _UserSubscription(
      {required final String userId,
      required final bool isPremium,
      final String? currentProductId,
      final String? currentPackageId,
      final DateTime? subscriptionStartDate,
      final DateTime? subscriptionExpiryDate,
      final DateTime? trialStartDate,
      final DateTime? trialExpiryDate,
      final bool? willRenew,
      final String? store,
      final int? totalPurchases,
      final double? lifetimeValue,
      final DateTime? lastPurchaseDate,
      final List<String> ownedProducts}) = _$UserSubscriptionImpl;

  factory _UserSubscription.fromJson(Map<String, dynamic> json) =
      _$UserSubscriptionImpl.fromJson;

  @override
  String get userId;
  @override
  bool get isPremium;
  @override
  String? get currentProductId;
  @override
  String? get currentPackageId;
  @override
  DateTime? get subscriptionStartDate;
  @override
  DateTime? get subscriptionExpiryDate;
  @override
  DateTime? get trialStartDate;
  @override
  DateTime? get trialExpiryDate;
  @override
  bool? get willRenew;
  @override
  String? get store;
  @override
  int? get totalPurchases;
  @override
  double? get lifetimeValue;
  @override
  DateTime? get lastPurchaseDate;
  @override
  List<String> get ownedProducts;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSubscriptionImplCopyWith<_$UserSubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchasePackage _$PurchasePackageFromJson(Map<String, dynamic> json) {
  return _PurchasePackage.fromJson(json);
}

/// @nodoc
mixin _$PurchasePackage {
  String get id => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get priceString => throw _privateConstructorUsedError;
  PurchaseType get type => throw _privateConstructorUsedError;
  String? get subscriptionPeriod => throw _privateConstructorUsedError;
  String? get introPrice => throw _privateConstructorUsedError;
  String? get introPeriod => throw _privateConstructorUsedError;
  int? get introDuration => throw _privateConstructorUsedError;
  String? get freeTrialPeriod => throw _privateConstructorUsedError;
  bool? get isAvailable => throw _privateConstructorUsedError;

  /// Serializes this PurchasePackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchasePackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchasePackageCopyWith<PurchasePackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasePackageCopyWith<$Res> {
  factory $PurchasePackageCopyWith(
          PurchasePackage value, $Res Function(PurchasePackage) then) =
      _$PurchasePackageCopyWithImpl<$Res, PurchasePackage>;
  @useResult
  $Res call(
      {String id,
      String identifier,
      String productId,
      String title,
      String description,
      double price,
      String currency,
      String priceString,
      PurchaseType type,
      String? subscriptionPeriod,
      String? introPrice,
      String? introPeriod,
      int? introDuration,
      String? freeTrialPeriod,
      bool? isAvailable});
}

/// @nodoc
class _$PurchasePackageCopyWithImpl<$Res, $Val extends PurchasePackage>
    implements $PurchasePackageCopyWith<$Res> {
  _$PurchasePackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchasePackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? identifier = null,
    Object? productId = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? currency = null,
    Object? priceString = null,
    Object? type = null,
    Object? subscriptionPeriod = freezed,
    Object? introPrice = freezed,
    Object? introPeriod = freezed,
    Object? introDuration = freezed,
    Object? freeTrialPeriod = freezed,
    Object? isAvailable = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      priceString: null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PurchaseType,
      subscriptionPeriod: freezed == subscriptionPeriod
          ? _value.subscriptionPeriod
          : subscriptionPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      introPrice: freezed == introPrice
          ? _value.introPrice
          : introPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      introPeriod: freezed == introPeriod
          ? _value.introPeriod
          : introPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      introDuration: freezed == introDuration
          ? _value.introDuration
          : introDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      freeTrialPeriod: freezed == freeTrialPeriod
          ? _value.freeTrialPeriod
          : freeTrialPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchasePackageImplCopyWith<$Res>
    implements $PurchasePackageCopyWith<$Res> {
  factory _$$PurchasePackageImplCopyWith(_$PurchasePackageImpl value,
          $Res Function(_$PurchasePackageImpl) then) =
      __$$PurchasePackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String identifier,
      String productId,
      String title,
      String description,
      double price,
      String currency,
      String priceString,
      PurchaseType type,
      String? subscriptionPeriod,
      String? introPrice,
      String? introPeriod,
      int? introDuration,
      String? freeTrialPeriod,
      bool? isAvailable});
}

/// @nodoc
class __$$PurchasePackageImplCopyWithImpl<$Res>
    extends _$PurchasePackageCopyWithImpl<$Res, _$PurchasePackageImpl>
    implements _$$PurchasePackageImplCopyWith<$Res> {
  __$$PurchasePackageImplCopyWithImpl(
      _$PurchasePackageImpl _value, $Res Function(_$PurchasePackageImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchasePackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? identifier = null,
    Object? productId = null,
    Object? title = null,
    Object? description = null,
    Object? price = null,
    Object? currency = null,
    Object? priceString = null,
    Object? type = null,
    Object? subscriptionPeriod = freezed,
    Object? introPrice = freezed,
    Object? introPeriod = freezed,
    Object? introDuration = freezed,
    Object? freeTrialPeriod = freezed,
    Object? isAvailable = freezed,
  }) {
    return _then(_$PurchasePackageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      priceString: null == priceString
          ? _value.priceString
          : priceString // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PurchaseType,
      subscriptionPeriod: freezed == subscriptionPeriod
          ? _value.subscriptionPeriod
          : subscriptionPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      introPrice: freezed == introPrice
          ? _value.introPrice
          : introPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      introPeriod: freezed == introPeriod
          ? _value.introPeriod
          : introPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      introDuration: freezed == introDuration
          ? _value.introDuration
          : introDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      freeTrialPeriod: freezed == freeTrialPeriod
          ? _value.freeTrialPeriod
          : freeTrialPeriod // ignore: cast_nullable_to_non_nullable
              as String?,
      isAvailable: freezed == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchasePackageImpl implements _PurchasePackage {
  const _$PurchasePackageImpl(
      {required this.id,
      required this.identifier,
      required this.productId,
      required this.title,
      required this.description,
      required this.price,
      required this.currency,
      required this.priceString,
      required this.type,
      this.subscriptionPeriod,
      this.introPrice,
      this.introPeriod,
      this.introDuration,
      this.freeTrialPeriod,
      this.isAvailable});

  factory _$PurchasePackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchasePackageImplFromJson(json);

  @override
  final String id;
  @override
  final String identifier;
  @override
  final String productId;
  @override
  final String title;
  @override
  final String description;
  @override
  final double price;
  @override
  final String currency;
  @override
  final String priceString;
  @override
  final PurchaseType type;
  @override
  final String? subscriptionPeriod;
  @override
  final String? introPrice;
  @override
  final String? introPeriod;
  @override
  final int? introDuration;
  @override
  final String? freeTrialPeriod;
  @override
  final bool? isAvailable;

  @override
  String toString() {
    return 'PurchasePackage(id: $id, identifier: $identifier, productId: $productId, title: $title, description: $description, price: $price, currency: $currency, priceString: $priceString, type: $type, subscriptionPeriod: $subscriptionPeriod, introPrice: $introPrice, introPeriod: $introPeriod, introDuration: $introDuration, freeTrialPeriod: $freeTrialPeriod, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasePackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.priceString, priceString) ||
                other.priceString == priceString) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.subscriptionPeriod, subscriptionPeriod) ||
                other.subscriptionPeriod == subscriptionPeriod) &&
            (identical(other.introPrice, introPrice) ||
                other.introPrice == introPrice) &&
            (identical(other.introPeriod, introPeriod) ||
                other.introPeriod == introPeriod) &&
            (identical(other.introDuration, introDuration) ||
                other.introDuration == introDuration) &&
            (identical(other.freeTrialPeriod, freeTrialPeriod) ||
                other.freeTrialPeriod == freeTrialPeriod) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      identifier,
      productId,
      title,
      description,
      price,
      currency,
      priceString,
      type,
      subscriptionPeriod,
      introPrice,
      introPeriod,
      introDuration,
      freeTrialPeriod,
      isAvailable);

  /// Create a copy of PurchasePackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasePackageImplCopyWith<_$PurchasePackageImpl> get copyWith =>
      __$$PurchasePackageImplCopyWithImpl<_$PurchasePackageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchasePackageImplToJson(
      this,
    );
  }
}

abstract class _PurchasePackage implements PurchasePackage {
  const factory _PurchasePackage(
      {required final String id,
      required final String identifier,
      required final String productId,
      required final String title,
      required final String description,
      required final double price,
      required final String currency,
      required final String priceString,
      required final PurchaseType type,
      final String? subscriptionPeriod,
      final String? introPrice,
      final String? introPeriod,
      final int? introDuration,
      final String? freeTrialPeriod,
      final bool? isAvailable}) = _$PurchasePackageImpl;

  factory _PurchasePackage.fromJson(Map<String, dynamic> json) =
      _$PurchasePackageImpl.fromJson;

  @override
  String get id;
  @override
  String get identifier;
  @override
  String get productId;
  @override
  String get title;
  @override
  String get description;
  @override
  double get price;
  @override
  String get currency;
  @override
  String get priceString;
  @override
  PurchaseType get type;
  @override
  String? get subscriptionPeriod;
  @override
  String? get introPrice;
  @override
  String? get introPeriod;
  @override
  int? get introDuration;
  @override
  String? get freeTrialPeriod;
  @override
  bool? get isAvailable;

  /// Create a copy of PurchasePackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchasePackageImplCopyWith<_$PurchasePackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseEvent _$PurchaseEventFromJson(Map<String, dynamic> json) {
  return _PurchaseEvent.fromJson(json);
}

/// @nodoc
mixin _$PurchaseEvent {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  PurchaseEventType get eventType => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get productId => throw _privateConstructorUsedError;
  String? get packageId => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PurchaseEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseEventCopyWith<PurchaseEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseEventCopyWith<$Res> {
  factory $PurchaseEventCopyWith(
          PurchaseEvent value, $Res Function(PurchaseEvent) then) =
      _$PurchaseEventCopyWithImpl<$Res, PurchaseEvent>;
  @useResult
  $Res call(
      {String id,
      String userId,
      PurchaseEventType eventType,
      DateTime timestamp,
      String? productId,
      String? packageId,
      double? price,
      String? currency,
      String? transactionId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$PurchaseEventCopyWithImpl<$Res, $Val extends PurchaseEvent>
    implements $PurchaseEventCopyWith<$Res> {
  _$PurchaseEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eventType = null,
    Object? timestamp = null,
    Object? productId = freezed,
    Object? packageId = freezed,
    Object? price = freezed,
    Object? currency = freezed,
    Object? transactionId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as PurchaseEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      packageId: freezed == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseEventImplCopyWith<$Res>
    implements $PurchaseEventCopyWith<$Res> {
  factory _$$PurchaseEventImplCopyWith(
          _$PurchaseEventImpl value, $Res Function(_$PurchaseEventImpl) then) =
      __$$PurchaseEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      PurchaseEventType eventType,
      DateTime timestamp,
      String? productId,
      String? packageId,
      double? price,
      String? currency,
      String? transactionId,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$PurchaseEventImplCopyWithImpl<$Res>
    extends _$PurchaseEventCopyWithImpl<$Res, _$PurchaseEventImpl>
    implements _$$PurchaseEventImplCopyWith<$Res> {
  __$$PurchaseEventImplCopyWithImpl(
      _$PurchaseEventImpl _value, $Res Function(_$PurchaseEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? eventType = null,
    Object? timestamp = null,
    Object? productId = freezed,
    Object? packageId = freezed,
    Object? price = freezed,
    Object? currency = freezed,
    Object? transactionId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$PurchaseEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as PurchaseEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      packageId: freezed == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseEventImpl implements _PurchaseEvent {
  const _$PurchaseEventImpl(
      {required this.id,
      required this.userId,
      required this.eventType,
      required this.timestamp,
      this.productId,
      this.packageId,
      this.price,
      this.currency,
      this.transactionId,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$PurchaseEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseEventImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final PurchaseEventType eventType;
  @override
  final DateTime timestamp;
  @override
  final String? productId;
  @override
  final String? packageId;
  @override
  final double? price;
  @override
  final String? currency;
  @override
  final String? transactionId;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PurchaseEvent(id: $id, userId: $userId, eventType: $eventType, timestamp: $timestamp, productId: $productId, packageId: $packageId, price: $price, currency: $currency, transactionId: $transactionId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      eventType,
      timestamp,
      productId,
      packageId,
      price,
      currency,
      transactionId,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseEventImplCopyWith<_$PurchaseEventImpl> get copyWith =>
      __$$PurchaseEventImplCopyWithImpl<_$PurchaseEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseEventImplToJson(
      this,
    );
  }
}

abstract class _PurchaseEvent implements PurchaseEvent {
  const factory _PurchaseEvent(
      {required final String id,
      required final String userId,
      required final PurchaseEventType eventType,
      required final DateTime timestamp,
      final String? productId,
      final String? packageId,
      final double? price,
      final String? currency,
      final String? transactionId,
      final Map<String, dynamic>? metadata}) = _$PurchaseEventImpl;

  factory _PurchaseEvent.fromJson(Map<String, dynamic> json) =
      _$PurchaseEventImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  PurchaseEventType get eventType;
  @override
  DateTime get timestamp;
  @override
  String? get productId;
  @override
  String? get packageId;
  @override
  double? get price;
  @override
  String? get currency;
  @override
  String? get transactionId;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PurchaseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseEventImplCopyWith<_$PurchaseEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
