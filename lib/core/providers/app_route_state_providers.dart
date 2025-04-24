import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:selam_app/features/onboarding/pages/client_registration_page.dart';


import '../constants/routes.dart';
import '../../features/onboarding/pages/get_started_page.dart';
import '../../features/onboarding/pages/features_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/registration_page.dart';

import '../../features/admin/pages/admin_home_page.dart';
import '../../features/home/pages/content_supervisor_home_page.dart';
import '../../features/home/pages/content_creator_home_page.dart';
import '../../features/home/pages/course_trainer_home_page.dart';
import '../../features/home/pages/therapist_home_page.dart';
import '../../features/home/pages/client_home_page.dart';

/// Provider that supplies a static GoRouter instance for navigation.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,

    /// Application route definitions.
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
        path: Routes.client_registration,
        builder: (context, state) => const ClientRegistrationPage(),
      ),
      GoRoute(
        path: Routes.registration,
        builder: (context, state) => const RegistrationPage(),
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
        builder: (context, state) => const ClientHomePage(),
      ),
    ],

    /// Fallback error page for unknown routes.
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
              onPressed: () => context.go(Routes.initial),
              child: const Text('Go to Start'),
            ),
          ],
        ),
      ),
    ),
  );
});
