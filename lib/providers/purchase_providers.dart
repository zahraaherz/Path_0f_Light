import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../services/revenue_cat_service.dart';
import '../repositories/purchase_repository.dart';
import '../models/purchase/purchase_history.dart';
import 'auth_providers.dart';

/// Provider for the RevenueCatService instance
final revenueCatServiceProvider = Provider<RevenueCatService>((ref) {
  return RevenueCatService();
});

/// Provider for the PurchaseRepository instance
final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  return PurchaseRepository();
});

/// Provider to initialize RevenueCat with user ID
final revenueCatInitProvider = FutureProvider<void>((ref) async {
  final authState = ref.watch(authStateProvider);
  final service = ref.watch(revenueCatServiceProvider);

  return authState.when(
    data: (user) async {
      if (user != null && !service.isInitialized) {
        await service.initialize(userId: user.uid);
      }
    },
    loading: () {},
    error: (_, __) {},
  );
});

/// Provider for customer info
final customerInfoProvider = StreamProvider<CustomerInfo?>((ref) async* {
  final service = ref.watch(revenueCatServiceProvider);

  // Wait for initialization
  await ref.watch(revenueCatInitProvider.future);

  if (!service.isInitialized) {
    yield null;
    return;
  }

  // Initial customer info
  yield service.customerInfo;

  // Listen for updates
  await for (final _ in Stream.periodic(const Duration(seconds: 5))) {
    await service.invalidateCustomerInfoCache();
    yield service.customerInfo;
  }
});

/// Provider for available offerings
final offeringsProvider = FutureProvider<Offerings?>((ref) async {
  final service = ref.watch(revenueCatServiceProvider);

  // Wait for initialization
  await ref.watch(revenueCatInitProvider.future);

  if (!service.isInitialized) return null;

  return service.offerings;
});

/// Provider for available packages
final availablePackagesProvider = FutureProvider<List<Package>>((ref) async {
  final offerings = await ref.watch(offeringsProvider.future);
  return offerings?.current?.availablePackages ?? [];
});

/// Provider to check if user has premium access
final hasPremiumAccessProvider = StreamProvider<bool>((ref) async* {
  final customerInfo = ref.watch(customerInfoProvider);

  yield* customerInfo.when(
    data: (info) {
      if (info == null) return Stream.value(false);

      final entitlement = info.entitlements.all[RevenueCatService.premiumEntitlementId];
      return Stream.value(entitlement?.isActive ?? false);
    },
    loading: () => Stream.value(false),
    error: (_, __) => Stream.value(false),
  );
});

/// Provider for user subscription from Firestore
final userSubscriptionProvider = StreamProvider<UserSubscription?>((ref) {
  final authState = ref.watch(authStateProvider);
  final repository = ref.watch(purchaseRepositoryProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        return Stream.value(null);
      }
      return repository.streamUserSubscription(user.uid);
    },
    loading: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
});

/// Provider for user's purchase history
final purchaseHistoryProvider = StreamProvider<List<PurchaseHistory>>((ref) {
  final authState = ref.watch(authStateProvider);
  final repository = ref.watch(purchaseRepositoryProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        return Stream.value([]);
      }
      return repository.getUserPurchaseHistory(user.uid);
    },
    loading: () => Stream.value([]),
    error: (_, __) => Stream.value([]),
  );
});

/// Provider for user's purchase events
final purchaseEventsProvider = StreamProvider<List<PurchaseEvent>>((ref) {
  final authState = ref.watch(authStateProvider);
  final repository = ref.watch(purchaseRepositoryProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        return Stream.value([]);
      }
      return repository.getUserPurchaseEvents(user.uid);
    },
    loading: () => Stream.value([]),
    error: (_, __) => Stream.value([]),
  );
});

/// Provider for subscription details
final subscriptionDetailsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(revenueCatServiceProvider);

  // Wait for initialization
  await ref.watch(revenueCatInitProvider.future);

  if (!service.isInitialized) {
    return {'isPremium': false};
  }

  return service.getSubscriptionDetails();
});

/// Provider for purchase operations
final purchaseControllerProvider = Provider<PurchaseController>((ref) {
  final service = ref.watch(revenueCatServiceProvider);
  final repository = ref.watch(purchaseRepositoryProvider);
  final authState = ref.watch(authStateProvider).value;

  return PurchaseController(
    service: service,
    repository: repository,
    ref: ref,
    userId: authState?.uid,
  );
});

/// Controller for handling purchase operations
class PurchaseController {
  final RevenueCatService service;
  final PurchaseRepository repository;
  final Ref ref;
  final String? userId;

  PurchaseController({
    required this.service,
    required this.repository,
    required this.ref,
    this.userId,
  });

  /// Initialize the purchase service
  Future<void> initialize() async {
    if (userId != null) {
      await service.initialize(userId: userId!);
    }
  }

