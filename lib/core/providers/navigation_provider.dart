import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/navigation_service.dart';

/// Provider for the navigation service
/// 
/// Example:
/// ```dart
/// final navigationService = ref.watch(navigationServiceProvider);
/// navigationService.navigateTo('profile');
/// ```
final navigationServiceProvider = Provider<NavigationService>((ref) {
  final router = ref.watch(routerProvider);
  return NavigationService(router);
}); 