import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider to manage the first-time user state
final isFirstTimeProvider = StateNotifierProvider<FirstTimeNotifier, bool>((ref) {
  return FirstTimeNotifier();
});

/// Notifier class to handle first-time user state
class FirstTimeNotifier extends StateNotifier<bool> {
  FirstTimeNotifier() : super(true) {
    _loadFirstTimeState();
  }

  /// Loads the first-time state from SharedPreferences
  Future<void> _loadFirstTimeState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isFirstTime') ?? true;
  }

  /// Sets the first-time state to false
  Future<void> setNotFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    state = false;
  }

  /// Resets the first-time state to true
  Future<void> resetFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', true);
    state = true;
  }
} 