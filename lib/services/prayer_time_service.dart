import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer/prayer_times_model.dart';

/// Service for calculating prayer times using the Adhan package
class PrayerTimeService {
  static const String _latitudeKey = 'user_latitude';
  static const String _longitudeKey = 'user_longitude';
  static const String _locationNameKey = 'user_location_name';
  static const String _calculationMethodKey = 'calculation_method';

  /// Get current prayer times for today
  Future<PrayerTimesModel> getTodayPrayerTimes() async {
    final coordinates = await _getCoordinates();
    final method = await getCalculationMethod();
    final locationName = await _getLocationName();

    return _calculatePrayerTimes(
      coordinates.latitude,
      coordinates.longitude,
      locationName,
      DateTime.now(),
      method,
    );
  }

  /// Get prayer times for a specific date
  Future<PrayerTimesModel> getPrayerTimesForDate(DateTime date) async {
    final coordinates = await _getCoordinates();
    final method = await getCalculationMethod();
    final locationName = await _getLocationName();

    return _calculatePrayerTimes(
      coordinates.latitude,
      coordinates.longitude,
      locationName,
      date,
      method,
    );
  }

  /// Calculate prayer times for given coordinates and date
  PrayerTimesModel _calculatePrayerTimes(
    double latitude,
    double longitude,
    String locationName,
    DateTime date,
    CalculationMethod method,
  ) {
    final coordinates = Coordinates(latitude, longitude);
    final params = _getCalculationParameters(method);
    final prayerTimes = PrayerTimes.today(coordinates, params);

    return PrayerTimesModel(
      date: date,
      fajr: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
      midnight: _calculateMidnight(prayerTimes.maghrib, prayerTimes.fajr),
      locationName: locationName,
      latitude: latitude,
      longitude: longitude,
    );
  }

  /// Calculate midnight (middle of the night between Maghrib and Fajr)
  DateTime _calculateMidnight(DateTime maghrib, DateTime fajr) {
    // If fajr is the next day, add 24 hours
    var fajrTime = fajr;
    if (fajr.isBefore(maghrib)) {
      fajrTime = fajr.add(const Duration(days: 1));
    }

    final duration = fajrTime.difference(maghrib);
    return maghrib.add(Duration(milliseconds: duration.inMilliseconds ~/ 2));
  }

  /// Get calculation parameters based on method
  CalculationParameters _getCalculationParameters(CalculationMethod method) {
    switch (method) {
      case CalculationMethod.muslimWorldLeague:
        return CalculationMethod.muslim_world_league.getParameters();
      case CalculationMethod.egyptian:
        return CalculationMethod.egyptian.getParameters();
      case CalculationMethod.karachi:
        return CalculationMethod.karachi.getParameters();
      case CalculationMethod.ummAlQura:
        return CalculationMethod.umm_al_qura.getParameters();
      case CalculationMethod.dubai:
        return CalculationMethod.dubai.getParameters();
      case CalculationMethod.qatar:
        return CalculationMethod.qatar.getParameters();
      case CalculationMethod.kuwait:
        return CalculationMethod.kuwait.getParameters();
      case CalculationMethod.moonSightingCommittee:
        return CalculationMethod.moon_sighting_committee.getParameters();
      case CalculationMethod.singapore:
        return CalculationMethod.singapore.getParameters();
      case CalculationMethod.northAmerica:
        return CalculationMethod.north_america.getParameters();
      case CalculationMethod.other:
        return CalculationMethod.other.getParameters();
    }
  }

  /// Get user's coordinates (from cache or location services)
  Future<Coordinates> _getCoordinates() async {
    final prefs = await SharedPreferences.getInstance();

    // Try to get cached location
    final cachedLat = prefs.getDouble(_latitudeKey);
    final cachedLon = prefs.getDouble(_longitudeKey);

    if (cachedLat != null && cachedLon != null) {
      return Coordinates(cachedLat, cachedLon);
    }

    // If no cached location, try to get current location
    try {
      final position = await _getCurrentPosition();
      await saveLocation(position.latitude, position.longitude);
      return Coordinates(position.latitude, position.longitude);
    } catch (e) {
      // Fallback to default location (Mecca)
      return Coordinates(21.4225, 39.8262);
    }
  }

  /// Get current position from GPS
  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Save location to cache
  Future<void> saveLocation(
    double latitude,
    double longitude, {
    String? locationName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);
    if (locationName != null) {
      await prefs.setString(_locationNameKey, locationName);
    }
  }

  /// Get location name from cache
  Future<String> _getLocationName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_locationNameKey) ?? 'Unknown Location';
  }

  /// Get saved calculation method
  Future<CalculationMethod> getCalculationMethod() async {
    final prefs = await SharedPreferences.getInstance();
    final methodString = prefs.getString(_calculationMethodKey);

    if (methodString == null) {
      return CalculationMethod.muslimWorldLeague;
    }

    return CalculationMethod.values.firstWhere(
      (method) => method.toString() == methodString,
      orElse: () => CalculationMethod.muslimWorldLeague,
    );
  }

  /// Save calculation method
  Future<void> saveCalculationMethod(CalculationMethod method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_calculationMethodKey, method.toString());
  }

  /// Get next prayer time and name
  Future<({PrayerName name, DateTime time})> getNextPrayer() async {
    final prayerTimes = await getTodayPrayerTimes();
    final now = DateTime.now();

    final prayers = [
      (name: PrayerName.fajr, time: prayerTimes.fajr),
      (name: PrayerName.sunrise, time: prayerTimes.sunrise),
      (name: PrayerName.dhuhr, time: prayerTimes.dhuhr),
      (name: PrayerName.asr, time: prayerTimes.asr),
      (name: PrayerName.maghrib, time: prayerTimes.maghrib),
      (name: PrayerName.isha, time: prayerTimes.isha),
    ];

    for (final prayer in prayers) {
      if (prayer.time.isAfter(now)) {
        return prayer;
      }
    }

    // If all prayers have passed, return tomorrow's Fajr
    final tomorrowTimes = await getPrayerTimesForDate(
      now.add(const Duration(days: 1)),
    );
    return (name: PrayerName.fajr, time: tomorrowTimes.fajr);
  }

  /// Get current prayer (the one currently being performed or just passed)
  Future<PrayerName?> getCurrentPrayer() async {
    final prayerTimes = await getTodayPrayerTimes();
    final now = DateTime.now();

    if (now.isBefore(prayerTimes.fajr)) {
      return null; // Before Fajr
    } else if (now.isBefore(prayerTimes.sunrise)) {
      return PrayerName.fajr;
    } else if (now.isBefore(prayerTimes.dhuhr)) {
      return null; // Between sunrise and Dhuhr
    } else if (now.isBefore(prayerTimes.asr)) {
      return PrayerName.dhuhr;
    } else if (now.isBefore(prayerTimes.maghrib)) {
      return PrayerName.asr;
    } else if (now.isBefore(prayerTimes.isha)) {
      return PrayerName.maghrib;
    } else {
      return PrayerName.isha;
    }
  }

  /// Request location permission
  Future<bool> requestLocationPermission() async {
    try {
      final permission = await Geolocator.requestPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }

  /// Check if location permission is granted
  Future<bool> isLocationPermissionGranted() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}
