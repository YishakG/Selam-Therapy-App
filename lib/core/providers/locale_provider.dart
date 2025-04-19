import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selam_app/core/config/app_config.dart';

/// A provider that manages the app's locale state
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

/// A state notifier that manages the app's locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(AppConfig.defaultLocale) {
    _loadSavedLocale();
  }

  static const String _localeKey = 'app_locale';

  /// Loads the saved locale from shared preferences
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localeKey);
    if (savedLocale != null && _isSupportedLocale(savedLocale)) {
      state = Locale(savedLocale);
    }
  }

  /// Sets the app's locale and saves it to shared preferences
  Future<void> setLocale(Locale locale) async {
    if (_isSupportedLocale(locale.languageCode)) {
      state = locale;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    }
  }

  /// Checks if the given locale is supported
  bool _isSupportedLocale(String languageCode) {
    return AppConfig.supportedLocales.any((locale) => locale.languageCode == languageCode);
  }
} 