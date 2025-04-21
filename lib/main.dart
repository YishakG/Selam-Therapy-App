import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_colors.dart';
import 'core/providers/app_providers.dart';
import 'core/providers/locale_provider.dart';
import 'core/config/app_config.dart';

/// The entry point of the application.
/// Sets up essential services and launches the Flutter app.
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// The root widget of the application.
/// Sets up routing, localization, theming, and reactive state.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observe the current locale from the state provider.
    final currentLocale = ref.watch(localeProvider);

    // Observe the navigation router configuration.
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Selam Therapy',
      debugShowCheckedModeBanner: false,
      locale: currentLocale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.manropeTextTheme(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.manropeTextTheme(),
        useMaterial3: true,
      ),
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('am'),
      ],
    );
  }
}
