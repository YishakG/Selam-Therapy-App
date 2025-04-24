import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selam_app/core/constants/app_colors.dart';
import 'package:selam_app/core/constants/routes.dart';

import 'package:selam_app/features/onboarding/pages/client_registration_form.dart';
import 'package:selam_app/features/onboarding/pages/client_registration_state.dart';

class ClientRegistrationPage extends StatefulWidget {
  const ClientRegistrationPage({super.key});

  @override
  State<ClientRegistrationPage> createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  final ClientRegistrationState _state = ClientRegistrationState();

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
      body: ClientRegistrationForm(
        state: _state,
        onLoginRedirect: () => context.go(Routes.login),
      ),
    );
  }
}
