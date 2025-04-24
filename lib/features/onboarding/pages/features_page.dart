import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selam_app/core/widgets/secondary_button.dart';
import 'package:selam_app/features/onboarding/widgets/auth_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/routes.dart';

class FeaturesPage extends ConsumerWidget {
  const FeaturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final features = _getFeatures(l10n);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              child: Text(
                l10n.features,
                style: GoogleFonts.manrope(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Features list
            Expanded(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                itemCount: features.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return _buildFeatureItem(
                    icon: feature.icon,
                    title: feature.title,
                    description: feature.description,
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceBackground,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Primary action button
                  SizedBox(
                    width: double.infinity,
                    child: AuthButton(
                      prompt: '',
                      buttonText: l10n.createAccount,
                      route: Routes.client_registration,
                      isPrimary: true,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Secondary action with better visual separation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.alreadyHaveAccount,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: AppColors
                              .textSecondary, // Consider a less prominent color
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => context.go(Routes.login),
                        child: Text(
                          l10n.login, // Assuming you have a "Sign in" translation
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  List<_FeatureItemData> _getFeatures(AppLocalizations l10n) {
    return [
      _FeatureItemData(
        icon: Icons.health_and_safety,
        title: l10n.onlineTherapy,
        description: l10n.onlineTherapyDesc,
      ),
      _FeatureItemData(
        icon: Icons.psychology,
        title: l10n.expertTherapists,
        description: l10n.expertTherapistsDesc,
      ),
      _FeatureItemData(
        icon: Icons.lock,
        title: l10n.dataPrivacy,
        description: l10n.dataPrivacyDesc,
      ),
      _FeatureItemData(
        icon: Icons.favorite,
        title: l10n.personalizedCare,
        description: l10n.personalizedCareDesc,
      ),
      _FeatureItemData(
        icon: Icons.access_time,
        title: l10n.support247,
        description: l10n.support247Desc,
      ),
    ];
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
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

class _FeatureItemData {
  final IconData icon;
  final String title;
  final String description;

  _FeatureItemData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
