import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants/app_colors.dart';

class SupervisorProfilePage extends StatelessWidget {
  const SupervisorProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sarah Johnson',
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.contentSupervisor,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('156', 'Reviews'),
                    _buildStatItem('98%', 'Approval Rate'),
                    _buildStatItem('24h', 'Avg. Response'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
            l10n.professionalDetails,
            [
              _buildDetailItem(Icons.work_outline, l10n.seniorTrainingManager),
              _buildDetailItem(Icons.school_outlined, 'MA in Psychology'),
              _buildDetailItem(Icons.language, 'Fluent in English, Amharic'),
            ],
          ),
          const SizedBox(height: 16),
          _buildMenuSection(context, l10n),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, AppLocalizations l10n) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.person_outline,
            title: l10n.personalInfo,
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: l10n.settings,
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: l10n.helpAndSupport,
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: l10n.logout,
            onTap: () {},
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppColors.primary,
      ),
      title: Text(
        title,
        style: GoogleFonts.manrope(
          color: isDestructive ? Colors.red : AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 20,
      ),
      onTap: onTap,
    );
  }
} 