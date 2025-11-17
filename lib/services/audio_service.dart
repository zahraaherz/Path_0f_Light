import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Audio Service for managing sound effects and feedback
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _effectsPlayer = AudioPlayer();
  final AudioPlayer _bgMusicPlayer = AudioPlayer();

  bool _soundEnabled = true;
  bool _musicEnabled = true;
  double _volume = 0.7;

  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;
  double get volume => _volume;

  /// Initialize audio service
  Future<void> initialize() async {
    await _effectsPlayer.setVolume(_volume);
    await _bgMusicPlayer.setVolume(_volume * 0.3); // BG music quieter
  }

  /// Play correct answer sound
  Future<void> playCorrect() async {
    if (!_soundEnabled) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/correct.mp3'));
    } catch (e) {
      debugPrint('Error playing correct sound: $e');
    }
  }

  /// Play wrong answer sound
  Future<void> playWrong() async {
    if (!_soundEnabled) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/wrong.mp3'));
    } catch (e) {
      debugPrint('Error playing wrong sound: $e');
    }
  }

  /// Play selection/tap sound
  Future<void> playTap() async {
    if (!_soundEnabled) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/tap.mp3'));
    } catch (e) {
      debugPrint('Error playing tap sound: $e');
    }
  }

  /// Play success/celebration sound
  Future<void> playSuccess() async {
    if (!_soundEnabled) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/success.mp3'));
    } catch (e) {
      debugPrint('Error playing success sound: $e');
    }
  }

  /// Play level up sound
  Future<void> playLevelUp() async {
    if (!_soundEnabled) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/levelup.mp3'));
    } catch (e) {
      debugPrint('Error playing levelup sound: $e');
    }
  }

  /// Play streak sound
  Future<void> playStreak() async {
    if (!_soundEnabled) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/streak.mp3'));
    } catch (e) {
      debugPrint('Error playing streak sound: $e');
    }
  }

  /// Play timer tick sound
  Future<void> playTick() async {
    if (!_soundEnabled) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/tick.mp3'));
    } catch (e) {
      debugPrint('Error playing tick sound: $e');
    }
  }

  /// Play background music
  Future<void> playBackgroundMusic() async {
    if (!_musicEnabled) return;
    try {
      await _bgMusicPlayer.play(
        AssetSource('sounds/bg_music.mp3'),
        volume: _volume * 0.3,
      );
      await _bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
    } catch (e) {
      debugPrint('Error playing background music: $e');
    }
  }

  /// Stop background music
  Future<void> stopBackgroundMusic() async {
    await _bgMusicPlayer.stop();
  }

  /// Toggle sound effects
  void toggleSound(bool enabled) {
    _soundEnabled = enabled;
  }

  /// Toggle background music
  void toggleMusic(bool enabled) {
    _musicEnabled = enabled;
    if (!enabled) {
      stopBackgroundMusic();
    }
  }

  /// Set volume
  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
    _effectsPlayer.setVolume(_volume);
    _bgMusicPlayer.setVolume(_volume * 0.3);
  }

  /// Dispose players
  Future<void> dispose() async {
    await _effectsPlayer.dispose();
    await _bgMusicPlayer.dispose();
  }
}
