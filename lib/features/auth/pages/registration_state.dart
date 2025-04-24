import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selam_app/core/constants/app_colors.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:selam_app/core/services/auth_service.dart';
 

class RegistrationState extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
  final credentialsController = TextEditingController();
  final availabilityController = TextEditingController();
  final academicBackgroundController = TextEditingController();
  final certificationsController = TextEditingController();
  final otherConcernsController = TextEditingController();
  final List<TextEditingController> portfolioControllers = [
    TextEditingController()
  ];

  UserRole _selectedRole = UserRole.client; // Default to client
  UserRole get selectedRole => _selectedRole;
  set selectedRole(UserRole role) {
    _selectedRole = role;
    notifyListeners();
  }

  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(DateTime? date) {
    _dateOfBirth = date;
    notifyListeners();
  }

  String? _selectedGender;
  String? get selectedGender => _selectedGender;
  set selectedGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  String? _selectedLanguage;
  String? get selectedLanguage => _selectedLanguage;
  set selectedLanguage(String? language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  final List<String> selectedConcerns = [];
  bool _hasHadTherapy = false;
  bool get hasHadTherapy => _hasHadTherapy;
  set hasHadTherapy(bool value) {
    _hasHadTherapy = value;
    notifyListeners();
  }

  String? _selectedTherapyType;
  String? get selectedTherapyType => _selectedTherapyType;
  set selectedTherapyType(String? type) {
    _selectedTherapyType = type;
    notifyListeners();
  }

  String? _selectedTherapyDuration;
  String? get selectedTherapyDuration => _selectedTherapyDuration;
  set selectedTherapyDuration(String? duration) {
    _selectedTherapyDuration = duration;
    notifyListeners();
  }

  String? _selectedTherapistBackground;
  String? get selectedTherapistBackground => _selectedTherapistBackground;
  set selectedTherapistBackground(String? background) {
    _selectedTherapistBackground = background;
    notifyListeners();
  }

  String? _selectedTherapistGender;
  String? get selectedTherapistGender => _selectedTherapistGender;
  set selectedTherapistGender(String? gender) {
    _selectedTherapistGender = gender;
    notifyListeners();
  }

  final List<String> selectedExpertise = [];
  final List<String> selectedSpecializations = [];
  final List<String> selectedLanguages = [];
  final List<String> selectedTrainingExpertise = [];

  XFile? _profilePicture;
  XFile? get profilePicture => _profilePicture;
  set profilePicture(XFile? picture) {
    _profilePicture = picture;
    notifyListeners();
  }

  XFile? _licenseDocument;
  XFile? get licenseDocument => _licenseDocument;
  set licenseDocument(XFile? document) {
    _licenseDocument = document;
    notifyListeners();
  }

  XFile? _certificationDocument;
  XFile? get certificationDocument => _certificationDocument;
  set certificationDocument(XFile? document) {
    _certificationDocument = document;
    notifyListeners();
  }

  bool _agreeToTerms = false;
  bool get agreeToTerms => _agreeToTerms;
  set agreeToTerms(bool value) {
    _agreeToTerms = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleConcern(String concern) {
    if (selectedConcerns.contains(concern)) {
      selectedConcerns.remove(concern);
    } else {
      selectedConcerns.add(concern);
    }
    notifyListeners();
  }

  void toggleExpertise(String expertise) {
    if (selectedExpertise.contains(expertise)) {
      selectedExpertise.remove(expertise);
    } else {
      selectedExpertise.add(expertise);
    }
    notifyListeners();
  }

  void toggleSpecialization(String specialization) {
    if (selectedSpecializations.contains(specialization)) {
      selectedSpecializations.remove(specialization);
    } else {
      selectedSpecializations.add(specialization);
    }
    notifyListeners();
  }

  void toggleLanguage(String language) {
    if (selectedLanguages.contains(language)) {
      selectedLanguages.remove(language);
    } else {
      selectedLanguages.add(language);
    }
    notifyListeners();
  }

  void toggleTrainingExpertise(String expertise) {
    if (selectedTrainingExpertise.contains(expertise)) {
      selectedTrainingExpertise.remove(expertise);
    } else {
      selectedTrainingExpertise.add(expertise);
    }
    notifyListeners();
  }

  void addPortfolioLinkField() {
    portfolioControllers.add(TextEditingController());
    notifyListeners();
  }

  void removePortfolioLinkField(int index) {
    if (portfolioControllers.length > 1) {
      portfolioControllers[index].dispose();
      portfolioControllers.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> pickProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePicture = XFile(pickedFile.path);
    }
  }

  Future<void> pickLicenseDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      licenseDocument = XFile(pickedFile.path);
    }
  }

  Future<void> pickCertificationDocument() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      certificationDocument = XFile(pickedFile.path);
    }
  }

  Future<bool> handleRegistration(BuildContext context) async {
    if (formKey.currentState!.validate() && agreeToTerms) {
      isLoading = true;
      try {
        await AuthService().registerUser(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
          role: selectedRole,
          dateOfBirth: dateOfBirth,
          gender: selectedGender,
          language: selectedLanguage,
          concerns: selectedConcerns,
          hasHadTherapy: hasHadTherapy,
          therapyType: selectedTherapyType,
          therapyDuration: selectedTherapyDuration,
          therapistBackground: selectedTherapistBackground,
          therapistGender: selectedTherapistGender,
          bio: bioController.text,
          credentials: credentialsController.text,
          availability: availabilityController.text,
          academicBackground: academicBackgroundController.text,
          certifications: certificationsController.text,
          expertise: selectedExpertise,
          specializations: selectedSpecializations,
          languages: selectedLanguages,
          trainingExpertise: selectedTrainingExpertise,
          portfolioLinks: portfolioControllers.map((c) => c.text).toList(),
          profilePicture: profilePicture,
          licenseDocument: licenseDocument,
          certificationDocument: certificationDocument,
        );
        isLoading = false;
        return true;
      } catch (e) {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
    }
    return false;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bioController.dispose();
    credentialsController.dispose();
    availabilityController.dispose();
    academicBackgroundController.dispose();
    certificationsController.dispose();
    otherConcernsController.dispose();
    for (var controller in portfolioControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
