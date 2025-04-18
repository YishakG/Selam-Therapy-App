import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/routes.dart';

/// Features Page showcasing key benefits and capabilities.
class FeaturesPage extends ConsumerWidget {
  const FeaturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        l10n.features,
                        style: GoogleFonts.manrope(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildFeatureItem(
                      icon: Icons.health_and_safety,
                      title: l10n.onlineTherapy,
                      description: l10n.onlineTherapyDesc,
                    ),
                    _buildFeatureItem(
                      icon: Icons.psychology,
                      title: l10n.expertTherapists,
                      description: l10n.expertTherapistsDesc,
                    ),
                    _buildFeatureItem(
                      icon: Icons.lock,
                      title: l10n.dataPrivacy,
                      description: l10n.dataPrivacyDesc,
                    ),
                    _buildFeatureItem(
                      icon: Icons.favorite,
                      title: l10n.personalizedCare,
                      description: l10n.personalizedCareDesc,
                    ),
                    _buildFeatureItem(
                      icon: Icons.access_time,
                      title: l10n.support247,
                      description: l10n.support247Desc,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthButton(
                    prompt: l10n.newUser,
                    buttonText: l10n.createAccount,
                    route: Routes.signup,
                    isPrimary: true,
                  ),
                  const SizedBox(height: 16),
                  AuthButton(
                    prompt: l10n.existingUser,
                    buttonText: l10n.login,
                    route: Routes.login,
                    isPrimary: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a reusable feature item widget.
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2), // Enhanced visibility
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 26, // Slightly larger icon
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A reusable button for authentication actions.
class AuthButton extends ConsumerWidget {
  final String prompt;
  final String buttonText;
  final String route;
  final bool isPrimary;

  const AuthButton({
    Key? key,
    required this.prompt,
    required this.buttonText,
    required this.route,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          prompt,
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: isPrimary
              ? ElevatedButton(
                  onPressed: () => context.go(route),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : OutlinedButton(
                  onPressed: () => context.go(route),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
