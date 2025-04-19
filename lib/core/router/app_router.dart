import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/app_state_provider.dart';
import '../constants/routes.dart';
import '../../features/home/presentation/pages/content_creator_home_page.dart';
import '../../features/onboarding/presentation/pages/get_started_page.dart';
import '../../features/onboarding/presentation/pages/features_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/registration_page.dart';

/// Provider that manages the app's router configuration
final routerProvider = Provider<GoRouter>((ref) {
  final isFirstTime = ref.watch(isFirstTimeProvider);

  return GoRouter(
    initialLocation: isFirstTime ? Routes.initial : Routes.home,
    routes: [
      GoRoute(
        path: Routes.initial,
        builder: (context, state) => const GetStartedPage(),
      ),
      GoRoute(
        path: Routes.features,
        builder: (context, state) => const FeaturesPage(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.registration,
        builder: (context, state) => const RegistrationPage(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const ContentCreatorHomePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.error}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    ),
  );
}); 