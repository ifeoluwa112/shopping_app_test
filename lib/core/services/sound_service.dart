import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

/// A service for playing sound effects.
class SoundService {
  /// The factory constructor for the SoundService.
  factory SoundService() => _instance;

  /// The private constructor for the SoundService.
  SoundService._internal();

  /// The singleton instance of the SoundService.
  static final SoundService _instance = SoundService._internal();

  /// The audio player for the SoundService.
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Plays the select sound.
  Future<void> playSelectSound() async {
    try {
      // Play a higher-pitched system sound for selection
      await _audioPlayer.play(AssetSource('sounds/select.mp3'), volume: 0.5);
    } catch (e) {
      // Fallback to haptic feedback if sound file is not available
      await HapticFeedback.lightImpact();
    }
  }

  /// Plays the deselect sound.
  Future<void> playDeselectSound() async {
    try {
      // Play a lower-pitched system sound for deselection
      await _audioPlayer.play(AssetSource('sounds/deselect.mp3'), volume: 0.5);
    } catch (e) {
      // Fallback to haptic feedback if sound file is not available
      await HapticFeedback.selectionClick();
    }
  }

  /// Disposes of the SoundService.
  void dispose() {
    _audioPlayer.dispose();
  }
}
