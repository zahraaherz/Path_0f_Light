/// Environment Configuration
///
/// IMPORTANT: Copy this file to env_config.dart and fill in your actual values
/// DO NOT commit env_config.dart to version control - it contains sensitive API keys
///
/// The actual env_config.dart is gitignored for security
class EnvConfig {
  // ==================== ENVIRONMENT ====================

  /// Current environment: 'development' or 'production'
  static const String environment = 'development';

  /// Check if running in development mode
  static bool get isDevelopment => environment == 'development';

  /// Check if running in production mode
  static bool get isProduction => environment == 'production';

  // ==================== REVENUECAT ====================

  /// RevenueCat iOS API Key
  /// Get from: RevenueCat Dashboard > Settings > API Keys
  /// Format: appl_XXXXXXXXXXXXXXXXXXXXXXXX
  static const String revenueCatIosApiKey = 'appl_YOUR_IOS_API_KEY';

  /// RevenueCat Android API Key
  /// Get from: RevenueCat Dashboard > Settings > API Keys
  /// Format: goog_XXXXXXXXXXXXXXXXXXXXXXXX
  static const String revenueCatAndroidApiKey = 'goog_YOUR_ANDROID_API_KEY';

  // ==================== ADMOB ====================

  /// AdMob iOS App ID
  /// Get from: AdMob Console > Apps
  /// Format: ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY
  static const String adMobIosAppId = 'ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY';

  /// AdMob Android App ID
  /// Format: ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY
  static const String adMobAndroidAppId = 'ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY';

  /// AdMob Banner Ad Unit ID (iOS)
  static const String adMobBannerIos = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';

  /// AdMob Banner Ad Unit ID (Android)
  static const String adMobBannerAndroid = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';

  /// AdMob Interstitial Ad Unit ID (iOS)
  static const String adMobInterstitialIos = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';

  /// AdMob Interstitial Ad Unit ID (Android)
  static const String adMobInterstitialAndroid = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';

  /// AdMob Rewarded Ad Unit ID (iOS)
  static const String adMobRewardedIos = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';

  /// AdMob Rewarded Ad Unit ID (Android)
  static const String adMobRewardedAndroid = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';

  // ==================== FEATURE FLAGS ====================

  /// Enable/disable ads
  static const bool enableAds = true;

  /// Enable/disable analytics
  static const bool enableAnalytics = true;

  /// Enable/disable crash reporting
  static const bool enableCrashReporting = true;

  /// Enable/disable battle mode
  static const bool enableBattleMode = true;

  /// Enable/disable tournaments
  static const bool enableTournaments = true;

  /// Enable/disable social sharing
  static const bool enableSocialSharing = true;

  // ==================== VALIDATION ====================

  /// Validate that all required configuration values are set
  /// Call this during app initialization to catch configuration errors early
  static void validate() {
    final errors = <String>[];

    // Check RevenueCat keys
    if (revenueCatIosApiKey.contains('YOUR_') || revenueCatIosApiKey == 'appl_YOUR_IOS_API_KEY') {
      errors.add('RevenueCat iOS API key not configured');
    }

    if (revenueCatAndroidApiKey.contains('YOUR_') || revenueCatAndroidApiKey == 'goog_YOUR_ANDROID_API_KEY') {
      errors.add('RevenueCat Android API key not configured');
    }

    // Check AdMob keys (only if ads are enabled)
    if (enableAds) {
      if (adMobIosAppId.contains('XXXXXXXX')) {
        errors.add('AdMob iOS App ID not configured');
      }

      if (adMobAndroidAppId.contains('XXXXXXXX')) {
        errors.add('AdMob Android App ID not configured');
      }
    }

    // Only throw errors in production
    if (errors.isNotEmpty && isProduction) {
      throw StateError(
        'Environment configuration errors:\n${errors.join('\n')}\n\n'
        'Please configure these values in lib/config/env_config.dart'
      );
    } else if (errors.isNotEmpty && isDevelopment) {
      // Just log warnings in development
      print('⚠️  Environment configuration warnings:');
      for (final error in errors) {
        print('   - $error');
      }
      print('   These are required for production builds.\n');
    }
  }

  /// Get a formatted string with current configuration (for debugging)
  /// WARNING: Never log this in production as it may contain sensitive data
  static String getDebugInfo() {
    if (isProduction) {
      return 'Debug info disabled in production';
    }

    return '''
Environment Configuration:
  Environment: $environment
  Ads Enabled: $enableAds
  Analytics Enabled: $enableAnalytics
  Battle Mode: $enableBattleMode
  Tournaments: $enableTournaments

  RevenueCat iOS: ${revenueCatIosApiKey.substring(0, 10)}...
  RevenueCat Android: ${revenueCatAndroidApiKey.substring(0, 10)}...
''';
  }
}
