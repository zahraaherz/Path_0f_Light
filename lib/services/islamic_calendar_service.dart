import 'package:flutter/foundation.dart';
import 'package:hijri/hijri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/islamic_events/islamic_event.dart';
import '../data/shia_hijri_calendar.dart';
import 'notification_service.dart';

/// Service for managing Islamic calendar events and notifications
class IslamicCalendarService {
  final NotificationService _notificationService;

  // Shared Preferences Keys
  static const String _keyEventNotificationsEnabled = 'event_notifications_enabled';
  static const String _keyNotificationDaysBefore = 'notification_days_before';

  IslamicCalendarService(this._notificationService);

  /// Check if event notifications are enabled
  Future<bool> areEventNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyEventNotificationsEnabled) ?? true; // Default: enabled
  }

  /// Enable or disable event notifications
  Future<void> setEventNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyEventNotificationsEnabled, enabled);

    if (enabled) {
      // Re-schedule all notifications
      await scheduleAllUpcomingEventNotifications();
    } else {
      // Cancel all event notifications
      await cancelAllEventNotifications();
    }
  }

  /// Get how many days before event to notify (default: 1 day)
  Future<int> getNotificationDaysBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyNotificationDaysBefore) ?? 1;
  }

  /// Set how many days before event to notify
  Future<void> setNotificationDaysBefore(int days) async {
    if (days < 0 || days > 30) {
      throw ArgumentError('Days before must be between 0 and 30');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyNotificationDaysBefore, days);

    // Re-schedule notifications with new timing
    final enabled = await areEventNotificationsEnabled();
    if (enabled) {
      await scheduleAllUpcomingEventNotifications();
    }
  }

  /// Get all Islamic events
  List<IslamicEvent> getAllEvents() {
    return ShiaHijriCalendar.getAllEvents();
  }

  /// Get current Hijri date
  HijriCalendar getCurrentHijriDate() {
    return HijriCalendar.now();
  }

  /// Get events for today
  List<IslamicEvent> getTodaysEvents() {
    final today = HijriCalendar.now();
    return ShiaHijriCalendar.getEventsForDate(today.hMonth, today.hDay);
  }

  /// Get upcoming events
  List<IslamicEvent> getUpcomingEvents({int count = 5}) {
    final today = HijriCalendar.now();
    return ShiaHijriCalendar.getUpcomingEvents(
      currentMonth: today.hMonth,
      currentDay: today.hDay,
      count: count,
    );
  }

  /// Get events for a specific month
  List<IslamicEvent> getEventsForMonth(int month) {
    return ShiaHijriCalendar.getEventsForMonth(month);
  }

  /// Get events for a specific date
  List<IslamicEvent> getEventsForDate(int month, int day) {
    return ShiaHijriCalendar.getEventsForDate(month, day);
  }

  /// Check if today has any events
  bool hasTodaysEvents() {
    return getTodaysEvents().isNotEmpty;
  }

  /// Calculate days until event
  int daysUntilEvent(IslamicEvent event) {
    if (event.hijriMonth == null || event.hijriDay == null) {
      return -1;
    }

    final today = HijriCalendar.now();
    final currentDateValue = today.hMonth * 100 + today.hDay;
    final eventDateValue = event.hijriMonth! * 100 + event.hijriDay!;

    if (eventDateValue >= currentDateValue) {
      // Event is later this year
      return _calculateDaysBetween(
        today.hMonth, today.hDay,
        event.hijriMonth!, event.hijriDay!,
      );
    } else {
      // Event is next year
      final daysToEndOfYear = _calculateDaysBetween(
        today.hMonth, today.hDay,
        12, 29, // Approximate end of year
      );
      final daysFromStartOfYear = _calculateDaysBetween(
        1, 1,
        event.hijriMonth!, event.hijriDay!,
      );
      return daysToEndOfYear + daysFromStartOfYear;
    }
  }

  /// Calculate days between two Hijri dates (approximate)
  int _calculateDaysBetween(int month1, int day1, int month2, int day2) {
    // Simplified calculation - assumes 29.5 days per month average
    final monthDiff = month2 - month1;
    final dayDiff = day2 - day1;
    return (monthDiff * 29.5).round() + dayDiff;
  }

  /// Schedule notification for a specific event
  Future<void> scheduleEventNotification(IslamicEvent event) async {
    final enabled = await areEventNotificationsEnabled();
    if (!enabled) return;

    if (event.hijriMonth == null || event.hijriDay == null) {
      debugPrint('Cannot schedule notification for event without hijri date: ${event.title}');
      return;
    }

    final daysBefore = await getNotificationDaysBefore();
    final daysUntil = daysUntilEvent(event);

    if (daysUntil < 0) {
      debugPrint('Cannot calculate days until event: ${event.title}');
      return;
    }

    // Calculate notification time
    final notificationDays = daysUntil - daysBefore;
    if (notificationDays < 0) {
      // Event is too soon, skip notification
      return;
    }

    final notificationTime = DateTime.now().add(Duration(days: notificationDays));

    // Create notification message based on event type
    String body;
    if (daysBefore == 0) {
      body = 'Today is ${event.title}';
    } else if (daysBefore == 1) {
      body = 'Tomorrow is ${event.title}';
    } else {
      body = '${event.title} is in $daysBefore days';
    }

    try {
      final notificationId = _getNotificationId(event.id);

      // Note: The scheduleCollectionReminder method might need to be updated
      // to accept an integer ID. For now, we'll pass the string ID.
      await _notificationService.scheduleCollectionReminder(
        id: 'event_${event.id}',
        title: _getNotificationTitle(event.type),
        body: body,
        scheduledTime: notificationTime,
      );

      debugPrint('Scheduled notification #$notificationId for ${event.title} at $notificationTime');
    } catch (e) {
      debugPrint('Error scheduling notification for ${event.title}: $e');
    }
  }

  /// Get notification title based on event type
  String _getNotificationTitle(IslamicEventType type) {
    switch (type) {
      case IslamicEventType.birth:
        return 'Blessed Birthday 🌙';
      case IslamicEventType.martyrdom:
        return 'Martyrdom Commemoration 🕊️';
      case IslamicEventType.celebration:
        return 'Islamic Celebration 🌟';
      case IslamicEventType.occasion:
        return 'Special Islamic Occasion 📿';
      case IslamicEventType.fastingDay:
        return 'Recommended Fasting Day 🌙';
    }
  }

  /// Schedule notifications for all upcoming events
  Future<void> scheduleAllUpcomingEventNotifications() async {
    final enabled = await areEventNotificationsEnabled();
    if (!enabled) return;

    // Cancel existing event notifications first
    await cancelAllEventNotifications();

    // Get all events for the current year
    final allEvents = getAllEvents();

    // Schedule notification for each event
    for (var event in allEvents) {
      await scheduleEventNotification(event);
    }

    debugPrint('Scheduled notifications for ${allEvents.length} events');
  }

  /// Cancel all event notifications
  Future<void> cancelAllEventNotifications() async {
    final allEvents = getAllEvents();

    for (var event in allEvents) {
      try {
        final notificationId = _getNotificationId(event.id);
        await _notificationService.cancelNotification(notificationId);
        debugPrint('Cancelled notification for ${event.title}');
      } catch (e) {
        debugPrint('Error cancelling notification for ${event.title}: $e');
      }
    }
  }

  /// Generate a consistent integer notification ID from a string event ID
  int _getNotificationId(String eventId) {
    // Use a simple hash of the string to generate an integer ID
    // Add a base offset to avoid conflicts with other notification types
    const baseOffset = 10000; // Base offset for event notifications
    return baseOffset + eventId.hashCode.abs() % 90000;
  }

  /// Initialize calendar service and schedule notifications
  Future<void> initialize() async {
    final enabled = await areEventNotificationsEnabled();
    if (enabled) {
      await scheduleAllUpcomingEventNotifications();
    }
  }

  /// Get events by type
  List<IslamicEvent> getEventsByType(IslamicEventType type) {
    return ShiaHijriCalendar.getEventsByType(type);
  }

  /// Get all birth celebrations
  List<IslamicEvent> getBirthCelebrations() {
    return ShiaHijriCalendar.getBirthCelebrations();
  }

  /// Get all martyrdom commemorations
  List<IslamicEvent> getMartyrdomCommemorations() {
    return ShiaHijriCalendar.getMartyrdomCommemorations();
  }

  /// Get all major celebrations
  List<IslamicEvent> getMajorCelebrations() {
    return ShiaHijriCalendar.getMajorCelebrations();
  }

  /// Get formatted event description with days until
  String getEventDescription(IslamicEvent event) {
    final days = daysUntilEvent(event);

    if (days == 0) {
      return 'Today';
    } else if (days == 1) {
      return 'Tomorrow';
    } else if (days > 0 && days <= 30) {
      return 'In $days days';
    } else if (days > 30 && days <= 60) {
      final weeks = (days / 7).round();
      return 'In $weeks weeks';
    } else if (days > 60) {
      final months = (days / 30).round();
      return 'In $months months';
    }

    return event.hijriDate;
  }

  /// Check if an event is happening soon (within configured days)
  Future<bool> isEventSoon(IslamicEvent event) async {
    final daysBefore = await getNotificationDaysBefore();
    final daysUntil = daysUntilEvent(event);
    return daysUntil >= 0 && daysUntil <= daysBefore;
  }

  /// Get month name in English
  String getMonthName(int month) {
    return ShiaHijriCalendar.getMonthName(month);
  }

  /// Get month name in Arabic
  String getMonthNameArabic(int month) {
    return ShiaHijriCalendar.getMonthNameArabic(month);
  }
}
