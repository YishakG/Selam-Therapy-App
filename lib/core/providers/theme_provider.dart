import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';

/// Provider for the app's theme mode (light/dark)
/// 
/// Example:
/// ```dart
/// final themeMode = ref.watch(themeModeProvider);
/// ```
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// Provider for the app's theme data
/// 
/// Example:
/// ```dart
/// final theme = ref.watch(themeProvider);
/// ```
final themeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return themeMode == ThemeMode.dark ? AppTheme.darkTheme : AppTheme.lightTheme;
}); 