import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for managing the app's language
final languageProvider = StateProvider<String>((ref) => 'en');

/// Provider for accessing the current locale
final localeProvider = Provider<Locale>((ref) {
  final language = ref.watch(languageProvider);
  return Locale(language);
}); 