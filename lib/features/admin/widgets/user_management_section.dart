import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/routes.dart';

// Assuming Routes is defined somewhere in your project
class Routes {
  static const String registration = '/registration';
}

class UserManagementSection extends StatelessWidget {
  const UserManagementSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.userManagement,
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildActionCard(
              context,
              title: l10n.addUser,
              icon: Icons.person_add_outlined,
              color: AppColors.primary,
              onTap: () {
                context.go(Routes.registration);
              },
            ),
            _buildActionCard(
              context,
              title: l10n.suspendUser,
              icon: Icons.person_off_outlined,
              color: Colors.orange,
              onTap: () {
                // TODO: Implement suspend user action
              },
            ),
            _buildActionCard(
              context,
              title: l10n.removeUser,
              icon: Icons.person_remove_outlined,
              color: Colors.red,
              onTap: () {
                // TODO: Implement remove user action
              },
            ),
            _buildActionCard(
              context,
              title: l10n.assignRole,
              icon: Icons.assignment_ind_outlined,
              color: Colors.purple,
              onTap: () {
                // TODO: Implement assign role action
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap, // Add onTap parameter
  }) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap, // Use the provided onTap callback
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
