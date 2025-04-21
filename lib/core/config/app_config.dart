import 'package:flutter/material.dart';

/// Configuration class for the Selam Therapy application.
/// 
/// This class serves as a centralized place to define static constants 
/// related to application settings, API endpoints, localization, timeouts, 
/// and storage keys. It prevents magic numbers and hardcoded strings 
/// from spreading across the codebase, promoting maintainability.
class AppConfig {
  /// Private constructor to prevent the instantiation of this class.
  /// 
  /// Since all members are static, the class should not be instantiated.
  AppConfig._();

  // -------------------- App Info --------------------

  /// The name of the application.
  static const String appName = 'Selam Therapy';

  /// The current version of the application.
  static const String appVersion = '1.0.0';

  /// The app's build number.
  static const String appBuildNumber = '1';

  /// The app's package name.
  static const String appPackageName = 'com.selamtherapy.app';

  /// The app's minimum supported Android version.
  static const int minAndroidVersion = 21;

  /// The app's minimum supported iOS version.
  static const String minIosVersion = '13.0';

  // -------------------- API Configuration --------------------

  /// The base URL for all API requests.
  /// 
  /// All endpoint paths will be appended to this URL.
  static const String apiBaseUrl = 'https://api.selamtherapy.com';
  
  // -------------------- API Endpoints --------------------

  /// Endpoint for user login.
  static const String loginEndpoint = '/auth/login';

  /// Endpoint for new user registration.
  static const String registerEndpoint = '/auth/register';

  /// Endpoint for requesting a password reset email.
  static const String forgotPasswordEndpoint = '/auth/forgot-password';

  /// Endpoint for resetting the password using a token.
  static const String resetPasswordEndpoint = '/auth/reset-password';

  /// Endpoint to fetch the currently authenticated user's profile.
  static const String profileEndpoint = '/user/profile';

  /// Endpoint to update the user's profile information.
  static const String updateProfileEndpoint = '/user/update-profile';

  // -------------------- Localization --------------------

  /// A list of supported locales for the app.
  /// 
  /// - `Locale('en')`: English
  /// - `Locale('am')`: Amharic
  /// 
  /// This list is useful for `MaterialApp.supportedLocales` or similar.
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('am'), // Amharic
  ];

  /// The default locale that the app will fall back to
  /// when no matching locale is found.
  static const Locale defaultLocale = Locale('en');

  // -------------------- Timeouts and Durations --------------------

  /// The timeout duration for API requests in milliseconds.
  /// 
  /// Example: `30,000 ms` equals `30 seconds`.
  static const int apiTimeout = 30000;

  /// The duration for which cached data remains valid.
  /// 
  /// Used to define cache expiration policies.
  static const Duration cacheDuration = Duration(days: 7);

  /// The maximum idle time allowed before forcing a session timeout (in minutes).
  static const int sessionTimeoutMinutes = 30;

  /// The maximum allowed login attempts before triggering a lockout or warning.
  static const int maxLoginAttempts = 5;

  /// The maximum number of times a failed API request will be retried.
  static const int maxRetryAttempts = 3;

  // -------------------- File and Storage --------------------

  /// The maximum allowable file size for uploads, in bytes.
  /// 
  /// Example: `10 * 1024 * 1024` equals `10 MB`.
  static const int maxFileSize = 10 * 1024 * 1024;

  /// The storage key for saving the authentication token securely.
  static const String tokenKey = 'auth_token';

  /// The storage key for saving the user's profile or related data locally.
  static const String userDataKey = 'user_data';

  /// The storage key for saving the user's selected language preference.
  static const String languageKey = 'language';

  /// The storage key for saving the user's selected theme preference.
  static const String themeKey = 'theme';
}
