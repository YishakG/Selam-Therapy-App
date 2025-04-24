import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selam_app/core/constants/app_colors.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:selam_app/features/auth/pages/registration_state.dart';
import 'package:selam_app/features/auth/widgets/auth_text_field.dart';
import 'package:selam_app/features/auth/widgets/role_selector.dart';
import 'package:selam_app/features/auth/widgets/auth_date_picker_field.dart';
import 'package:selam_app/features/auth/widgets/auth_dropdown_field.dart';
import 'package:selam_app/core/widgets/primary_button.dart';

class RegistrationForm extends StatefulWidget {
  final RegistrationState state;
  final VoidCallback onLoginRedirect;

  const RegistrationForm({
    super.key,
    required this.state,
    required this.onLoginRedirect,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.state.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AbsorbPointer(
      absorbing: widget.state.isLoading,
      child: widget.state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: widget.state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoleSelector(
                      selectedRole: widget.state.selectedRole,
                      onRoleSelected: (role) =>
                          widget.state.selectedRole = role,
                      availableRoles: [
                        UserRole.client,
                        UserRole.contentCreator,
                        UserRole.contentSupervisor,
                        UserRole.courseTrainer,
                        UserRole.therapist,
                        UserRole.admin,
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      widget.state.firstNameController,
                      l10n.firstName,
                      l10n.pleaseEnterFirstName,
                    ),
                    _buildTextField(
                      widget.state.lastNameController,
                      l10n.lastName,
                      l10n.pleaseEnterLastName,
                    ),
                    _buildTextField(
                      widget.state.emailController,
                      l10n.email,
                      l10n.pleaseEnterEmail,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return l10n.pleaseEnterEmail;
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegex.hasMatch(value))
                          return l10n.pleaseEnterValidEmail;
                        return null;
                      },
                    ),
                    _buildTextField(
                      widget.state.phoneController,
                      l10n.phoneNumber,
                      l10n.pleaseEnterPhoneNumber,
                      type: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9+\-\s]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return l10n.pleaseEnterPhoneNumber;
                        final phoneRegex = RegExp(
                            r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
                        if (!phoneRegex.hasMatch(value))
                          return l10n.pleaseEnterValidPhoneNumber;
                        return null;
                      },
                    ),
                    _buildTextField(
                      widget.state.passwordController,
                      l10n.password,
                      l10n.pleaseEnterPassword,
                      obscure: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return l10n.pleaseEnterPassword;
                        if (value.length < 8)
                          return l10n.passwordMustBeAtLeast8Characters;
                        if (!RegExp(
                                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])')
                            .hasMatch(value)) return l10n.passwordRequirements;
                        return null;
                      },
                    ),
                    _buildTextField(
                      widget.state.confirmPasswordController,
                      l10n.confirmPassword,
                      l10n.pleaseConfirmPassword,
                      obscure: true,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return l10n.pleaseConfirmPassword;
                        if (value != widget.state.passwordController.text)
                          return l10n.passwordsDoNotMatch;
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    if (widget.state.selectedRole == UserRole.client)
                      _ClientFields(state: widget.state),
                    if (widget.state.selectedRole == UserRole.contentCreator ||
                        widget.state.selectedRole == UserRole.contentSupervisor)
                      _ContentCreatorFields(state: widget.state),
                    if (widget.state.selectedRole == UserRole.courseTrainer)
                      _CourseTrainerFields(state: widget.state),
                    if (widget.state.selectedRole == UserRole.therapist)
                      _TherapistFields(state: widget.state),
                    if (widget.state.selectedRole == UserRole.admin)
                      _AdminFields(state: widget.state),
                    const SizedBox(height: 24),
                    CheckboxListTile(
                      value: widget.state.agreeToTerms,
                      onChanged: (value) =>
                          widget.state.agreeToTerms = value ?? false,
                      title: Text(
                        widget.state.selectedRole == UserRole.client
                            ? l10n.agreeToTerms
                            : widget.state.selectedRole == UserRole.therapist
                                ? l10n.agreeToTherapistTerms
                                : l10n.agreeToContentGuidelines,
                        style:
                            GoogleFonts.manrope(color: AppColors.textPrimary),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primary,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: l10n.createAccount,
                      onPressed: () async {
                        final success =
                            await widget.state.handleRegistration(context);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.registrationSuccessRedirect),
                              backgroundColor: AppColors.success,
                              duration: const Duration(seconds: 4),
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          widget.onLoginRedirect();
                        }
                      },
                      isLoading: widget.state.isLoading,
                    ),
                    const SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       l10n.alreadyHaveAnAccount,
                    //       style:
                    //           GoogleFonts.manrope(color: AppColors.textPrimary),
                    //     ),
                    //     TextButton(
                    //       onPressed: widget.onLoginRedirect,
                    //       child: Text(
                    //         l10n.login,
                    //         style:
                    //             GoogleFonts.manrope(color: AppColors.primary),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String emptyMessage, {
    TextInputType type = TextInputType.text,
    bool obscure = false,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      children: [
        AuthTextField(
          controller: controller,
          label: label,
          keyboardType: type,
          obscureText: obscure,
          validator: validator ??
              (value) => (value == null || value.isEmpty) ? emptyMessage : null,
          inputFormatters: inputFormatters,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ClientFields extends StatelessWidget {
  final RegistrationState state;

  const _ClientFields({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _ProfilePicturePicker(state: state),
        AuthDatePickerField(
          selectedDate: state.dateOfBirth,
          onDateSelected: (date) => state.dateOfBirth = date,
          label: l10n.dateOfBirth,
          validator: (date) =>
              date == null ? l10n.pleaseSelectDateOfBirth : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: state.selectedGender,
          items: [
            DropdownMenuItem(value: 'male', child: Text(l10n.male)),
            DropdownMenuItem(value: 'female', child: Text(l10n.female)),
            DropdownMenuItem(value: 'other', child: Text(l10n.other)),
          ],
          onChanged: (value) => state.selectedGender = value,
          label: l10n.gender,
          validator: (value) => value == null ? l10n.pleaseSelectGender : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: state.selectedLanguage,
          items: [
            DropdownMenuItem(value: 'en', child: Text(l10n.english)),
            DropdownMenuItem(value: 'am', child: Text(l10n.amharic)),
          ],
          onChanged: (value) => state.selectedLanguage = value,
          label: l10n.preferredLanguage,
          validator: (value) =>
              value == null ? l10n.pleaseSelectLanguage : null,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.currentConcerns,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
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
        if (state.selectedConcerns.contains('other')) ...[
          const SizedBox(height: 8),
          AuthTextField(
            controller: state.otherConcernsController,
            label: l10n.otherConcerns,
          ),
        ],
        const SizedBox(height: 16),
        SwitchListTile(
          title: Text(
            l10n.hadTherapyBefore,
            style: GoogleFonts.manrope(color: AppColors.textPrimary),
          ),
          value: state.hasHadTherapy,
          onChanged: (value) => state.hasHadTherapy = value,
          activeColor: AppColors.primary,
          inactiveThumbColor: AppColors.border,
          inactiveTrackColor: AppColors.lightGrey,
        ),
        if (state.hasHadTherapy) ...[
          const SizedBox(height: 16),
          AuthDropdownField<String>(
            value: state.selectedTherapyType,
            items: [
              DropdownMenuItem(value: 'talk', child: Text(l10n.talkTherapy)),
              DropdownMenuItem(value: 'group', child: Text(l10n.groupTherapy)),
              DropdownMenuItem(
                  value: 'couples', child: Text(l10n.couplesTherapy)),
              DropdownMenuItem(
                  value: 'family', child: Text(l10n.familyTherapy)),
            ],
            onChanged: (value) => state.selectedTherapyType = value,
            label: l10n.therapyType,
            validator: (value) =>
                value == null ? l10n.pleaseSelectTherapyType : null,
          ),
        ],
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: state.selectedTherapyDuration,
          items: [
            DropdownMenuItem(value: 'short', child: Text(l10n.shortTerm)),
            DropdownMenuItem(value: 'long', child: Text(l10n.longTerm)),
          ],
          onChanged: (value) => state.selectedTherapyDuration = value,
          label: l10n.therapyDuration,
          validator: (value) =>
              value == null ? l10n.pleaseSelectTherapyDuration : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: state.selectedTherapistBackground,
          items: [
            DropdownMenuItem(
                value: 'psychologist', child: Text(l10n.clinicalPsychologist)),
            DropdownMenuItem(value: 'counselor', child: Text(l10n.counselor)),
            DropdownMenuItem(
                value: 'social_worker', child: Text(l10n.socialWorker)),
            DropdownMenuItem(
                value: 'psychiatrist', child: Text(l10n.psychiatrist)),
          ],
          onChanged: (value) => state.selectedTherapistBackground = value,
          label: l10n.therapistBackground,
          validator: (value) =>
              value == null ? l10n.pleaseSelectTherapistBackground : null,
        ),
        const SizedBox(height: 16),
        AuthDropdownField<String>(
          value: state.selectedTherapistGender,
          items: [
            DropdownMenuItem(value: 'male', child: Text(l10n.male)),
            DropdownMenuItem(value: 'female', child: Text(l10n.female)),
            DropdownMenuItem(
                value: 'no_preference', child: Text(l10n.noPreference)),
          ],
          onChanged: (value) => state.selectedTherapistGender = value,
          label: l10n.therapistGender,
          validator: (value) =>
              value == null ? l10n.pleaseSelectTherapistGender : null,
        ),
      ],
    );
  }

  Widget _buildConcernChip(String label, String value) {
    final isSelected = state.selectedConcerns.contains(value);

    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.manrope(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        state.toggleConcern(value);
      },
      backgroundColor: AppColors.inputFieldBackground,
      selectedColor: AppColors.primary.withOpacity(0.15),
      checkmarkColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }
}

class _ContentCreatorFields extends StatelessWidget {
  final RegistrationState state;

  const _ContentCreatorFields({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _ProfilePicturePicker(state: state),
        AuthTextField(
          controller: state.bioController,
          label: l10n.bio,
          maxLines: 3,
          maxLength: 500,
          validator: (value) =>
              value?.isEmpty ?? true ? l10n.pleaseEnterBio : null,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.areasOfExpertise,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
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
        Text(
          l10n.socialPortfolioLinks,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        ...state.portfolioControllers.asMap().entries.map((entry) {
          final index = entry.key;
          final controller = entry.value;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AuthTextField(
                      controller: controller,
                      label: l10n.portfolioLink,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final urlRegex = RegExp(
                              r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');
                          if (!urlRegex.hasMatch(value)) {
                            return l10n.pleaseEnterValidUrl;
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  if (state.portfolioControllers.length > 1)
                    IconButton(
                      icon: const Icon(Icons.remove_circle,
                          color: AppColors.error),
                      onPressed: () => state.removePortfolioLinkField(index),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
        TextButton.icon(
          onPressed: state.addPortfolioLinkField,
          icon: const Icon(Icons.add, color: AppColors.primary),
          label: Text(l10n.addAnotherLink,
              style: GoogleFonts.manrope(color: AppColors.primary)),
        ),
      ],
    );
  }

  Widget _buildExpertiseChip(String label, String value) {
    final isSelected = state.selectedExpertise.contains(value);

    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.manrope(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        state.toggleExpertise(value);
      },
      backgroundColor: AppColors.inputFieldBackground,
      selectedColor: AppColors.primary.withOpacity(0.15),
      checkmarkColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }
}

class _CourseTrainerFields extends StatelessWidget {
  final RegistrationState state;

  const _CourseTrainerFields({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _ProfilePicturePicker(state: state),
        AuthTextField(
          controller: state.academicBackgroundController,
          label: l10n.academicBackground,
          maxLines: 3,
          maxLength: 500,
          validator: (value) => value?.isEmpty ?? true
              ? l10n.pleaseEnterAcademicBackground
              : null,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: state.certificationsController,
          label: l10n.certifications,
          maxLines: 3,
          maxLength: 500,
          hintText: l10n.certificationsHint,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9,\-\s]')),
          ],
          validator: (value) =>
              value?.isEmpty ?? true ? l10n.pleaseEnterCertifications : null,
        ),
        const SizedBox(height: 16),
        _CertificationDocumentPicker(state: state),
        const SizedBox(height: 16),
        Text(
          l10n.areasOfTrainingExpertise,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildExpertiseChip(l10n.mentalHealthTraining, 'mental_health'),
            _buildExpertiseChip(l10n.leadershipTraining, 'leadership'),
            _buildExpertiseChip(l10n.workplaceWellness, 'workplace_wellness'),
            _buildExpertiseChip(l10n.stressManagement, 'stress_management'),
            _buildExpertiseChip(l10n.softSkills, 'soft_skills'),
            _buildExpertiseChip(l10n.other, 'other'),
          ],
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: state.bioController,
          label: l10n.trainerBio,
          maxLines: 3,
          maxLength: 500,
          validator: (value) =>
              value?.isEmpty ?? true ? l10n.pleaseEnterBio : null,
        ),
      ],
    );
  }

  Widget _buildExpertiseChip(String label, String value) {
    final isSelected = state.selectedTrainingExpertise.contains(value);

    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.manrope(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        state.toggleTrainingExpertise(value);
      },
      backgroundColor: AppColors.inputFieldBackground,
      selectedColor: AppColors.primary.withOpacity(0.15),
      checkmarkColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }
}

class _TherapistFields extends StatelessWidget {
  final RegistrationState state;

  const _TherapistFields({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _ProfilePicturePicker(state: state),
        AuthTextField(
          controller: state.bioController,
          label: l10n.professionalBio,
          maxLines: 3,
          maxLength: 500,
          validator: (value) =>
              value?.isEmpty ?? true ? l10n.pleaseEnterBio : null,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: state.credentialsController,
          label: l10n.credentialsLicense,
          maxLines: 2,
          maxLength: 200,
          validator: (value) =>
              value?.isEmpty ?? true ? l10n.pleaseEnterCredentials : null,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.specializations,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildSpecializationChip(l10n.cbt, 'cbt'),
            _buildSpecializationChip(l10n.ptsd, 'ptsd'),
            _buildSpecializationChip(l10n.adolescents, 'adolescents'),
            _buildSpecializationChip(l10n.anxiety, 'anxiety'),
            _buildSpecializationChip(l10n.depression, 'depression'),
            _buildSpecializationChip(l10n.couplesTherapy, 'couples'),
            _buildSpecializationChip(l10n.other, 'other'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          l10n.languagesSpoken,
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _buildLanguageChip(l10n.english, 'english'),
            _buildLanguageChip(l10n.amharic, 'amharic'),
            _buildLanguageChip(l10n.spanish, 'spanish'),
            _buildLanguageChip(l10n.french, 'french'),
            _buildLanguageChip(l10n.other, 'other'),
          ],
        ),
        const SizedBox(height: 16),
        _LicenseDocumentPicker(state: state),
        const SizedBox(height: 16),
        AuthTextField(
          controller: state.availabilityController,
          label: l10n.availabilitySchedule,
          maxLines: 3,
          hintText: l10n.availabilityHint,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9,\-\s:]')),
          ],
          validator: (value) =>
              value?.isEmpty ?? true ? l10n.pleaseEnterAvailability : null,
        ),
      ],
    );
  }

  Widget _buildSpecializationChip(String label, String value) {
    final isSelected = state.selectedSpecializations.contains(value);

    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.manrope(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        state.toggleSpecialization(value);
      },
      backgroundColor: AppColors.inputFieldBackground,
      selectedColor: AppColors.primary.withOpacity(0.15),
      checkmarkColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }

  Widget _buildLanguageChip(String label, String value) {
    final isSelected = state.selectedLanguages.contains(value);

    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.manrope(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        state.toggleLanguage(value);
      },
      backgroundColor: AppColors.inputFieldBackground,
      selectedColor: AppColors.primary.withOpacity(0.15),
      checkmarkColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }
}

class _AdminFields extends StatelessWidget {
  final RegistrationState state;

  const _AdminFields({required this.state});

  @override
  Widget build(BuildContext context) {
    return _ProfilePicturePicker(state: state);
  }
}

class _ProfilePicturePicker extends StatelessWidget {
  final RegistrationState state;

  const _ProfilePicturePicker({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        GestureDetector(
          onTap: state.pickProfilePicture,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: state.profilePicture != null
                ? FutureBuilder<Uint8List>(
                    future: state.profilePicture!.readAsBytes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return ClipOval(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        );
                      }
                      return const CircularProgressIndicator(
                          color: AppColors.primary);
                    },
                  )
                : const Icon(Icons.add_a_photo,
                    size: 40, color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.profilePicture == null
              ? l10n.uploadProfilePicture
              : l10n.changeProfilePicture,
          style: GoogleFonts.manrope(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _LicenseDocumentPicker extends StatelessWidget {
  final RegistrationState state;

  const _LicenseDocumentPicker({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        GestureDetector(
          onTap: state.pickLicenseDocument,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: AppColors.border),
            ),
            child: state.licenseDocument != null
                ? FutureBuilder<Uint8List>(
                    future: state.licenseDocument!.readAsBytes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        );
                      }
                      return const CircularProgressIndicator(
                          color: AppColors.primary);
                    },
                  )
                : const Icon(Icons.upload_file,
                    size: 40, color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.licenseDocument == null
              ? l10n.uploadLicense
              : l10n.changeLicense,
          style: GoogleFonts.manrope(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _CertificationDocumentPicker extends StatelessWidget {
  final RegistrationState state;

  const _CertificationDocumentPicker({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        GestureDetector(
          onTap: state.pickCertificationDocument,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: AppColors.border),
            ),
            child: state.certificationDocument != null
                ? FutureBuilder<Uint8List>(
                    future: state.certificationDocument!.readAsBytes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        );
                      }
                      return const CircularProgressIndicator(
                          color: AppColors.primary);
                    },
                  )
                : const Icon(Icons.upload_file,
                    size: 40, color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.certificationDocument == null
              ? l10n.uploadCertification
              : l10n.changeCertification,
          style: GoogleFonts.manrope(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
