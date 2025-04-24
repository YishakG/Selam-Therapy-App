import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selam_app/core/constants/app_colors.dart';

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
            color: AppColors.textSecondary, // For subtitle or prompt text
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
                    backgroundColor:
                        AppColors.primary, // Primary color for the background
                    foregroundColor: AppColors.surfaceBackground, // White text
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
                    side: BorderSide(
                        color:
                            AppColors.primary), // Primary color for the border
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary, // Primary color for the text
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
