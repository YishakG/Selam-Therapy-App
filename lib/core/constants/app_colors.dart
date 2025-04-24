import 'package:flutter/material.dart';

class AppColors {
  // -------------------- Brand / Identity --------------------

  /// Main branding color — use for AppBar, FAB, primary buttons, active elements.
  static const Color primary = Color(0xFFFF6B6B); // Vibrant Red

  /// Secondary brand color — use for highlights, tags, chips, progress bars.
  static const Color secondary = Color(0xFF4ECDC4); // Teal Mint

  // -------------------- Backgrounds --------------------

  /// Global screen background — used for Scaffold, pages.
  static const Color surfaceBackground = Color(0xFFF8F9FA); // Light Grey

  /// Secondary background — for cards, modals, surfaces on top of backgrounds.
  static const Color primaryBackground = Color(0xFFFFFFFF); // Pure White

  // -------------------- Text --------------------

  /// Main readable text — titles, body, and general content.
  static const Color textPrimary = Color(0xFF2D3436); // Rich Black

  /// Secondary text — labels, descriptions, hints, inactive text.
  static const Color textSecondary = Color(0xFF636E72); // Muted Grey

  /// Tertiary text — placeholders, extremely subtle elements.
  static const Color textTertiary = Color(0xFFB2BEC3); // Pale Grey

  // -------------------- Borders / Dividers --------------------

  /// Thin UI lines, input outlines, card borders, dividers.
  static const Color border = Color(0xFFB2BEC3); // Matches `textTertiary`

  /// Very light gray for subtle section separation or disabled elements.
  static const Color lightGrey = Color(0xFFDFE6E9); // Misty Grey

  // -------------------- Semantic Colors --------------------

  /// For success states — checkmarks, validation, positive alerts.
  static const Color success = Color(0xFF00B894); // Emerald

  /// For caution or warnings — temporary alerts, toasts, tips.
  static const Color warning = Color(0xFFFDAA5D); // Orange-Yellow

  /// For errors or destructive actions — form errors, delete buttons.
  static const Color error = Color(0xFFFF7675); // Coral Red

  // -------------------- Additional States --------------------

  /// Disabled state for buttons, icons, form fields, etc.
  static const Color disabled = Color(0xFFB2BEC3); // Reuse light neutral

  /// Active state highlight — for toggles, selection, hover/focus.
  static const Color active = Color(0xFF74B9FF); // Soft Blue (optional)

  /// Shadow or elevation color — used with BoxShadows for depth.
  static const Color shadow = Color(0x1A000000); // Black at 10% opacity
  // -------------------- Additional UI Labels --------------------

  /// For form label text — use to distinguish labels from content.
  static const Color labelColor = Color(0xFF2C3E50); // Dark Slate

  /// For optional text hints (e.g., "*optional") in labels.
  static const Color optionalHint = Color(0xFF8395A7); // Cool Grey

  // -------------------- Dropdowns --------------------

  /// Background color for dropdown menus.
  static const Color dropdownBackground =
      Color(0xFFFFFFFF); // Matches primaryBackground
  // -------------------- Inputs --------------------

  /// Background color for input fields (TextField, TextFormField, etc.).
  static const Color inputFieldBackground =
      Color(0xFFF1F3F5); // Very light grey for contrast
}
