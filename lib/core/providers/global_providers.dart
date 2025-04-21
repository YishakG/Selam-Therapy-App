import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';
import '../services/api_client.dart';
import '../services/local_storage_service.dart';
import 'user_role_provider.dart';

/// Global providers for app-wide state management.
/// These providers are accessible throughout the application.

// Theme provider
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// App theme provider
final appThemeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);
  
  return themeMode == ThemeMode.dark
      ? ThemeData.dark()
      : ThemeData.light();
});

// Connectivity provider
final connectivityProvider = StreamProvider<bool>((ref) {
  // Implement connectivity stream
  return Stream.value(true);
});

// App initialization provider
final appInitializedProvider = FutureProvider<bool>((ref) async {
  // Perform app initialization
  await Future.delayed(const Duration(seconds: 2));
  return true;
});

// Auth state provider
final authStateProvider = StateProvider<bool>((ref) => false);

// API Client provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: AppConfig.apiBaseUrl);
});

// Shared Preferences provider
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// User data provider
final userDataProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

// Theme mode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// Language provider
final languageProvider = StateProvider<String>((ref) => 'en');

// Current user provider
final currentUserProvider = StateProvider<String?>((ref) => null);

/// Provider for the local storage service
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
}); 