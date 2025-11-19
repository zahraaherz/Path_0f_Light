import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../config/env_config.dart';

/// Service for handling in-app purchases with RevenueCat
///
/// API keys are configured in lib/config/env_config.dart
/// See env_config.example.dart for setup instructions
class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  // Package/Entitlement identifiers (configure in RevenueCat dashboard)
  static const String premiumEntitlementId = 'premium';

  // Package identifiers (these match your offering packages in RevenueCat)
  static const String monthlyPackageId = '\$rc_monthly';
  static const String yearlyPackageId = '\$rc_annual';
  static const String lifetimePackageId = 'lifetime';

  bool _isInitialized = false;
  CustomerInfo? _customerInfo;
  Offerings? _offerings;

  // Callbacks
  Function(CustomerInfo)? onCustomerInfoUpdated;
  Function(String)? onPurchaseError;
  Function()? onPurchaseRestored;

  /// Check if the service is initialized
  bool get isInitialized => _isInitialized;

  /// Get current customer info
  CustomerInfo? get customerInfo => _customerInfo;

  /// Get available offerings
  Offerings? get offerings => _offerings;

  /// Check if user has active premium subscription
  bool get hasPremiumAccess {
    if (_customerInfo == null) return false;

    // Check for premium entitlement
    final entitlement = _customerInfo!.entitlements.all[premiumEntitlementId];
    return entitlement?.isActive ?? false;
  }

  /// Get active subscription info
  EntitlementInfo? get activeSubscription {
    if (_customerInfo == null) return null;
    return _customerInfo!.entitlements.all[premiumEntitlementId];
  }

  /// Initialize RevenueCat
  Future<void> initialize({required String userId}) async {
    if (_isInitialized) return;

    try {
      // Configure RevenueCat
      final configuration = PurchasesConfiguration(_getApiKey())
        ..appUserID = userId
        ..observerMode = false; // Set to true if using your own purchase logic

      await Purchases.configure(configuration);

      // Enable debug logs in debug mode
      if (kDebugMode) {
        await Purchases.setLogLevel(LogLevel.debug);
      }

      // Set up listener for customer info updates
      Purchases.addCustomerInfoUpdateListener((customerInfo) {
        _customerInfo = customerInfo;
        onCustomerInfoUpdated?.call(customerInfo);
        debugPrint('Customer info updated: ${customerInfo.entitlements.all}');
      });

      // Load initial customer info and offerings
      await _loadCustomerInfo();
      await _loadOfferings();

      _isInitialized = true;
      debugPrint('RevenueCat initialized successfully for user: $userId');
    } catch (e) {
      debugPrint('Error initializing RevenueCat: $e');
      rethrow;
    }
  }

  /// Get the appropriate API key based on platform
  /// API keys are loaded from EnvConfig (lib/config/env_config.dart)
  String _getApiKey() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return EnvConfig.revenueCatIosApiKey;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return EnvConfig.revenueCatAndroidApiKey;
    } else {
      throw UnsupportedError('Platform not supported for RevenueCat');
    }
  }

  /// Load customer info
  Future<void> _loadCustomerInfo() async {
    try {
      _customerInfo = await Purchases.getCustomerInfo();
      debugPrint('Customer info loaded');
    } catch (e) {
      debugPrint('Error loading customer info: $e');
    }
  }

  /// Load available offerings
  Future<void> _loadOfferings() async {
    try {
      _offerings = await Purchases.getOfferings();
      debugPrint('Loaded ${_offerings?.all.length ?? 0} offerings');

      // Log available packages
      _offerings?.current?.availablePackages.forEach((package) {
        debugPrint('Package: ${package.identifier} - ${package.storeProduct.title} - ${package.storeProduct.priceString}');
      });
    } catch (e) {
      debugPrint('Error loading offerings: $e');
    }
  }

  /// Purchase a package
  Future<CustomerInfo> purchasePackage(Package package) async {
    try {
      debugPrint('Purchasing package: ${package.identifier}');

      final purchaseResult = await Purchases.purchasePackage(package);
      _customerInfo = purchaseResult;

      debugPrint('Purchase successful');
      onCustomerInfoUpdated?.call(_customerInfo!);

      return _customerInfo!;
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('Purchase cancelled by user');
        throw Exception('Purchase cancelled');
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        debugPrint('Purchase not allowed');
        throw Exception('Purchase not allowed on this device');
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        debugPrint('Payment pending');
        throw Exception('Payment is pending');
      } else {
        debugPrint('Purchase error: ${e.message}');
        onPurchaseError?.call(e.message ?? 'Unknown error');
        throw Exception(e.message ?? 'Purchase failed');
      }
    }
  }

  /// Restore purchases
  Future<CustomerInfo> restorePurchases() async {
    try {
      debugPrint('Restoring purchases');

      _customerInfo = await Purchases.restorePurchases();
      onPurchaseRestored?.call();

      debugPrint('Purchases restored');
      return _customerInfo!;
    } catch (e) {
      debugPrint('Error restoring purchases: $e');
      onPurchaseError?.call(e.toString());
      rethrow;
    }
  }

  /// Get package by identifier
  Package? getPackage(String identifier) {
    if (_offerings == null || _offerings!.current == null) return null;

    try {
      return _offerings!.current!.availablePackages.firstWhere(
        (package) => package.identifier == identifier,
      );
    } catch (e) {
      debugPrint('Package not found: $identifier');
      return null;
    }
  }

  /// Get all available packages
  List<Package> get availablePackages {
    return _offerings?.current?.availablePackages ?? [];
  }

  /// Update user ID (useful for login/logout)
  Future<void> updateUserId(String userId) async {
    try {
      await Purchases.logIn(userId);
      await _loadCustomerInfo();
      debugPrint('User ID updated: $userId');
    } catch (e) {
      debugPrint('Error updating user ID: $e');
    }
  }

  /// Logout (anonymous user)
  Future<void> logout() async {
    try {
      _customerInfo = await Purchases.logOut();
      debugPrint('User logged out');
    } catch (e) {
      debugPrint('Error logging out: $e');
    }
  }

  /// Get subscription status details
  Map<String, dynamic> getSubscriptionDetails() {
    if (_customerInfo == null) {
      return {
        'isPremium': false,
        'hasActiveSubscription': false,
      };
    }

    final entitlement = _customerInfo!.entitlements.all[premiumEntitlementId];

    if (entitlement == null || !entitlement.isActive) {
      return {
        'isPremium': false,
        'hasActiveSubscription': false,
      };
    }

    final purchaseDate = _parseDate(entitlement.latestPurchaseDate);
    final expirationDate = _parseDate(entitlement.expirationDate);

    return {
      'isPremium': true,
      'hasActiveSubscription': true,
      'productId': entitlement.productIdentifier,
      'willRenew': entitlement.willRenew,
      'periodType': entitlement.periodType.toString(),
      'purchaseDate': purchaseDate?.toIso8601String(),
      'expirationDate': expirationDate?.toIso8601String(),
      'isInTrialPeriod': purchaseDate != null &&
          expirationDate != null &&
          DateTime.now().difference(purchaseDate).inDays <= 7,
      'store': entitlement.store.toString(),
      'isSandbox': entitlement.isSandbox,
    };
  }

  /// Set user attributes (for analytics and segmentation)
  Future<void> setUserAttributes(Map<String, String> attributes) async {
    try {
      for (final entry in attributes.entries) {
        await Purchases.setAttributes({entry.key: entry.value});
      }
      debugPrint('User attributes set');
    } catch (e) {
      debugPrint('Error setting user attributes: $e');
    }
  }

  /// Set email
  Future<void> setEmail(String email) async {
    try {
      await Purchases.setEmail(email);
      debugPrint('Email set: $email');
    } catch (e) {
      debugPrint('Error setting email: $e');
    }
  }

  /// Set display name
  Future<void> setDisplayName(String displayName) async {
    try {
      await Purchases.setDisplayName(displayName);
      debugPrint('Display name set: $displayName');
    } catch (e) {
      debugPrint('Error setting display name: $e');
    }
  }

  /// Check if user is eligible for intro pricing
  /// Note: This method was removed in newer RevenueCat SDK versions
  /// Eligibility is now checked automatically during purchase flow
  Future<Map<String, IntroEligibility>> checkIntroEligibility(
    List<String> productIds,
  ) async {
    try {
      // TODO: Update to use newer SDK method if available
      // For now, return empty map as eligibility is checked automatically
      debugPrint('Intro eligibility check not available in current SDK version');
      return {};
    } catch (e) {
      debugPrint('Error checking intro eligibility: $e');
      return {};
    }
  }

  /// Invalidate customer info cache (force refresh)
  Future<void> invalidateCustomerInfoCache() async {
    try {
      await Purchases.invalidateCustomerInfoCache();
      await _loadCustomerInfo();
      debugPrint('Customer info cache invalidated');
    } catch (e) {
      debugPrint('Error invalidating cache: $e');
    }
  }

  /// Dispose
  void dispose() {
    _isInitialized = false;
    _customerInfo = null;
    _offerings = null;
  }

  /// Parse date from RevenueCat which can be String or DateTime
  DateTime? _parseDate(dynamic date) {
    if (date == null) return null;
    if (date is DateTime) return date;
    if (date is String) {
      try {
        return DateTime.parse(date);
      } catch (e) {
        debugPrint('Error parsing date: $e');
        return null;
      }
    }
    return null;
  }
}
