import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/islamic_calendar_service.dart';
import '../services/notification_service.dart';
import '../models/islamic_events/islamic_event.dart';

/// Provider for the Islamic Calendar Service
final islamicCalendarServiceProvider = Provider<IslamicCalendarService>((ref) {
  final notificationService = NotificationService();
  return IslamicCalendarService(notificationService);
});

/// Provider for checking if event notifications are enabled
final eventNotificationsEnabledProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.areEventNotificationsEnabled();
});

/// Provider for getting notification days before setting
final notificationDaysBeforeProvider = FutureProvider<int>((ref) async {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.getNotificationDaysBefore();
});

/// Provider for getting all Islamic events
final allIslamicEventsProvider = Provider<List<IslamicEvent>>((ref) {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.getAllEvents();
});

/// Provider for getting today's events
final todaysEventsProvider = Provider<List<IslamicEvent>>((ref) {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.getTodaysEvents();
});

/// Provider for getting upcoming events
final upcomingEventsProvider = Provider.family<List<IslamicEvent>, int>(
  (ref, count) {
    final service = ref.watch(islamicCalendarServiceProvider);
    return service.getUpcomingEvents(count: count);
  },
);

/// Provider for checking if today has events
final hasTodaysEventsProvider = Provider<bool>((ref) {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.hasTodaysEvents();
});

/// Provider for getting events by type
final eventsByTypeProvider = Provider.family<List<IslamicEvent>, IslamicEventType>(
  (ref, type) {
    final service = ref.watch(islamicCalendarServiceProvider);
    return service.getEventsByType(type);
  },
);

/// Provider for getting birth celebrations
final birthCelebrationsProvider = Provider<List<IslamicEvent>>((ref) {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.getBirthCelebrations();
});

/// Provider for getting martyrdom commemorations
final martyrdomCommemorationsProvider = Provider<List<IslamicEvent>>((ref) {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.getMartyrdomCommemorations();
});

/// Provider for getting major celebrations
final majorCelebrationsProvider = Provider<List<IslamicEvent>>((ref) {
  final service = ref.watch(islamicCalendarServiceProvider);
  return service.getMajorCelebrations();
});

/// State notifier for managing event notification settings
class EventNotificationSettings extends StateNotifier<AsyncValue<void>> {
  final IslamicCalendarService _service;

  EventNotificationSettings(this._service) : super(const AsyncValue.data(null));

  Future<void> toggleNotifications(bool enabled) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.setEventNotificationsEnabled(enabled);
    });
  }

  Future<void> updateDaysBefore(int days) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.setNotificationDaysBefore(days);
    });
  }
}

/// Provider for event notification settings
final eventNotificationSettingsProvider =
    StateNotifierProvider<EventNotificationSettings, AsyncValue<void>>((ref) {
  final service = ref.watch(islamicCalendarServiceProvider);
  return EventNotificationSettings(service);
});
