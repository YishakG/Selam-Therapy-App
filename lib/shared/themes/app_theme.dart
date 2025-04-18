/// App theme configuration.
/// This file contains the theme data for the entire application.
/// 
/// Example usage:
/// ```dart
/// import 'package:selam_app/shared/themes/app_theme.dart';
/// 
/// // Use the light theme
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   // ...
/// )
/// 
/// // Use the dark theme
/// MaterialApp(
///   theme: AppTheme.darkTheme,
///   // ...
/// )
/// 
/// // Use a specific color
/// Container(
///   color: AppTheme.primaryColor,
///   // ...
/// )
/// ```
/// 
/// Implementation:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:google_fonts/google_fonts.dart';
/// 
/// /// Application theme configuration
/// class AppTheme {
///   // Private constructor to prevent instantiation
///   AppTheme._();
/// 
///   // Color palette
///   static const Color primaryColor = Color(0xFFFF6B00); // Vibrant orange
///   static const Color primaryColorLight = Color(0xFFFF8F40);
///   static const Color primaryColorDark = Color(0xFFE65100);
///   
///   static const Color secondaryColor = Color(0xFF2E7D32); // Green
///   static const Color secondaryColorLight = Color(0xFF60AD5E);
///   static const Color secondaryColorDark = Color(0xFF005005);
///   
///   static const Color accentColor = Color(0xFF2196F3); // Blue
///   static const Color accentColorLight = Color(0xFF6EC6FF);
///   static const Color accentColorDark = Color(0xFF0069C0);
///   
///   static const Color errorColor = Color(0xFFD32F2F); // Red
///   static const Color warningColor = Color(0xFFFFA000); // Amber
///   static const Color successColor = Color(0xFF388E3C); // Green
///   static const Color infoColor = Color(0xFF1976D2); // Blue
///   
///   static const Color backgroundColor = Color(0xFFF5F5F5); // Light gray
///   static const Color surfaceColor = Colors.white;
///   static const Color cardColor = Colors.white;
///   
///   static const Color textPrimaryColor = Color(0xFF212121); // Almost black
///   static const Color textSecondaryColor = Color(0xFF757575); // Gray
///   static const Color textHintColor = Color(0xFFBDBDBD); // Light gray
///   
///   static const Color dividerColor = Color(0xFFE0E0E0); // Light gray
///   static const Color disabledColor = Color(0xFFBDBDBD); // Light gray
///   
///   // Dark theme colors
///   static const Color darkBackgroundColor = Color(0xFF121212); // Dark gray
///   static const Color darkSurfaceColor = Color(0xFF1E1E1E); // Slightly lighter dark gray
///   static const Color darkCardColor = Color(0xFF2C2C2C); // Even lighter dark gray
///   
///   static const Color darkTextPrimaryColor = Color(0xFFF5F5F5); // Almost white
///   static const Color darkTextSecondaryColor = Color(0xFFBDBDBD); // Light gray
///   static const Color darkTextHintColor = Color(0xFF757575); // Gray
///   
///   static const Color darkDividerColor = Color(0xFF424242); // Dark gray
///   static const Color darkDisabledColor = Color(0xFF757575); // Gray
///   
///   // Typography
///   static TextTheme _buildTextTheme(TextTheme base) {
///     return base.copyWith(
///       displayLarge: GoogleFonts.poppins(
///         fontSize: 57,
///         fontWeight: FontWeight.w400,
///         letterSpacing: -0.25,
///       ),
///       displayMedium: GoogleFonts.poppins(
///         fontSize: 45,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0,
///       ),
///       displaySmall: GoogleFonts.poppins(
///         fontSize: 36,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0,
///       ),
///       headlineLarge: GoogleFonts.poppins(
///         fontSize: 32,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0,
///       ),
///       headlineMedium: GoogleFonts.poppins(
///         fontSize: 28,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0,
///       ),
///       headlineSmall: GoogleFonts.poppins(
///         fontSize: 24,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0,
///       ),
///       titleLarge: GoogleFonts.poppins(
///         fontSize: 22,
///         fontWeight: FontWeight.w500,
///         letterSpacing: 0,
///       ),
///       titleMedium: GoogleFonts.poppins(
///         fontSize: 16,
///         fontWeight: FontWeight.w500,
///         letterSpacing: 0.15,
///       ),
///       titleSmall: GoogleFonts.poppins(
///         fontSize: 14,
///         fontWeight: FontWeight.w500,
///         letterSpacing: 0.1,
///       ),
///       labelLarge: GoogleFonts.poppins(
///         fontSize: 14,
///         fontWeight: FontWeight.w500,
///         letterSpacing: 0.1,
///       ),
///       labelMedium: GoogleFonts.poppins(
///         fontSize: 12,
///         fontWeight: FontWeight.w500,
///         letterSpacing: 0.5,
///       ),
///       labelSmall: GoogleFonts.poppins(
///         fontSize: 11,
///         fontWeight: FontWeight.w500,
///         letterSpacing: 0.5,
///       ),
///       bodyLarge: GoogleFonts.poppins(
///         fontSize: 16,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0.5,
///       ),
///       bodyMedium: GoogleFonts.poppins(
///         fontSize: 14,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0.25,
///       ),
///       bodySmall: GoogleFonts.poppins(
///         fontSize: 12,
///         fontWeight: FontWeight.w400,
///         letterSpacing: 0.4,
///       ),
///     );
///   }
///   
///   // Light theme
///   static final ThemeData lightTheme = ThemeData(
///     useMaterial3: true,
///     brightness: Brightness.light,
///     colorScheme: ColorScheme.light(
///       primary: primaryColor,
///       onPrimary: Colors.white,
///       primaryContainer: primaryColorLight,
///       onPrimaryContainer: Colors.black,
///       secondary: secondaryColor,
///       onSecondary: Colors.white,
///       secondaryContainer: secondaryColorLight,
///       onSecondaryContainer: Colors.black,
///       tertiary: accentColor,
///       onTertiary: Colors.white,
///       tertiaryContainer: accentColorLight,
///       onTertiaryContainer: Colors.black,
///       error: errorColor,
///       onError: Colors.white,
///       errorContainer: errorColor.withOpacity(0.1),
///       onErrorContainer: errorColor,
///       background: backgroundColor,
///       onBackground: textPrimaryColor,
///       surface: surfaceColor,
///       onSurface: textPrimaryColor,
///       surfaceVariant: cardColor,
///       onSurfaceVariant: textSecondaryColor,
///       outline: dividerColor,
///       outlineVariant: dividerColor,
///       shadow: Colors.black.withOpacity(0.1),
///       scrim: Colors.black.withOpacity(0.1),
///       inverseSurface: darkSurfaceColor,
///       onInverseSurface: darkTextPrimaryColor,
///       inversePrimary: primaryColorLight,
///     ),
///     scaffoldBackgroundColor: backgroundColor,
///     cardColor: cardColor,
///     dividerColor: dividerColor,
///     disabledColor: disabledColor,
///     textTheme: _buildTextTheme(ThemeData.light().textTheme),
///     primaryTextTheme: _buildTextTheme(ThemeData.light().primaryTextTheme),
///     appBarTheme: AppBarTheme(
///       backgroundColor: primaryColor,
///       foregroundColor: Colors.white,
///       elevation: 0,
///       centerTitle: true,
///       titleTextStyle: GoogleFonts.poppins(
///         fontSize: 20,
///         fontWeight: FontWeight.w600,
///         color: Colors.white,
///       ),
///       iconTheme: const IconThemeData(
///         color: Colors.white,
///       ),
///     ),
///     bottomNavigationBarTheme: BottomNavigationBarThemeData(
///       backgroundColor: surfaceColor,
///       selectedItemColor: primaryColor,
///       unselectedItemColor: textSecondaryColor,
///       type: BottomNavigationBarType.fixed,
///       elevation: 8,
///     ),
///     elevatedButtonTheme: ElevatedButtonThemeData(
///       style: ElevatedButton.styleFrom(
///         backgroundColor: primaryColor,
///         foregroundColor: Colors.white,
///         elevation: 2,
///         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///         shape: RoundedRectangleBorder(
///           borderRadius: BorderRadius.circular(8),
///         ),
///       ),
///     ),
///     outlinedButtonTheme: OutlinedButtonThemeData(
///       style: OutlinedButton.styleFrom(
///         foregroundColor: primaryColor,
///         side: const BorderSide(color: primaryColor),
///         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///         shape: RoundedRectangleBorder(
///           borderRadius: BorderRadius.circular(8),
///         ),
///       ),
///     ),
///     textButtonTheme: TextButtonThemeData(
///       style: TextButton.styleFrom(
///         foregroundColor: primaryColor,
///         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///         shape: RoundedRectangleBorder(
///           borderRadius: BorderRadius.circular(8),
///         ),
///       ),
///     ),
///     inputDecorationTheme: InputDecorationTheme(
///       filled: true,
///       fillColor: Colors.white,
///       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
///       border: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: dividerColor),
///       ),
///       enabledBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: dividerColor),
///       ),
///       focusedBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: primaryColor, width: 2),
///       ),
///       errorBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: errorColor),
///       ),
///       focusedErrorBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: errorColor, width: 2),
///       ),
///       labelStyle: GoogleFonts.poppins(
///         color: textSecondaryColor,
///         fontSize: 16,
///       ),
///       hintStyle: GoogleFonts.poppins(
///         color: textHintColor,
///         fontSize: 16,
///       ),
///       errorStyle: GoogleFonts.poppins(
///         color: errorColor,
///         fontSize: 12,
///       ),
///     ),
///     cardTheme: CardTheme(
///       color: cardColor,
///       elevation: 2,
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(12),
///       ),
///     ),
///     dialogTheme: DialogTheme(
///       backgroundColor: surfaceColor,
///       elevation: 24,
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///       ),
///       titleTextStyle: GoogleFonts.poppins(
///         fontSize: 20,
///         fontWeight: FontWeight.w600,
///         color: textPrimaryColor,
///       ),
///       contentTextStyle: GoogleFonts.poppins(
///         fontSize: 16,
///         color: textSecondaryColor,
///       ),
///     ),
///     snackBarTheme: SnackBarThemeData(
///       backgroundColor: surfaceColor,
///       contentTextStyle: GoogleFonts.poppins(
///         fontSize: 16,
///         color: textPrimaryColor,
///       ),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(8),
///       ),
///       behavior: SnackBarBehavior.floating,
///     ),
///     chipTheme: ChipThemeData(
///       backgroundColor: backgroundColor,
///       disabledColor: disabledColor,
///       selectedColor: primaryColorLight,
///       secondarySelectedColor: secondaryColorLight,
///       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///         side: const BorderSide(color: dividerColor),
///       ),
///       labelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         color: textPrimaryColor,
///       ),
///       secondaryLabelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         color: Colors.white,
///       ),
///       brightness: Brightness.light,
///     ),
///     tabBarTheme: TabBarTheme(
///       labelColor: primaryColor,
///       unselectedLabelColor: textSecondaryColor,
///       indicatorSize: TabBarIndicatorSize.tab,
///       indicator: UnderlineTabIndicator(
///         borderSide: BorderSide(color: primaryColor, width: 2),
///       ),
///       labelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         fontWeight: FontWeight.w600,
///       ),
///       unselectedLabelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         fontWeight: FontWeight.w400,
///       ),
///     ),
///     tooltipTheme: TooltipThemeData(
///       decoration: BoxDecoration(
///         color: surfaceColor,
///         borderRadius: BorderRadius.circular(8),
///         boxShadow: [
///           BoxShadow(
///             color: Colors.black.withOpacity(0.1),
///             blurRadius: 4,
///             offset: const Offset(0, 2),
///           ),
///         ],
///       ),
///       textStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         color: textPrimaryColor,
///       ),
///     ),
///     bottomSheetTheme: BottomSheetThemeData(
///       backgroundColor: surfaceColor,
///       shape: const RoundedRectangleBorder(
///         borderRadius: BorderRadius.vertical(
///           top: Radius.circular(16),
///         ),
///       ),
///     ),
///     timePickerTheme: TimePickerThemeData(
///       backgroundColor: surfaceColor,
///       hourMinuteTextColor: textPrimaryColor,
///       dayPeriodTextColor: textSecondaryColor,
///       dialHandColor: primaryColor,
///       dialBackgroundColor: backgroundColor,
///       dialTextColor: textPrimaryColor,
///       entryModeIconColor: primaryColor,
///       hourMinuteShape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(8),
///       ),
///       dayPeriodShape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(8),
///       ),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///       ),
///     ),
///     datePickerTheme: DatePickerThemeData(
///       backgroundColor: surfaceColor,
///       headerBackgroundColor: primaryColor,
///       headerForegroundColor: Colors.white,
///       dayStyle: GoogleFonts.poppins(
///         color: textPrimaryColor,
///       ),
///       yearStyle: GoogleFonts.poppins(
///         color: textPrimaryColor,
///       ),
///       weekdayStyle: GoogleFonts.poppins(
///         color: textSecondaryColor,
///       ),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///       ),
///     ),
///   );
///   
///   // Dark theme
///   static final ThemeData darkTheme = ThemeData(
///     useMaterial3: true,
///     brightness: Brightness.dark,
///     colorScheme: ColorScheme.dark(
///       primary: primaryColor,
///       onPrimary: Colors.white,
///       primaryContainer: primaryColorDark,
///       onPrimaryContainer: Colors.white,
///       secondary: secondaryColor,
///       onSecondary: Colors.white,
///       secondaryContainer: secondaryColorDark,
///       onSecondaryContainer: Colors.white,
///       tertiary: accentColor,
///       onTertiary: Colors.white,
///       tertiaryContainer: accentColorDark,
///       onTertiaryContainer: Colors.white,
///       error: errorColor,
///       onError: Colors.white,
///       errorContainer: errorColor.withOpacity(0.1),
///       onErrorContainer: errorColor,
///       background: darkBackgroundColor,
///       onBackground: darkTextPrimaryColor,
///       surface: darkSurfaceColor,
///       onSurface: darkTextPrimaryColor,
///       surfaceVariant: darkCardColor,
///       onSurfaceVariant: darkTextSecondaryColor,
///       outline: darkDividerColor,
///       outlineVariant: darkDividerColor,
///       shadow: Colors.black.withOpacity(0.3),
///       scrim: Colors.black.withOpacity(0.3),
///       inverseSurface: surfaceColor,
///       onInverseSurface: textPrimaryColor,
///       inversePrimary: primaryColorDark,
///     ),
///     scaffoldBackgroundColor: darkBackgroundColor,
///     cardColor: darkCardColor,
///     dividerColor: darkDividerColor,
///     disabledColor: darkDisabledColor,
///     textTheme: _buildTextTheme(ThemeData.dark().textTheme),
///     primaryTextTheme: _buildTextTheme(ThemeData.dark().primaryTextTheme),
///     appBarTheme: AppBarTheme(
///       backgroundColor: darkSurfaceColor,
///       foregroundColor: darkTextPrimaryColor,
///       elevation: 0,
///       centerTitle: true,
///       titleTextStyle: GoogleFonts.poppins(
///         fontSize: 20,
///         fontWeight: FontWeight.w600,
///         color: darkTextPrimaryColor,
///       ),
///       iconTheme: IconThemeData(
///         color: darkTextPrimaryColor,
///       ),
///     ),
///     bottomNavigationBarTheme: BottomNavigationBarThemeData(
///       backgroundColor: darkSurfaceColor,
///       selectedItemColor: primaryColor,
///       unselectedItemColor: darkTextSecondaryColor,
///       type: BottomNavigationBarType.fixed,
///       elevation: 8,
///     ),
///     elevatedButtonTheme: ElevatedButtonThemeData(
///       style: ElevatedButton.styleFrom(
///         backgroundColor: primaryColor,
///         foregroundColor: Colors.white,
///         elevation: 2,
///         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///         shape: RoundedRectangleBorder(
///           borderRadius: BorderRadius.circular(8),
///         ),
///       ),
///     ),
///     outlinedButtonTheme: OutlinedButtonThemeData(
///       style: OutlinedButton.styleFrom(
///         foregroundColor: primaryColor,
///         side: const BorderSide(color: primaryColor),
///         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///         shape: RoundedRectangleBorder(
///           borderRadius: BorderRadius.circular(8),
///         ),
///       ),
///     ),
///     textButtonTheme: TextButtonThemeData(
///       style: TextButton.styleFrom(
///         foregroundColor: primaryColor,
///         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
///         shape: RoundedRectangleBorder(
///           borderRadius: BorderRadius.circular(8),
///         ),
///       ),
///     ),
///     inputDecorationTheme: InputDecorationTheme(
///       filled: true,
///       fillColor: darkCardColor,
///       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
///       border: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: darkDividerColor),
///       ),
///       enabledBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: darkDividerColor),
///       ),
///       focusedBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: primaryColor, width: 2),
///       ),
///       errorBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: errorColor),
///       ),
///       focusedErrorBorder: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(8),
///         borderSide: const BorderSide(color: errorColor, width: 2),
///       ),
///       labelStyle: GoogleFonts.poppins(
///         color: darkTextSecondaryColor,
///         fontSize: 16,
///       ),
///       hintStyle: GoogleFonts.poppins(
///         color: darkTextHintColor,
///         fontSize: 16,
///       ),
///       errorStyle: GoogleFonts.poppins(
///         color: errorColor,
///         fontSize: 12,
///       ),
///     ),
///     cardTheme: CardTheme(
///       color: darkCardColor,
///       elevation: 2,
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(12),
///       ),
///     ),
///     dialogTheme: DialogTheme(
///       backgroundColor: darkSurfaceColor,
///       elevation: 24,
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///       ),
///       titleTextStyle: GoogleFonts.poppins(
///         fontSize: 20,
///         fontWeight: FontWeight.w600,
///         color: darkTextPrimaryColor,
///       ),
///       contentTextStyle: GoogleFonts.poppins(
///         fontSize: 16,
///         color: darkTextSecondaryColor,
///       ),
///     ),
///     snackBarTheme: SnackBarThemeData(
///       backgroundColor: darkSurfaceColor,
///       contentTextStyle: GoogleFonts.poppins(
///         fontSize: 16,
///         color: darkTextPrimaryColor,
///       ),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(8),
///       ),
///       behavior: SnackBarBehavior.floating,
///     ),
///     chipTheme: ChipThemeData(
///       backgroundColor: darkCardColor,
///       disabledColor: darkDisabledColor,
///       selectedColor: primaryColorDark,
///       secondarySelectedColor: secondaryColorDark,
///       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///         side: const BorderSide(color: darkDividerColor),
///       ),
///       labelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         color: darkTextPrimaryColor,
///       ),
///       secondaryLabelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         color: Colors.white,
///       ),
///       brightness: Brightness.dark,
///     ),
///     tabBarTheme: TabBarTheme(
///       labelColor: primaryColor,
///       unselectedLabelColor: darkTextSecondaryColor,
///       indicatorSize: TabBarIndicatorSize.tab,
///       indicator: UnderlineTabIndicator(
///         borderSide: BorderSide(color: primaryColor, width: 2),
///       ),
///       labelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         fontWeight: FontWeight.w600,
///       ),
///       unselectedLabelStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         fontWeight: FontWeight.w400,
///       ),
///     ),
///     tooltipTheme: TooltipThemeData(
///       decoration: BoxDecoration(
///         color: darkSurfaceColor,
///         borderRadius: BorderRadius.circular(8),
///         boxShadow: [
///           BoxShadow(
///             color: Colors.black.withOpacity(0.3),
///             blurRadius: 4,
///             offset: const Offset(0, 2),
///           ),
///         ],
///       ),
///       textStyle: GoogleFonts.poppins(
///         fontSize: 14,
///         color: darkTextPrimaryColor,
///       ),
///     ),
///     bottomSheetTheme: BottomSheetThemeData(
///       backgroundColor: darkSurfaceColor,
///       shape: const RoundedRectangleBorder(
///         borderRadius: BorderRadius.vertical(
///           top: Radius.circular(16),
///         ),
///       ),
///     ),
///     timePickerTheme: TimePickerThemeData(
///       backgroundColor: darkSurfaceColor,
///       hourMinuteTextColor: darkTextPrimaryColor,
///       dayPeriodTextColor: darkTextSecondaryColor,
///       dialHandColor: primaryColor,
///       dialBackgroundColor: darkCardColor,
///       dialTextColor: darkTextPrimaryColor,
///       entryModeIconColor: primaryColor,
///       hourMinuteShape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(8),
///       ),
///       dayPeriodShape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(8),
///       ),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///       ),
///     ),
///     datePickerTheme: DatePickerThemeData(
///       backgroundColor: darkSurfaceColor,
///       headerBackgroundColor: primaryColor,
///       headerForegroundColor: Colors.white,
///       dayStyle: GoogleFonts.poppins(
///         color: darkTextPrimaryColor,
///       ),
///       yearStyle: GoogleFonts.poppins(
///         color: darkTextPrimaryColor,
///       ),
///       weekdayStyle: GoogleFonts.poppins(
///         color: darkTextSecondaryColor,
///       ),
///       shape: RoundedRectangleBorder(
///         borderRadius: BorderRadius.circular(16),
///       ),
///     ),
///   );
/// }
/// ``` 