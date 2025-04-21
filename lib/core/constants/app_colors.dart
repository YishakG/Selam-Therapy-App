import 'package:flutter/material.dart';

/// A centralized color palette for the Selam Therapy application.
///
/// This class defines all the colors used across the app,
/// organized into categories for easy reference and maintenance.
/// Keeping colors in one place ensures a consistent look and feel,
/// and simplifies future theming or rebranding.
class AppColors {
  // -------------------- Primary Colors --------------------

  /// The main brand color used for primary actions and highlights.
  static const Color primary = Color(0xFFFF6B6B);

  /// The secondary brand color used for accents and complementary elements.
  static const Color secondary = Color(0xFF4ECDC4);
  
  // -------------------- Neutral Colors --------------------

  /// The darkest neutral shade, typically used for primary text or high-emphasis elements.
  static const Color black = Color(0xFF2D3436);

  /// A strong grey shade for secondary text or subtle UI components.
  static const Color darkGrey = Color(0xFF636E72);

  /// A mid-grey tone for placeholders, borders, or non-primary UI elements.
  static const Color grey = Color(0xFFB2BEC3);

  /// A soft grey ideal for backgrounds, disabled states, or light borders.
  static const Color lightGrey = Color(0xFFDFE6E9);

  /// Pure white, typically used for backgrounds and elevated surfaces.
  static const Color white = Color(0xFFFFFFFF);
  
  // -------------------- Semantic Colors --------------------

  /// Indicates success states, confirmations, and positive actions.
  static const Color success = Color(0xFF00B894);

  /// Indicates caution or non-critical warnings.
  static const Color warning = Color(0xFFFDAA5D);

  /// Indicates errors, failures, and destructive actions.
  static const Color error = Color(0xFFFF7675);

  /// Used for informational banners, links, or hints.
  static const Color info = Color(0xFF74B9FF);
  
  // -------------------- Background Colors --------------------

  /// The main background color for app screens.
  static const Color background = Color(0xFFF8F9FA);

  /// Default surface color, often used for cards, sheets, and dialogs.
  static const Color surface = Color(0xFFFFFFFF);
  
  // -------------------- Text Colors --------------------

  /// Primary text color for high-contrast readability.
  static const Color textPrimary = Color(0xFF2D3436);

  /// Secondary text color for less prominent text like subtitles.
  static const Color textSecondary = Color(0xFF636E72);

  /// Hint text color for placeholders and input field labels.
  static const Color textHint = Color(0xFFB2BEC3);
  
  // -------------------- Border Colors --------------------

  /// Standard border color for input fields and containers.
  static const Color border = Color(0xFFDFE6E9);

  /// Divider color used to separate sections or list items.
  static const Color divider = Color(0xFFEEEEEE);
}
