import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selam_app/core/constants/app_colors.dart';


/// A reusable logo widget with customizable size and improved styling.
///
/// This widget displays the app logo inside a circular container, with a border,
/// shadow, and background color, ensuring it fits well into any UI.
class AppLogo extends StatelessWidget {
  final double size; // Size of the logo container

  const AppLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceBackground, // Using a solid background color
        border: Border.all(
          color: AppColors.border, // Subtle border color for the logo
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow, // Shadow for depth
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg', // Path to your SVG logo
          width: size * 0.7, // Logo size will be 70% of the container size
          height: size * 0.7,
        ),
      ),
    );
  }
}
