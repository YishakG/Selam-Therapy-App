import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/app_colors.dart';
import 'core/providers/app_route_state_providers.dart';
import 'core/providers/locale_provider.dart';
import 'core/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// The entry point of the application.
/// Sets up essential services and launches the Flutter app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Supabase.initialize(
      url: 'https://jvwxkfgfkkkwyznfznol.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2d3hrZmdma2trd3l6bmZ6bm9sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyMzIyNTcsImV4cCI6MjA2MDgwODI1N30.crAjtndG5yfza51SO3fy815W6pVrR7jkt599mPCJMJE',
    );

    runApp(const ProviderScope(child: MyApp()));
  } catch (e, stackTrace) {
    // Log the error or send to Crashlytics
    debugPrint('Error initializing Firebase or Supabase: $e');
    debugPrint('$stackTrace');
  }
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
