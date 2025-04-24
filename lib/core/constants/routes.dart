/// This file defines all the route names used in the Selam Therapy application.
///
/// Centralizing routes in a single class minimizes typos,
/// enhances maintainability, and improves IDE auto-completion.
///
/// Example usage:
/// ```dart
/// import 'package:selam_app/core/constants/routes.dart';
/// 
/// // Navigate to the Home page
/// context.go(Routes.home);
/// ```
class Routes {
  /// Private constructor to prevent instantiation.
  ///
  /// This prevents the `Routes` class from being instantiated
  /// since it's designed to be a pure static constant holder.
  Routes._();

  // ================= Onboarding Routes =================

  /// The initial route, usually displayed when the app starts.
  /// Typically shows a splash screen or a "Get Started" page.
  static const String initial = '/';

  /// Route for the Features page, introducing app capabilities
  /// to new users before authentication.
  static const String features = '/features';

  // ================= Authentication Routes =================

  /// Route for the Login page where users enter credentials.
  static const String login = '/login';

  /// Route for the Registration page where new users can create an account.
  static const String registration = '/registration';

  static const String client_registration = '/client_registration';

  // ================= Main Navigation Routes =================

  /// Route for the Home page — the main dashboard after login.
  static const String home = '/home';

  /// Route for the Home Screen — the main entry point for the app.
  static const String homeScreen = '/home-screen';

  // ================= Admin Routes =================

  /// Route for the Admin Dashboard — the main hub for administrators.
  static const String adminDashboard = '/admin/dashboard';

  /// Route for the Content Supervisor Dashboard.
  /// Manages content moderation and approval.
  static const String contentSupervisorDashboard = '/admin/content-supervisor';

  /// Route for the Content Creator Dashboard.
  /// Manages content creation and publishing.
  static const String contentCreatorDashboard = '/admin/content-creator';

  /// Route for the Course Trainer Dashboard.
  /// Manages course content and training materials.
  static const String courseTrainerDashboard = '/admin/course-trainer';

  // ================= Therapist Routes =================

  /// Route for the Therapist Dashboard.
  /// This is the main landing page for therapists.
  static const String therapistDashboard = '/therapist/dashboard';

  // ================= Client Routes =================

  /// Route for the Client Dashboard.
  /// This is the main landing page for clients.
  static const String clientDashboard = '/client/dashboard';
}
