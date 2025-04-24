import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selam_app/core/widgets/app_logo.dart';
import 'package:selam_app/core/widgets/primary_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/routes.dart';
import '../../../core/providers/locale_provider.dart';

/// Landing page with language selection and Get Started button.
class GetStartedPage extends ConsumerWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              right: 16,
              child: LanguageSelector(
                currentLocale: currentLocale,
                onLanguageChanged: (String? languageCode) {
                  if (languageCode != null) {
                    ref.read(localeProvider.notifier).setLocale(Locale(languageCode));
                  }
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppLogo(size: 120),
                    const SizedBox(height: 48),
                    Text(
                      l10n.appName,
                      style: GoogleFonts.manrope(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.tagline,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      text: l10n.getStarted,
                      onPressed: () => context.go(Routes.features),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
class LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final void Function(String?) onLanguageChanged;

  const LanguageSelector({
    Key? key,
    required this.currentLocale,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBackground, // Clean, neutral background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLocale.languageCode,
          icon: const Icon(Icons.language, color: AppColors.primary),
          dropdownColor: AppColors.surfaceBackground, // Dropdown menu background
          style: GoogleFonts.manrope(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          items: [
            DropdownMenuItem(
              value: 'en',
              child: Text(
                l10n.english,
              ),
            ),
            DropdownMenuItem(
              value: 'am',
              child: Text(
                l10n.amharic,
              ),
            ),
          ],
          onChanged: onLanguageChanged,
        ),
      ),
    );
  }
}
 // Import your AppColors class

