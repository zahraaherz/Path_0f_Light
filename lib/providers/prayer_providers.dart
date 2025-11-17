import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import '../models/prayer/prayer_times_model.dart';
import '../services/prayer_time_service.dart';

// ===== Service Provider =====

/// Prayer time service provider
final prayerTimeServiceProvider = Provider<PrayerTimeService>((ref) {
  return PrayerTimeService();
});

// ===== Prayer Times Providers =====

/// Get today's prayer times
final todayPrayerTimesProvider = FutureProvider<PrayerTimesModel>((ref) async {
  final service = ref.watch(prayerTimeServiceProvider);
  return service.getTodayPrayerTimes();
});

/// Get prayer times for a specific date
final prayerTimesForDateProvider =
    FutureProvider.family<PrayerTimesModel, DateTime>((ref, date) async {
  final service = ref.watch(prayerTimeServiceProvider);
  return service.getPrayerTimesForDate(date);
});

/// Get next prayer
final nextPrayerProvider =
    FutureProvider<({PrayerName name, DateTime time})>((ref) async {
  final service = ref.watch(prayerTimeServiceProvider);
  return service.getNextPrayer();
});

/// Get current prayer
final currentPrayerProvider = FutureProvider<PrayerName?>((ref) async {
  final service = ref.watch(prayerTimeServiceProvider);
  return service.getCurrentPrayer();
});

/// Location permission status
final locationPermissionProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(prayerTimeServiceProvider);
  return service.isLocationPermissionGranted();
});

// ===== Islamic Calendar Providers =====

/// Get today's Hijri date
final todayHijriDateProvider = Provider<HijriCalendar>((ref) {
  return HijriCalendar.now();
});

/// Get Hijri date for a specific Gregorian date
final hijriDateProvider =
    Provider.family<HijriCalendar, DateTime>((ref, date) {
  return HijriCalendar.fromDate(date);
});

// ===== Settings Providers =====

/// Calculation method state
class CalculationMethodNotifier
    extends StateNotifier<CalculationMethod> {
  CalculationMethodNotifier(this.service)
      : super(CalculationMethod.muslimWorldLeague) {
    _loadSavedMethod();
  }

  final PrayerTimeService service;

  Future<void> _loadSavedMethod() async {
    final method = await service.getCalculationMethod();
    state = method;
  }

  Future<void> setMethod(CalculationMethod method) async {
    await service.saveCalculationMethod(method);
    state = method;
  }
}

final calculationMethodProvider =
    StateNotifierProvider<CalculationMethodNotifier, CalculationMethod>((ref) {
  final service = ref.watch(prayerTimeServiceProvider);
  return CalculationMethodNotifier(service);
});
