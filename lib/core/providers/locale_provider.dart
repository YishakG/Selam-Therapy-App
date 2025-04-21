import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

/// A provider that manages the app's locale state
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

/// A state notifier that manages the app's locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  /// Loads the saved locale from shared preferences
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(AppConfig.languageKey);
    if (savedLocale != null) {
      state = Locale(savedLocale);
    }
  }

  /// Sets the app's locale and saves it to shared preferences
  Future<void> setLocale(Locale locale) async {
    if (!AppConfig.supportedLocales.contains(locale)) {
      return;
    }
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.languageKey, locale.languageCode);
  }
} 