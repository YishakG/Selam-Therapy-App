import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      backgroundColor: Colors.white,
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
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.tagline,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: Colors.black54,
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

/// Reusable language selector.
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLocale.languageCode,
          icon: const Icon(Icons.language, color: AppColors.primary),
          items: [
            DropdownMenuItem(
              value: 'en',
              child: Text(
                l10n.english,
                style: GoogleFonts.manrope(color: AppColors.textPrimary),
              ),
            ),
            DropdownMenuItem(
              value: 'am',
              child: Text(
                l10n.amharic,
                style: GoogleFonts.manrope(color: AppColors.textPrimary),
              ),
            ),
          ],
          onChanged: onLanguageChanged,
        ),
      ),
    );
  }
}

/// Clean logo with white background, border and shadow.
class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          width: size * 0.5,
          height: size * 0.5,
        ),
      ),
    );
  }
}

/// Consistent primary button widget.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
