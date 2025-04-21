import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider to manage and observe the first-time user state.
///
/// Returns `null` while loading the value from SharedPreferences.
final isFirstTimeProvider = StateNotifierProvider<FirstTimeNotifier, bool?>(
  (ref) => FirstTimeNotifier(),
);

/// StateNotifier class to handle first-time user logic.
class FirstTimeNotifier extends StateNotifier<bool?> {
  FirstTimeNotifier() : super(null) {
    _initialize();
  }

  SharedPreferences? _prefs;

  /// Initializes SharedPreferences and loads the stored first-time state.
  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    state = _prefs?.getBool('isFirstTime') ?? true;
  }

  /// Updates the state directly, useful for testing or manual overrides.
  void updateFirstTimeState(bool value) {
    state = value;
  }

  /// Marks the app as not first-time and persists the change.
  Future<void> setNotFirstTime() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    await _prefs?.setBool('isFirstTime', false);
    state = false;
  }

  /// Resets the first-time state to true and persists it.
  Future<void> resetFirstTime() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    await _prefs?.setBool('isFirstTime', true);
    state = true;
  }
}
