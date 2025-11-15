import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

/// Service to handle Firebase Cloud Messaging (Push Notifications)
/// and Local Notifications (Scheduled Reminders)
class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Initialize the notification service
  /// Call this in main.dart after Firebase initialization
  Future<void> initialize() async {
    try {
      // Initialize timezone database for scheduled notifications
      tz.initializeTimeZones();

      // Initialize local notifications
      await _initializeLocalNotifications();

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

  /// Initialize local notifications plugin
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
    );

    print('✅ Local notifications initialized');
  }

  /// Handle local notification tap
  void _onLocalNotificationTapped(NotificationResponse response) {
    print('👆 Local notification tapped');
    print('Payload: ${response.payload}');

    // Parse payload and navigate
    if (response.payload != null) {
      final parts = response.payload!.split('|');
      if (parts.length >= 2) {
        final type = parts[0];
        final id = parts[1];

        switch (type) {
          case 'collection':
            print('Navigate to collection item: $id');
            // Navigation will be handled via a global navigator key
            break;
          case 'prayer':
            print('Navigate to prayer times');
            break;
          default:
            print('Unknown notification type: $type');
        }
      }
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
  void _handleForegroundMessage(RemoteMessage message) async {
    print('📨 Foreground message received');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

    // Show local notification when app is in foreground
    if (message.notification != null) {
      await _showLocalNotification(
        title: message.notification!.title ?? 'Path of Light',
        body: message.notification!.body ?? '',
        payload: _buildPayloadFromData(message.data),
      );
    }
  }

  /// Build payload string from message data
  String _buildPayloadFromData(Map<String, dynamic> data) {
    final type = data['type'] ?? 'general';
    final id = data['collectionItemId'] ?? data['reminderId'] ?? '';
    return '$type|$id';
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
        // Navigation handled via global navigator key in main.dart
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
    print('Opening app settings for notifications');
  }

  // ============================================================================
  // LOCAL NOTIFICATION METHODS
  // ============================================================================

  /// Show an immediate local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
    int id = 0,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'path_of_light_general',
      'General Notifications',
      channelDescription: 'General notifications from Path of Light',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Schedule a collection reminder notification
  Future<void> scheduleCollectionReminder({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'path_of_light_reminders',
      'Reminders',
      channelDescription: 'Scheduled reminders for du\'as and collections',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('azan'),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'azan.mp3',
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.zonedSchedule(
      id.hashCode,
      title,
      body,
      tzScheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'collection|$id',
    );

    print('✅ Scheduled reminder: $title at $scheduledTime');
  }

  /// Schedule a prayer time notification
  Future<void> schedulePrayerTimeNotification({
    required String prayerName,
    required DateTime prayerTime,
    int minutesBefore = 10,
  }) async {
    final notificationTime =
        prayerTime.subtract(Duration(minutes: minutesBefore));
    final tzNotificationTime = tz.TZDateTime.from(notificationTime, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'path_of_light_prayer_times',
      'Prayer Times',
      channelDescription: 'Notifications for upcoming prayer times',
      importance: Importance.max,
      priority: Priority.max,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('azan'),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'azan.mp3',
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final title = minutesBefore > 0
        ? '$prayerName Prayer in $minutesBefore minutes'
        : 'It\'s time for $prayerName Prayer';

    await _localNotifications.zonedSchedule(
      prayerName.hashCode,
      title,
      'Time to prepare for prayer',
      tzNotificationTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'prayer|$prayerName',
    );

    print('✅ Scheduled prayer notification: $prayerName at $notificationTime');
  }

  /// Schedule daily prayer time notifications for all 5 prayers
  Future<void> scheduleDailyPrayerNotifications({
    required DateTime fajr,
    required DateTime dhuhr,
    required DateTime asr,
    required DateTime maghrib,
    required DateTime isha,
    int minutesBefore = 10,
  }) async {
    await schedulePrayerTimeNotification(
      prayerName: 'Fajr',
      prayerTime: fajr,
      minutesBefore: minutesBefore,
    );
    await schedulePrayerTimeNotification(
      prayerName: 'Dhuhr',
      prayerTime: dhuhr,
      minutesBefore: minutesBefore,
    );
    await schedulePrayerTimeNotification(
      prayerName: 'Asr',
      prayerTime: asr,
      minutesBefore: minutesBefore,
    );
    await schedulePrayerTimeNotification(
      prayerName: 'Maghrib',
      prayerTime: maghrib,
      minutesBefore: minutesBefore,
    );
    await schedulePrayerTimeNotification(
      prayerName: 'Isha',
      prayerTime: isha,
      minutesBefore: minutesBefore,
    );
  }

  /// Cancel a specific notification by ID
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
    print('✅ Cancelled notification: $id');
  }

  /// Cancel all scheduled notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
    print('✅ Cancelled all notifications');
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
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
