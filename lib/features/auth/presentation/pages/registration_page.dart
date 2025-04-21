import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:selam_app/core/constants/routes.dart';
import 'package:selam_app/core/widgets/primary_button.dart';
import 'package:selam_app/core/widgets/secondary_button.dart';
import 'package:selam_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:selam_app/features/auth/presentation/widgets/role_selector.dart';
import 'package:selam_app/features/auth/presentation/widgets/auth_date_picker_field.dart';
import 'package:selam_app/features/auth/presentation/widgets/auth_dropdown_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _portfolioController = TextEditingController();
  final _otherConcernsController = TextEditingController();

  UserRole _selectedRole = UserRole.client;
  DateTime? _dateOfBirth;
  String? _selectedGender;
  String? _selectedLanguage;
  List<String> _selectedConcerns = [];
  bool _hasHadTherapy = false;
  String? _selectedTherapyType;
  String? _selectedTherapyDuration;
  String? _selectedTherapistBackground;
  String? _selectedTherapistGender;
  List<String> _selectedExpertise = [];
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _portfolioController.dispose();
    _otherConcernsController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseAcceptTerms)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Implement registration logic
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.registrationFailed)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildClientFields() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        AuthDatePickerField(
          selectedDate: _dateOfBirth,
          onDateSelected: (date) => setState(() => _dateOfBirth = date),
          label: l10n.dateOfBirth,
          validator: (date) => date == null ? l10n.pleaseSelectDateOfBirth : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: _selectedGender,
          items: [
            DropdownMenuItem(value: 'male', child: Text(l10n.male)),
            DropdownMenuItem(value: 'female', child: Text(l10n.female)),
            DropdownMenuItem(value: 'other', child: Text(l10n.other)),
          ],
          onChanged: (value) => setState(() => _selectedGender = value),
          label: l10n.gender,
          validator: (value) => value == null ? l10n.pleaseSelectGender : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: _selectedLanguage,
          items: [
            DropdownMenuItem(value: 'en', child: Text(l10n.english)),
            DropdownMenuItem(value: 'am', child: Text(l10n.amharic)),
          ],
          onChanged: (value) => setState(() => _selectedLanguage = value),
          label: l10n.preferredLanguage,
          validator: (value) => value == null ? l10n.pleaseSelectLanguage : null,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.currentConcerns,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildConcernChip(l10n.anxiety, 'anxiety'),
            _buildConcernChip(l10n.depression, 'depression'),
            _buildConcernChip(l10n.stressManagement, 'stress'),
            _buildConcernChip(l10n.trauma, 'trauma'),
            _buildConcernChip(l10n.relationshipIssues, 'relationship'),
            _buildConcernChip(l10n.parentingSupport, 'parenting'),
            _buildConcernChip(l10n.addictionRecovery, 'addiction'),
            _buildConcernChip(l10n.careerStress, 'career'),
            _buildConcernChip(l10n.other, 'other'),
          ],
        ),
        if (_selectedConcerns.contains('other')) ...[
          const SizedBox(height: 8),
          AuthTextField(
            controller: _otherConcernsController,
            label: l10n.otherConcerns,
          ),
        ],
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text(l10n.hadTherapyBefore),
          value: _hasHadTherapy,
          onChanged: (value) => setState(() => _hasHadTherapy = value ?? false),
        ),
        if (_hasHadTherapy) ...[
          const SizedBox(height: 16),
          AuthDropdownField<String>(
            value: _selectedTherapyType,
            items: [
              DropdownMenuItem(value: 'talk', child: Text(l10n.talkTherapy)),
              DropdownMenuItem(value: 'group', child: Text(l10n.groupTherapy)),
              DropdownMenuItem(value: 'couples', child: Text(l10n.couplesTherapy)),
              DropdownMenuItem(value: 'family', child: Text(l10n.familyTherapy)),
            ],
            onChanged: (value) => setState(() => _selectedTherapyType = value),
            label: l10n.therapyType,
            validator: (value) => value == null ? l10n.pleaseSelectTherapyType : null,
          ),
        ],
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: _selectedTherapyDuration,
          items: [
            DropdownMenuItem(value: 'short', child: Text(l10n.shortTerm)),
            DropdownMenuItem(value: 'long', child: Text(l10n.longTerm)),
          ],
          onChanged: (value) => setState(() => _selectedTherapyDuration = value),
          label: l10n.therapyDuration,
          validator: (value) => value == null ? l10n.pleaseSelectTherapyDuration : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: _selectedTherapistBackground,
          items: [
            DropdownMenuItem(value: 'psychologist', child: Text(l10n.clinicalPsychologist)),
            DropdownMenuItem(value: 'counselor', child: Text(l10n.counselor)),
            DropdownMenuItem(value: 'social_worker', child: Text(l10n.socialWorker)),
            DropdownMenuItem(value: 'psychiatrist', child: Text(l10n.psychiatrist)),
          ],
          onChanged: (value) => setState(() => _selectedTherapistBackground = value),
          label: l10n.therapistBackground,
          validator: (value) => value == null ? l10n.pleaseSelectTherapistBackground : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: _selectedTherapistGender,
          items: [
            DropdownMenuItem(value: 'male', child: Text(l10n.male)),
            DropdownMenuItem(value: 'female', child: Text(l10n.female)),
            DropdownMenuItem(value: 'no_preference', child: Text(l10n.noPreference)),
          ],
          onChanged: (value) => setState(() => _selectedTherapistGender = value),
          label: l10n.therapistGender,
          validator: (value) => value == null ? l10n.pleaseSelectTherapistGender : null,
        ),
      ],
    );
  }

  Widget _buildContentCreatorFields() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        AuthTextField(
          controller: _bioController,
          label: l10n.bio,
          maxLines: 3,
          validator: (value) => value?.isEmpty ?? true ? l10n.pleaseEnterBio : null,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.areasOfExpertise,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildExpertiseChip(l10n.psychology, 'psychology'),
            _buildExpertiseChip(l10n.mentalHealthWriting, 'writing'),
            _buildExpertiseChip(l10n.videoProduction, 'video'),
            _buildExpertiseChip(l10n.animation, 'animation'),
            _buildExpertiseChip(l10n.research, 'research'),
            _buildExpertiseChip(l10n.other, 'other'),
          ],
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: _portfolioController,
          label: l10n.portfolioLink,
          validator: (value) => value?.isEmpty ?? true ? l10n.pleaseEnterPortfolioLink : null,
        ),
      ],
    );
  }

  Widget _buildConcernChip(String label, String value) {
    return FilterChip(
      label: Text(label),
      selected: _selectedConcerns.contains(value),
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedConcerns.add(value);
          } else {
            _selectedConcerns.remove(value);
          }
        });
      },
    );
  }

  Widget _buildExpertiseChip(String label, String value) {
    return FilterChip(
      label: Text(label),
      selected: _selectedExpertise.contains(value),
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedExpertise.add(value);
          } else {
            _selectedExpertise.remove(value);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createAccount),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RoleSelector(
                selectedRole: _selectedRole,
                onRoleSelected: (role) {
                  setState(() => _selectedRole = role);
                },
                availableRoles: [UserRole.client, UserRole.contentCreator],
              ),
              const SizedBox(height: 24),
              AuthTextField(
                controller: _firstNameController,
                label: l10n.firstName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterFirstName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _lastNameController,
                label: l10n.lastName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterLastName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _emailController,
                label: l10n.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterEmail;
                  }
                  if (!value.contains('@')) {
                    return l10n.pleaseEnterValidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _phoneController,
                label: l10n.phoneNumber,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterPhoneNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _passwordController,
                label: l10n.password,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseEnterPassword;
                  }
                  if (value.length < 6) {
                    return l10n.passwordMustBeAtLeast6Characters;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                controller: _confirmPasswordController,
                label: l10n.confirmPassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.pleaseConfirmPassword;
                  }
                  if (value != _passwordController.text) {
                    return l10n.passwordsDoNotMatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (_selectedRole == UserRole.client) _buildClientFields(),
              if (_selectedRole == UserRole.contentCreator) _buildContentCreatorFields(),
              const SizedBox(height: 24),
              CheckboxListTile(
                value: _agreeToTerms,
                onChanged: (value) {
                  setState(() => _agreeToTerms = value ?? false);
                },
                title: Text(_selectedRole == UserRole.client
                    ? l10n.agreeToTerms
                    : l10n.agreeToContentGuidelines),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: l10n.createAccount,
                onPressed: _handleRegistration,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.alreadyHaveAnAccount),
                  TextButton(
                    onPressed: () {
                      context.go(Routes.login);
                    },
                    child: Text(l10n.login),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
