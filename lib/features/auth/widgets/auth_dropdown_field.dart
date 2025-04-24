import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selam_app/core/constants/app_colors.dart';

class AuthDropdownField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String label;
  final String? Function(T?)? validator;

  const AuthDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.manrope(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: AppColors.inputFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      dropdownColor: AppColors.dropdownBackground,
      iconEnabledColor: AppColors.textPrimary,
      style: GoogleFonts.manrope(
        color: AppColors.textPrimary,
        fontSize: 14,
      ),
      selectedItemBuilder: (context) => items
          .map((item) => Align(
                alignment: Alignment.centerLeft,
                child: DefaultTextStyle(
                  style: GoogleFonts.manrope(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  child: item.child,
                ),
              ))
          .toList(),
    );
  }
}