  /// Purchase a package
  Future<CustomerInfo> purchasePackage(Package package) async {
    if (userId == null) {
      throw Exception('User not logged in');
    }

    // Log purchase initiation
    await _logEvent(PurchaseEventType.purchaseInitiated, package: package);

    try {
      final customerInfo = await service.purchasePackage(package);

      // Save purchase to Firestore
      await _savePurchaseToFirestore(package, customerInfo);

      // Log success
      await _logEvent(PurchaseEventType.purchaseCompleted, package: package);

      // Refresh providers
      ref.invalidate(customerInfoProvider);
      ref.invalidate(userSubscriptionProvider);

      return customerInfo;
    } catch (e) {
      // Log failure
      await _logEvent(
        PurchaseEventType.purchaseFailed,
        package: package,
        metadata: {'error': e.toString()},
      );
      rethrow;
    }
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    try {
      await service.restorePurchases();

      // Log restore
      await _logEvent(PurchaseEventType.restoreCompleted);

      // Refresh providers
      ref.invalidate(customerInfoProvider);
      ref.invalidate(userSubscriptionProvider);
    } catch (e) {
      rethrow;
    }
  }

  /// Get package by identifier
  Package? getPackage(String identifier) {
    return service.getPackage(identifier);
  }

  /// Check if user has premium
  bool get hasPremium => service.hasPremiumAccess;

  /// Get available packages
  List<Package> get availablePackages => service.availablePackages;

  /// Set user email
  Future<void> setEmail(String email) async {
    await service.setEmail(email);
  }

  /// Set user display name
  Future<void> setDisplayName(String displayName) async {
    await service.setDisplayName(displayName);
  }

  /// Save purchase to Firestore
  Future<void> _savePurchaseToFirestore(
    Package package,
    CustomerInfo customerInfo,
  ) async {
    if (userId == null) return;

    try {
      final entitlement = customerInfo.entitlements.all[
          RevenueCatService.premiumEntitlementId];

      if (entitlement == null) return;

      // Determine purchase type
      PurchaseType purchaseType;
      if (package.identifier.contains('lifetime')) {
        purchaseType = PurchaseType.lifetime;
      } else {
        purchaseType = PurchaseType.subscription;
      }

      // Create purchase history entry
      final purchaseHistory = PurchaseHistory(
        id: entitlement.identifier,
        userId: userId!,
        productId: entitlement.productIdentifier,
        packageId: package.identifier,
        type: purchaseType,
        price: _extractPrice(package.storeProduct.priceString),
        currency: package.storeProduct.currencyCode ?? 'USD',
        purchaseDate: entitlement.latestPurchaseDate ?? DateTime.now(),
        status: PurchaseStatus.active,
        transactionId: entitlement.identifier,
        originalTransactionId: entitlement.originalPurchaseDate?.toIso8601String(),
        expirationDate: entitlement.expirationDate,
        isInTrialPeriod: false,
        store: entitlement.store.name,
        metadata: {
          'willRenew': entitlement.willRenew,
          'periodType': entitlement.periodType.name,
          'isSandbox': entitlement.isSandbox,
        },
      );

      await repository.savePurchaseHistory(purchaseHistory);

      // Update user subscription status
      final userSubscription = UserSubscription(
        userId: userId!,
        isPremium: true,
        currentProductId: entitlement.productIdentifier,
        currentPackageId: package.identifier,
        subscriptionStartDate: entitlement.latestPurchaseDate,
        subscriptionExpiryDate: entitlement.expirationDate,
        willRenew: entitlement.willRenew,
        store: entitlement.store.name,
        totalPurchases: 1,
        lifetimeValue: _extractPrice(package.storeProduct.priceString),
        lastPurchaseDate: DateTime.now(),
        ownedProducts: [entitlement.productIdentifier],
      );

      await repository.saveUserSubscription(userSubscription);
    } catch (e) {
      print('Error saving purchase to Firestore: $e');
    }
  }

  /// Log purchase event
  Future<void> _logEvent(
    PurchaseEventType eventType, {
    Package? package,
    Map<String, dynamic>? metadata,
  }) async {
    if (userId == null) return;

    try {
      final event = PurchaseEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId!,
        eventType: eventType,
        timestamp: DateTime.now(),
        productId: package?.storeProduct.identifier,
        packageId: package?.identifier,
        price: package != null
            ? _extractPrice(package.storeProduct.priceString)
            : null,
        currency: package?.storeProduct.currencyCode,
        metadata: metadata,
      );

      await repository.logPurchaseEvent(event);
    } catch (e) {
      print('Error logging purchase event: $e');
    }
  }

  /// Extract numeric price from price string
  double _extractPrice(String priceString) {
    // Remove currency symbols and extract number
    final regex = RegExp(r'[\d,.]+');
    final match = regex.firstMatch(priceString);
    if (match != null) {
      final numStr = match.group(0)!.replaceAll(',', '');
      return double.tryParse(numStr) ?? 0.0;
    }
    return 0.0;
  }
}
