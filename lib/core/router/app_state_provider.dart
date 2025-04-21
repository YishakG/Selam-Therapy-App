import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider that manages whether this is the user's first time using the app
final isFirstTimeProvider = StateNotifierProvider<IsFirstTimeNotifier, bool>((ref) {
  return IsFirstTimeNotifier();
});

class IsFirstTimeNotifier extends StateNotifier<bool> {
  IsFirstTimeNotifier() : super(true) {
    _loadFirstTimeStatus();
  }

  Future<void> _loadFirstTimeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isFirstTime') ?? true;
  }

  Future<void> setFirstTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', value);
    state = value;
  }
} 