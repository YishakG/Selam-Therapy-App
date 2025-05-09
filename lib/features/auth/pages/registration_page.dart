import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selam_app/core/constants/app_colors.dart';
import 'package:selam_app/core/constants/routes.dart';
import 'package:selam_app/features/auth/pages/registration_state.dart';
import 'package:selam_app/features/auth/pages/registration_form.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final RegistrationState _state = RegistrationState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBackground,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          l10n.createAccount,
          style: GoogleFonts.manrope(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: RegistrationForm(
        state: _state,
        onLoginRedirect: () => context.go(Routes.adminDashboard),
      ),
    );
  }
}
