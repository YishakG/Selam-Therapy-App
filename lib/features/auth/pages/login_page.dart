import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selam_app/core/constants/app_colors.dart';
import 'package:selam_app/core/constants/routes.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:selam_app/core/providers/global_providers.dart';
import 'package:selam_app/core/providers/user_role_provider.dart';
import 'package:selam_app/core/services/auth_service.dart';
import 'package:selam_app/core/widgets/app_logo.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmailOrPhone(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^\+?[\d\s-]{9,}$');
    return emailRegex.hasMatch(value) || phoneRegex.hasMatch(value);
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      print('Form validation failed');
      return;
    }

    setState(() => _isLoading = true);

    final authService = AuthService();
    // AuthService expects email; phone input is validated but not used
    final email = _emailOrPhoneController.text.trim();
    final result = await authService.signIn(
      email: email,
      password: _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    print('AuthService.signIn result: $result');

    if (result['success']) {
      print(
          'Login successful, role: ${result['role']}, type: ${result['role'].runtimeType}');
      ref.read(authStateProvider.notifier).state = true;
      ref.read(userRoleProvider.notifier).state = result['role'];
      ref.read(userDataProvider.notifier).state = result['userData'];
      ref.read(currentUserProvider.notifier).state = result['uid'];
      _emailOrPhoneController.clear();
      _passwordController.clear();
      switch (result['role']) {
        case UserRole.admin:
          context.go(Routes.adminDashboard);
          break;
        case UserRole.therapist:
          context.go(Routes.therapistDashboard);
          break;
        case UserRole.client:
          context.go(Routes.clientDashboard);
          break;
        case UserRole.contentCreator:
          context.go(Routes.contentCreatorDashboard);
          break;
        case UserRole.contentSupervisor:
          context.go(Routes.contentSupervisorDashboard);
          break;
        case UserRole.courseTrainer:
          context.go(Routes.courseTrainerDashboard);
          break;
        default:
          print('Unknown role: ${result['role']}');
          context.go(Routes.home); // Fallback route
      }
    } else {
      final l10n = AppLocalizations.of(context)!;
      String message;
      switch (result['errorCode']) {
        case 'invalid-email':
          message = l10n.invalidEmail;
          break;
        case 'user-not-found':
        case 'wrong-password':
          message = l10n.invalidCredentials;
          break;
        case 'no-user':
          message = l10n.userNotFound;
          break;
        case 'fetch-error':
          message = l10n.failedToFetchUserData;
          break;
        default:
          message = '${l10n.loginFailed}: ${result['errorMessage']}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        const AppLogo(size: 100),
                        const SizedBox(height: 40),
                        Text(
                          l10n.welcomeBack,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.loginToContinue,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _emailOrPhoneController,
                          decoration: InputDecoration(
                            labelText: l10n.emailOrPhone,
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.emailOrPhoneRequired;
                            }
                            if (!_isValidEmailOrPhone(value)) {
                              return l10n.invalidEmailOrPhone;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: l10n.password,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.passwordRequired;
                            }
                            if (value.length < 6) {
                              return l10n.passwordTooShort;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                          ),
                          child: Text(
                            l10n.login,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.dontHaveAccount,
                              style: GoogleFonts.poppins(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go(Routes.registration);
                              },
                              child: Text(
                                l10n.createAccount,
                                style: GoogleFonts.poppins(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
