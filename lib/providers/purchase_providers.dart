import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../services/in_app_purchase_service.dart';

/// Provider for the InAppPurchaseService instance
final purchaseServiceProvider = Provider<InAppPurchaseService>((ref) {
  return InAppPurchaseService();
});

/// Provider to check if purchases are available
final purchaseAvailableProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(purchaseServiceProvider);
  if (!service.isInitialized) {
    await service.initialize();
  }
  return service.isAvailable;
});

/// Provider for available products
final availableProductsProvider = FutureProvider<List<ProductDetails>>((ref) async {
  final service = ref.watch(purchaseServiceProvider);
  if (!service.isInitialized) {
    await service.initialize();
  }
  return service.products;
});

/// Provider to check if user has premium access
final hasPremiumAccessProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(purchaseServiceProvider);
  if (!service.isInitialized) {
    await service.initialize();
  }
  return service.hasPremiumAccess;
});

/// Provider for getting a specific product
final productProvider = Provider.family<ProductDetails?, String>((ref, productId) {
  final service = ref.watch(purchaseServiceProvider);
  return service.getProduct(productId);
});

/// Provider for purchase operations
final purchaseControllerProvider = Provider<PurchaseController>((ref) {
  final service = ref.watch(purchaseServiceProvider);
  return PurchaseController(service, ref);
});

/// Controller for handling purchase operations
class PurchaseController {
  final InAppPurchaseService _service;
  final Ref _ref;

  PurchaseController(this._service, this._ref);

  /// Initialize the purchase service
  Future<void> initialize() async {
    await _service.initialize();
  }

  /// Purchase a product
  Future<bool> purchaseProduct(String productId) async {
    final product = _service.getProduct(productId);
    if (product == null) {
      return false;
    }

    final success = await _service.purchaseProduct(product);
    if (success) {
      // Refresh premium status
      _ref.invalidate(hasPremiumAccessProvider);
    }
    return success;
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    await _service.restorePurchases();
    // Refresh premium status
    _ref.invalidate(hasPremiumAccessProvider);
  }

  /// Get product details by ID
  ProductDetails? getProduct(String productId) {
    return _service.getProduct(productId);
  }

  /// Check if user has premium
  bool get hasPremium => _service.hasPremiumAccess;
}
