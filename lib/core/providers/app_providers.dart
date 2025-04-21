import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/routes.dart';
import 'app_state_provider.dart';
import 'user_role_provider.dart';
import 'global_providers.dart';
import '../services/local_storage_service.dart';

import '../../features/onboarding/presentation/pages/get_started_page.dart';
import '../../features/onboarding/presentation/pages/features_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/registration_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/admin_home_page.dart';
import '../../features/home/presentation/pages/content_supervisor_home_page.dart';
import '../../features/home/presentation/pages/content_creator_home_page.dart';
import '../../features/home/presentation/pages/course_trainer_home_page.dart';
import '../../features/home/presentation/pages/therapist_home_page.dart';
import '../../features/home/presentation/pages/client_home_page.dart' as client;

/// Provider that provides the authentication state
final isAuthenticatedProvider = FutureProvider<bool>((ref) async {
  final localStorage = ref.watch(localStorageServiceProvider);
  final token = await localStorage.getToken();
  return token != null;
});

/// Provider that provides the current user's role
final currentUserRoleProvider = Provider<UserRole>((ref) {
  return ref.watch(userRoleProvider);
});

/// Provider that provides the app's configured [GoRouter] instance.
///
/// This router handles navigation logic including:
/// - First-time user onboarding flow
/// - Authentication redirection
/// - Role-based routing setup
///
/// Usage:
/// ```dart
/// final router = ref.watch(routerProvider);
/// ```
final routerProvider = Provider<GoRouter>((ref) {
  final isFirstTime = ref.watch(isFirstTimeProvider);
  final isAuthenticated = ref.watch(isAuthenticatedProvider).value ?? false;
  final userRole = ref.watch(currentUserRoleProvider);

  return GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,

    /// Handles redirection based on app state.
    ///
    /// If the user is a first-time visitor, they'll stay in the onboarding flow.
    /// Otherwise, they're directed to login unless visiting permitted public pages.
    redirect: (context, state) {
      // Public routes that don't require authentication
      final publicRoutes = [
        Routes.initial,
        Routes.features,
        Routes.login,
        Routes.registration,
      ];

      // If it's a public route, allow access
      if (publicRoutes.contains(state.matchedLocation)) {
        return null;
      }

      // If not authenticated, redirect to login
      if (!isAuthenticated) {
        return Routes.login;
      }

      // Role-based access control
      if (isAuthenticated) {
        // Define allowed routes for each role
        final Map<UserRole, List<String>> roleRoutes = {
          UserRole.admin: [
            Routes.adminDashboard,
            Routes.contentSupervisorDashboard,
            Routes.contentCreatorDashboard,
            Routes.courseTrainerDashboard,
          ],
          UserRole.therapist: [Routes.therapistDashboard],
          UserRole.client: [Routes.clientDashboard],
        };

        // Get allowed routes for current role
        final allowedRoutes = roleRoutes[userRole] ?? [];
        
        // If trying to access a route not allowed for current role
        if (!allowedRoutes.contains(state.matchedLocation) && 
            !publicRoutes.contains(state.matchedLocation)) {
          // Redirect to appropriate dashboard based on role
          return allowedRoutes.isNotEmpty ? allowedRoutes.first : Routes.home;
        }
      }

      return null;
    },

    /// Application route definitions.
    ///
    /// Maps route names to their corresponding page widgets.
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
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: Routes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.adminDashboard,
        builder: (context, state) => const AdminHomePage(),
      ),
      GoRoute(
        path: Routes.contentSupervisorDashboard,
        builder: (context, state) => const ContentSupervisorHomePage(),
      ),
      GoRoute(
        path: Routes.contentCreatorDashboard,
        builder: (context, state) => const ContentCreatorHomePage(),
      ),
      GoRoute(
        path: Routes.courseTrainerDashboard,
        builder: (context, state) => const CourseTrainerHomePage(),
      ),
      GoRoute(
        path: Routes.therapistDashboard,
        builder: (context, state) => const TherapistHomePage(),
      ),
      GoRoute(
        path: Routes.clientDashboard,
        builder: (context, state) => const client.ClientHomePage(),
      ),
    ],

    /// Error page builder for handling unknown routes
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(Routes.home),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
