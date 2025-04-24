import 'package:flutter/material.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:selam_app/core/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class RoleSelector extends StatelessWidget {
  final UserRole selectedRole;
  final Function(UserRole) onRoleSelected;
  final List<UserRole> availableRoles;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
    this.availableRoles = const [UserRole.client, UserRole.contentCreator],
  });

  String _getRoleLabel(UserRole role, AppLocalizations l10n) {
    switch (role) {
      case UserRole.client:
        return l10n.client;
      case UserRole.contentCreator:
        return l10n.contentCreator;
      case UserRole.contentSupervisor:
        return l10n.contentSupervisor;
      case UserRole.courseTrainer:
        return l10n.courseTrainer;
      case UserRole.therapist:
        return l10n.therapist;
      case UserRole.admin:
        return l10n.admin;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.selectYourRole,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: availableRoles.map((role) {
            final isSelected = role == selectedRole;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.surfaceBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => onRoleSelected(role),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    _getRoleLabel(role, l10n),
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.primaryBackground
                          : AppColors.textPrimary.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
