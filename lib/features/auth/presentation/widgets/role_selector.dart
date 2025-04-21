import 'package:flutter/material.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:selam_app/core/constants/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select your role',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableRoles.map((role) {
            final isSelected = role == selectedRole;
            return FilterChip(
              label: Text(
                role == UserRole.client ? 'Client' : 'Content Creator',
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onRoleSelected(role);
                }
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.border,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
} 