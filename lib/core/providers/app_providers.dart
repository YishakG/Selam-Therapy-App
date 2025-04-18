import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/routes.dart';
import 'app_state_provider.dart';
import '../../features/onboarding/presentation/pages/get_started_page.dart';
import '../../features/onboarding/presentation/pages/features_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  final isFirstTime = ref.watch(isFirstTimeProvider);

  return GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // If it's not first time, redirect to login
      if (!isFirstTime) {
        // Allow access to login, signup, and home pages
        if (state.matchedLocation == Routes.login || 
            state.matchedLocation == Routes.signup ||
            state.matchedLocation == Routes.home) {
          return null;
        }
        // Redirect to login for all other routes
        return Routes.login;
      }

      // First time user flow
      if (isFirstTime) {
        // Allow access to onboarding flow and auth pages
        if (state.matchedLocation == Routes.initial || 
            state.matchedLocation == Routes.features ||
            state.matchedLocation == Routes.login ||
            state.matchedLocation == Routes.signup ||
            state.matchedLocation == Routes.home) {
          return null;
        }
        // Redirect to initial page for any other route
        return Routes.initial;
      }

      return null;
    },
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
        path: Routes.signup,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Sign Up Page - Coming Soon')),
        ),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}); 