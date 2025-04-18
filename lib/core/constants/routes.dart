/// Routes constants for the application.
/// Use these constants instead of hardcoding paths to avoid typos and make maintenance easier.
class Routes {
  // Private constructor to prevent instantiation
  Routes._();

  /// The initial route of the application
  static const String initial = '/';

  /// The features overview route
  static const String features = '/features';

  /// The login route
  static const String login = '/login';

  /// The signup route
  static const String signup = '/signup';

  /// The home route after authentication
  static const String home = '/home';
} 