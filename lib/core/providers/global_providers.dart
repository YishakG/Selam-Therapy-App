import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/constants.dart';
import '../network/api_client.dart';

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

// API client provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(baseUrl: AppConstants.apiBaseUrl);
});

// User authentication state provider
final authStateProvider = StateProvider<bool>((ref) => false);

// Current user provider
final currentUserProvider = StateProvider<String?>((ref) => null); 