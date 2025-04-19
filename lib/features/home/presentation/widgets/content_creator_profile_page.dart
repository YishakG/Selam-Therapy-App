import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentCreatorProfilePage extends ConsumerWidget {
  const ContentCreatorProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          onPressed: () {
                            // TODO: Implement photo change
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: GoogleFonts.manrope(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.contentCreator,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement edit profile
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(l10n.editProfile),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Professional Details Card
            _buildSectionCard(
              title: l10n.professionalDetails,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem(
                    icon: Icons.school_outlined,
                    title: 'Mental Health Content Specialist',
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem(
                    icon: Icons.workspace_premium_outlined,
                    title: 'Certified Wellness Coach',
                  ),
                  const SizedBox(height: 12),
                  _buildDetailItem(
                    icon: Icons.psychology_outlined,
                    title: 'Mindfulness & Meditation Expert',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Content Stats Card
            _buildSectionCard(
              title: l10n.contentPerformance,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    value: '156',
                    label: 'Posts',
                    icon: Icons.article_outlined,
                  ),
                  _buildStatItem(
                    value: '45.2K',
                    label: 'Views',
                    icon: Icons.visibility_outlined,
                  ),
                  _buildStatItem(
                    value: '12.8K',
                    label: 'Likes',
                    icon: Icons.favorite_outline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Settings Card
            _buildSectionCard(
              title: l10n.settings,
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.language,
                    title: l10n.language,
                    onTap: () {
                      // TODO: Implement language settings
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: () {
                      // TODO: Implement notifications settings
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.help_outline,
                    title: l10n.helpAndSupport,
                    onTap: () {
                      // TODO: Implement help and support
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.logout,
                    title: l10n.logout,
                    onTap: () {
                      // TODO: Implement logout
                    },
                    isDestructive: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.grey[600],
        size: 22,
      ),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 15,
          color: isDestructive ? Colors.red : AppColors.textPrimary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDestructive ? Colors.red : Colors.grey[400],
        size: 20,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
    );
  }
} 