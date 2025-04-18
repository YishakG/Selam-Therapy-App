/// Constants used throughout the application.
/// This file contains all the constant values used in the app.
/// 
/// Example usage:
/// ```dart
/// import 'package:selam_app/core/utils/constants.dart';
/// 
/// // Use API base URL
/// final String apiUrl = AppConstants.apiBaseUrl;
/// 
/// // Use app name
/// final String appName = AppConstants.appName;
/// 
/// // Use animation duration
/// final Duration animationDuration = AppConstants.animationDuration;
/// ```
/// 
/// Implementation:
/// ```dart
/// /// Application-wide constants
/// class AppConstants {
///   // App Information
///   static const String appName = 'Selam';
///   static const String appVersion = '1.0.0';
///   static const String appDescription = 'A social networking app for the Ethiopian community';
///   
///   // API Constants
///   static const String apiBaseUrl = 'https://api.selam.app';
///   static const int apiTimeout = 30000; // milliseconds
///   static const String apiVersion = 'v1';
///   
///   // Storage Keys
///   static const String tokenKey = 'auth_token';
///   static const String userKey = 'user_data';
///   static const String settingsKey = 'app_settings';
///   
///   // Animation Durations
///   static const Duration animationDuration = Duration(milliseconds: 300);
///   static const Duration splashDuration = Duration(seconds: 2);
///   static const Duration pageTransitionDuration = Duration(milliseconds: 400);
///   
///   // UI Constants
///   static const double defaultPadding = 16.0;
///   static const double defaultRadius = 8.0;
///   static const double defaultSpacing = 8.0;
///   static const double defaultIconSize = 24.0;
///   
///   // Validation Constants
///   static const int minPasswordLength = 8;
///   static const int maxPasswordLength = 32;
///   static const int minUsernameLength = 3;
///   static const int maxUsernameLength = 20;
///   
///   // File Upload Constants
///   static const int maxImageSize = 5 * 1024 * 1024; // 5MB
///   static const int maxVideoSize = 50 * 1024 * 1024; // 50MB
///   static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png'];
///   static const List<String> allowedVideoTypes = ['mp4', 'mov'];
///   
///   // Pagination Constants
///   static const int defaultPageSize = 20;
///   static const int maxPageSize = 50;
///   
///   // Cache Constants
///   static const Duration cacheDuration = Duration(days: 7);
///   static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
///   
///   // Error Messages
///   static const String genericError = 'Something went wrong. Please try again.';
///   static const String networkError = 'Please check your internet connection.';
///   static const String serverError = 'Server error. Please try again later.';
///   static const String unauthorizedError = 'Please login to continue.';
///   
///   // Success Messages
///   static const String profileUpdated = 'Profile updated successfully';
///   static const String passwordChanged = 'Password changed successfully';
///   static const String postCreated = 'Post created successfully';
///   static const String commentAdded = 'Comment added successfully';
///   
///   // Time Constants
///   static const int maxPostLength = 500;
///   static const int maxCommentLength = 200;
///   static const int maxBioLength = 150;
///   
///   // Social Media Links
///   static const String facebookUrl = 'https://facebook.com/selamapp';
///   static const String twitterUrl = 'https://twitter.com/selamapp';
///   static const String instagramUrl = 'https://instagram.com/selamapp';
///   static const String websiteUrl = 'https://selam.app';
///   
///   // Support Information
///   static const String supportEmail = 'support@selam.app';
///   static const String supportPhone = '+251911234567';
///   static const String supportAddress = 'Addis Ababa, Ethiopia';
///   
///   // Legal Information
///   static const String privacyPolicyUrl = 'https://selam.app/privacy';
///   static const String termsOfServiceUrl = 'https://selam.app/terms';
///   static const String cookiePolicyUrl = 'https://selam.app/cookies';
/// }
/// ``` 