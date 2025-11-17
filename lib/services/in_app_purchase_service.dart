import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

/// Service for handling in-app purchases
class InAppPurchaseService {
  static final InAppPurchaseService _instance = InAppPurchaseService._internal();
  factory InAppPurchaseService() => _instance;
  InAppPurchaseService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  // Product IDs - These should match your App Store Connect and Google Play Console configuration
  static const String premiumMonthlyId = 'premium_monthly';
  static const String premiumYearlyId = 'premium_yearly';
  static const String premiumLifetimeId = 'premium_lifetime';

  static const List<String> _productIds = [
    premiumMonthlyId,
    premiumYearlyId,
    premiumLifetimeId,
  ];

  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  bool _isAvailable = false;
  bool _isInitialized = false;

  // Callbacks
  Function(PurchaseDetails)? onPurchaseUpdated;
  Function(String)? onPurchaseError;
  Function()? onPurchaseRestored;

  /// Check if in-app purchases are available
  bool get isAvailable => _isAvailable;

  /// Check if the service is initialized
  bool get isInitialized => _isInitialized;

  /// Get all available products
  List<ProductDetails> get products => _products;

  /// Get all purchases
  List<PurchaseDetails> get purchases => _purchases;

  /// Check if user has active premium subscription
  bool get hasPremiumAccess {
    return _purchases.any((purchase) {
      if (purchase.status != PurchaseStatus.purchased) return false;

      // Check if the purchase is one of our premium products
      return _productIds.contains(purchase.productID);
    });
  }

  /// Initialize the purchase service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Check if in-app purchase is available
      _isAvailable = await _iap.isAvailable();

      if (!_isAvailable) {
        debugPrint('InAppPurchase not available');
        return;
      }

      // Set up platform-specific configurations
      if (Platform.isIOS) {
        final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
            _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
        await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
      }

      // Listen to purchase updates
      _subscription = _iap.purchaseStream.listen(
        _onPurchaseUpdate,
        onDone: _onPurchaseDone,
        onError: _onPurchaseError,
      );

      // Load products
      await loadProducts();

      // Restore purchases
      await restorePurchases();

      _isInitialized = true;
      debugPrint('InAppPurchaseService initialized successfully');
    } catch (e) {
      debugPrint('Error initializing InAppPurchaseService: $e');
      rethrow;
    }
  }

  /// Load available products from the store
  Future<void> loadProducts() async {
    try {
      final ProductDetailsResponse response = await _iap.queryProductDetails(_productIds.toSet());

      if (response.error != null) {
        debugPrint('Error loading products: ${response.error}');
        return;
      }

      _products = response.productDetails;
      debugPrint('Loaded ${_products.length} products');

      for (var product in _products) {
        debugPrint('Product: ${product.id} - ${product.title} - ${product.price}');
      }
    } catch (e) {
      debugPrint('Error in loadProducts: $e');
    }
  }

  /// Purchase a product
  Future<bool> purchaseProduct(ProductDetails product) async {
    try {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);

      // Check if it's a consumable or non-consumable/subscription
      bool isConsumable = false; // Our premium subscriptions are non-consumable

      bool success;
      if (isConsumable) {
        success = await _iap.buyConsumable(purchaseParam: purchaseParam);
      } else {
        success = await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      }

      return success;
    } catch (e) {
      debugPrint('Error purchasing product: $e');
      onPurchaseError?.call(e.toString());
      return false;
    }
  }

  /// Restore previous purchases
  Future<void> restorePurchases() async {
    try {
      await _iap.restorePurchases();
      onPurchaseRestored?.call();
      debugPrint('Purchases restored');
    } catch (e) {
      debugPrint('Error restoring purchases: $e');
      onPurchaseError?.call(e.toString());
    }
  }

  /// Handle purchase updates
  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      debugPrint('Purchase update: ${purchaseDetails.productID} - ${purchaseDetails.status}');

      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Handle pending state
        debugPrint('Purchase pending: ${purchaseDetails.productID}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        // Verify and deliver product
        _verifyPurchase(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle error
        debugPrint('Purchase error: ${purchaseDetails.error}');
        onPurchaseError?.call(purchaseDetails.error?.message ?? 'Unknown error');
      }

      // Complete the purchase
      if (purchaseDetails.pendingCompletePurchase) {
        _iap.completePurchase(purchaseDetails);
      }
    }
  }

  /// Verify purchase (implement server-side verification in production)
  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    try {
      // TODO: In production, verify the purchase with your backend server
      // For now, we'll trust the platform's verification

      debugPrint('Verifying purchase: ${purchaseDetails.productID}');

      // Add to purchases list if not already there
      if (!_purchases.any((p) => p.productID == purchaseDetails.productID)) {
        _purchases.add(purchaseDetails);
      }

      // Call the callback
      onPurchaseUpdated?.call(purchaseDetails);

      debugPrint('Purchase verified: ${purchaseDetails.productID}');
    } catch (e) {
      debugPrint('Error verifying purchase: $e');
    }
  }

  void _onPurchaseDone() {
    debugPrint('Purchase stream done');
  }

  void _onPurchaseError(error) {
    debugPrint('Purchase stream error: $error');
    onPurchaseError?.call(error.toString());
  }

  /// Get product by ID
  ProductDetails? getProduct(String productId) {
    try {
      return _products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  /// Dispose the service
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _isInitialized = false;
  }
}

/// iOS Payment Queue Delegate
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
