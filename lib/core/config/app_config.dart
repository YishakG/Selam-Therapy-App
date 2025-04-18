import 'package:flutter/material.dart';

/// Configuration class for the application
class AppConfig {
  /// Private constructor to prevent instantiation
  AppConfig._();

  /// App name
  static const String appName = 'Selam';

  /// App version
  static const String appVersion = '1.0.0';

  /// API base URL
  static const String apiBaseUrl = 'https://api.selam.com';

  /// Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('am'), // Amharic
  ];

  /// Default locale
  static const Locale defaultLocale = Locale('en');

  /// API timeout duration
  static const Duration apiTimeout = Duration(seconds: 30);

  /// Cache duration
  static const Duration cacheDuration = Duration(days: 7);

  /// Maximum file size for uploads (in bytes)
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB

  /// Maximum retry attempts for API calls
  static const int maxRetryAttempts = 3;
} 