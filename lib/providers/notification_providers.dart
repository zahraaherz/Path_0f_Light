import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/notification_service.dart';

/// Notification service provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// Check if notifications are enabled
final notificationsEnabledProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(notificationServiceProvider);
  return service.areNotificationsEnabled();
});

/// Send test notification
final sendTestNotificationProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(notificationServiceProvider);
  return service.sendTestNotification();
});
