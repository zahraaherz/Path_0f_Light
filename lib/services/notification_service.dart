import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

/// Service to handle Firebase Cloud Messaging (Push Notifications)
class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Initialize the notification service
  /// Call this in main.dart after Firebase initialization
  Future<void> initialize() async {
    try {
      // Request permissions (iOS/Web)
      final settings = await _requestPermissions();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('✅ Notification permissions granted');

        // Get and register FCM token
        await _registerFCMToken();

        // Listen for token refresh
        _messaging.onTokenRefresh.listen(_onTokenRefresh);

        // Handle foreground messages
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

        // Handle notification taps (when app is in background)
        FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

        // Handle notification tap when app was terminated
        final initialMessage = await _messaging.getInitialMessage();
        if (initialMessage != null) {
          _handleNotificationTap(initialMessage);
        }
      } else {
        print('⚠️ Notification permissions denied');
      }
    } catch (e) {
      print('❌ Error initializing notifications: $e');
    }
  }

  /// Request notification permissions
  Future<NotificationSettings> _requestPermissions() async {
    return await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  /// Get FCM token and register it with backend
  Future<void> _registerFCMToken() async {
    try {
      final token = await _messaging.getToken();

      if (token != null) {
        print('📱 FCM Token: ${token.substring(0, 20)}...');

        final user = _auth.currentUser;
        if (user != null) {
          await _sendTokenToBackend(token);
        } else {
          print('⚠️ No user signed in, token not registered');
        }
      } else {
        print('⚠️ Failed to get FCM token');
      }
    } catch (e) {
      print('❌ Error registering FCM token: $e');
    }
  }

  /// Send token to backend via Cloud Function
  Future<void> _sendTokenToBackend(String token) async {
    try {
      final platform = _getPlatform();

      final result = await _functions.httpsCallable('registerFCMToken').call({
        'token': token,
        'platform': platform,
      });

      if (result.data['success'] == true) {
        print('✅ FCM token registered with backend');
      }
    } catch (e) {
      print('❌ Error sending token to backend: $e');
    }
  }

  /// Handle token refresh
  Future<void> _onTokenRefresh(String token) async {
    print('🔄 FCM token refreshed');
    await _sendTokenToBackend(token);
  }

  /// Handle foreground messages (when app is open)
  void _handleForegroundMessage(RemoteMessage message) {
    print('📨 Foreground message received');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

    // You can show a local notification here or update UI
    // For now, we'll just log it
    // TODO: Show local notification using flutter_local_notifications
  }

  /// Handle notification tap (when user taps notification)
  void _handleNotificationTap(RemoteMessage message) {
    print('👆 Notification tapped');
    print('Data: ${message.data}');

    // Navigate based on notification type
    final type = message.data['type'];

    switch (type) {
      case 'reminder':
        final reminderId = message.data['reminderId'];
        final collectionItemId = message.data['collectionItemId'];
        print('Navigate to reminder: $reminderId, item: $collectionItemId');
        // TODO: Navigate to collection item details
        break;

      case 'test':
        print('Test notification tapped');
        break;

      default:
        print('Unknown notification type: $type');
    }
  }

  /// Unregister FCM token (call on sign out)
  Future<void> unregisterToken() async {
    try {
      final token = await _messaging.getToken();

      if (token != null) {
        await _functions.httpsCallable('unregisterFCMToken').call({
          'token': token,
        });

        print('✅ FCM token unregistered');
      }
    } catch (e) {
      print('❌ Error unregistering token: $e');
    }
  }

  /// Send a test notification (for debugging)
  Future<void> sendTestNotification() async {
    try {
      final result = await _functions.httpsCallable('sendTestNotification').call();

      if (result.data['success'] == true) {
        print('✅ Test notification sent');
        print('Message: ${result.data['message']}');
      }
    } catch (e) {
      print('❌ Error sending test notification: $e');
      rethrow;
    }
  }

  /// Get current platform
  String _getPlatform() {
    if (kIsWeb) {
      return 'web';
    } else if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    }
    return 'unknown';
  }

  /// Subscribe to a topic (for broadcast notifications)
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      print('✅ Subscribed to topic: $topic');
    } catch (e) {
      print('❌ Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      print('✅ Unsubscribed from topic: $topic');
    } catch (e) {
      print('❌ Error unsubscribing from topic: $e');
    }
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final settings = await _messaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Open app settings (to enable notifications)
  Future<void> openSettings() async {
    // Platform-specific code to open settings
    // This would require platform channels or a package like app_settings
    print('TODO: Open app settings');
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('📨 Background message received');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Data: ${message.data}');

  // Handle the message
  // You can update local database, show notification, etc.
}
