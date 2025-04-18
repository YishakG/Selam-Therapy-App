import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A service class that handles navigation throughout the app.
/// This service provides methods for navigating to different screens
/// and managing the navigation stack.
class NavigationService {
  final GoRouter _router;

  NavigationService(this._router);

  /// Navigate to a named route
  /// 
  /// Example:
  /// ```dart
  /// navigationService.navigateTo('profile');
  /// ```
  void navigateTo(String routeName, {Map<String, dynamic>? params}) {
    _router.pushNamed(routeName, extra: params);
  }

  /// Navigate to a named route and replace the current route
  /// 
  /// Example:
  /// ```dart
  /// navigationService.navigateToReplacement('home');
  /// ```
  void navigateToReplacement(String routeName, {Map<String, dynamic>? params}) {
    _router.pushReplacementNamed(routeName, extra: params);
  }

  /// Navigate back to the previous route
  /// 
  /// Example:
  /// ```dart
  /// navigationService.goBack();
  /// ```
  void goBack() {
    _router.pop();
  }

  /// Navigate to a URL path
  /// 
  /// Example:
  /// ```dart
  /// navigationService.navigateToPath('/profile/edit');
  /// ```
  void navigateToPath(String path, {Map<String, dynamic>? params}) {
    _router.push(path, extra: params);
  }

  /// Navigate to a URL path and replace the current route
  /// 
  /// Example:
  /// ```dart
  /// navigationService.navigateToPathReplacement('/home');
  /// ```
  void navigateToPathReplacement(String path, {Map<String, dynamic>? params}) {
    _router.pushReplacement(path, extra: params);
  }

  /// Navigate to a URL path and remove all previous routes
  /// 
  /// Example:
  /// ```dart
  /// navigationService.navigateToPathAndRemoveUntil('/login');
  /// ```
  void navigateToPathAndRemoveUntil(String path, {Map<String, dynamic>? params}) {
    _router.go(path, extra: params);
  }

  /// Show a snackbar with a message
  /// 
  /// Example:
  /// ```dart
  /// navigationService.showSnackBar('Operation successful');
  /// ```
  void showSnackBar(String message, {BuildContext? context}) {
    if (context == null) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show a dialog with a message
  /// 
  /// Example:
  /// ```dart
  /// navigationService.showDialog(
  ///   'Confirm Action',
  ///   'Are you sure you want to proceed?',
  /// );
  /// ```
  Future<bool?> showDialog(
    String title,
    String message, {
    BuildContext? context,
    String? confirmText,
    String? cancelText,
  }) async {
    if (context == null) return null;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(cancelText),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText ?? 'OK'),
          ),
        ],
      ),
    );
  }
} 