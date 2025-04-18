import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable widget that displays the app logo.
/// The logo can be sized, colored, and customized with animations or shadows.
class AppLogo extends StatelessWidget {
  /// The size of the logo container. Both width and height will be set to this value.
  final double size;

  /// Optional background color for the logo container.
  /// If not provided, the container will be transparent.
  final Color? backgroundColor;

  /// Optional padding around the logo.
  final EdgeInsets? padding;

  /// Optional border color for the logo container.
  final Color? borderColor;

  /// Optional shadow for the logo container.
  final BoxShadow? shadow;

  /// Optional color filter to apply to the SVG logo.
  final Color? logoColor;

  /// Optional animation duration for logo's appearance.
  final Duration? animationDuration;

  const AppLogo({
    Key? key,
    this.size = 80,
    this.backgroundColor,
    this.padding,
    this.borderColor,
    this.shadow,
    this.logoColor,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration!,
      curve: Curves.easeInOut,
      width: size,
      height: size,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        shape: BoxShape.circle,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 2)
            : null,
        boxShadow: shadow != null ? [shadow!] : [],
      ),
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        fit: BoxFit.contain,
        color: logoColor,
        semanticsLabel: 'App Logo',
        placeholderBuilder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
