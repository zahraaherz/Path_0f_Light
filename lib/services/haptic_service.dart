import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/foundation.dart';

/// Haptic Feedback Service
class HapticService {
  static final HapticService _instance = HapticService._internal();
  factory HapticService() => _instance;
  HapticService._internal();

  bool _enabled = true;
  bool _hasVibrator = false;

  bool get enabled => _enabled;

  /// Initialize haptic service
  Future<void> initialize() async {
    try {
      _hasVibrator = await Vibration.hasVibrator() ?? false;
    } catch (e) {
      debugPrint('Error checking vibrator: $e');
      _hasVibrator = false;
    }
  }

  /// Light tap feedback
  Future<void> light() async {
    if (!_enabled) return;
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Error with light haptic: $e');
    }
  }

  /// Medium tap feedback
  Future<void> medium() async {
    if (!_enabled) return;
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('Error with medium haptic: $e');
    }
  }

  /// Heavy tap feedback
  Future<void> heavy() async {
    if (!_enabled) return;
    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint('Error with heavy haptic: $e');
    }
  }

  /// Selection changed feedback
  Future<void> selection() async {
    if (!_enabled) return;
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      debugPrint('Error with selection haptic: $e');
    }
  }

  /// Success vibration pattern
  Future<void> success() async {
    if (!_enabled || !_hasVibrator) return;
    try {
      await Vibration.vibrate(
        pattern: [0, 100, 50, 100],
        intensities: [0, 128, 0, 255],
      );
    } catch (e) {
      debugPrint('Error with success vibration: $e');
    }
  }

  /// Error vibration pattern
  Future<void> error() async {
    if (!_enabled || !_hasVibrator) return;
    try {
      await Vibration.vibrate(
        pattern: [0, 50, 50, 50, 50, 50],
        intensities: [0, 200, 0, 200, 0, 200],
      );
    } catch (e) {
      debugPrint('Error with error vibration: $e');
    }
  }

  /// Warning vibration
  Future<void> warning() async {
    if (!_enabled || !_hasVibrator) return;
    try {
      await Vibration.vibrate(duration: 200);
    } catch (e) {
      debugPrint('Error with warning vibration: $e');
    }
  }

  /// Custom vibration pattern
  Future<void> custom({
    required List<int> pattern,
    List<int>? intensities,
  }) async {
    if (!_enabled || !_hasVibrator) return;
    try {
      await Vibration.vibrate(
        pattern: pattern,
        intensities: intensities,
      );
    } catch (e) {
      debugPrint('Error with custom vibration: $e');
    }
  }

  /// Toggle haptic feedback
  void toggle(bool enabled) {
    _enabled = enabled;
  }
}
