/// Main entry point of the application.
/// This file sets up the app with proper localization, theme, and routing.
/// 
/// Example usage:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_localizations/flutter_localizations.dart';
/// import 'package:flutter_riverpod/flutter_riverpod.dart';
/// import 'package:selam_app/core/providers/app_providers.dart';
/// import 'package:selam_app/features/splash/presentation/splash_screen.dart';
/// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
/// 
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   
///   // Initialize services
///   await initializeServices();
///   
///   runApp(
///     const ProviderScope(
///       child: MyApp(),
///     ),
///   );
/// }
/// 
/// Future<void> initializeServices() async {
///   // Initialize Hive
///   await Hive.initFlutter();
///   
///   // Initialize other services
/// }
/// 
/// class MyApp extends ConsumerWidget {
///   const MyApp({Key? key}) : super(key: key);
/// 
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     return MaterialApp(
///       title: 'Selam App',
///       debugShowCheckedModeBanner: false,
///       theme: ThemeData(
///         primarySwatch: Colors.blue,
///         visualDensity: VisualDensity.adaptivePlatformDensity,
///       ),
///       localizationsDelegates: const [
///         AppLocalizations.delegate,
///         GlobalMaterialLocalizations.delegate,
///         GlobalWidgetsLocalizations.delegate,
///         GlobalCupertinoLocalizations.delegate,
///       ],
///       supportedLocales: const [
///         Locale('en'), // English
///         Locale('am'), // Amharic
///       ],
///       home: const SplashScreen(),
///     );
///   }
/// }
/// ``` 

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      locale: currentLocale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppConfig.supportedLocales,
      routerConfig: router,
    );
  }
} 