import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selam_app/core/constants/app_colors.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:selam_app/core/services/auth_service.dart';

class ClientRegistrationState extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
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

  XFile? _profilePicture;
  XFile? get profilePicture => _profilePicture;
  set profilePicture(XFile? picture) {
    _profilePicture = picture;
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
          expertise: selectedExpertise,
          portfolioLinks: portfolioControllers.map((c) => c.text).toList(),
          profilePicture: profilePicture,
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
    otherConcernsController.dispose();
    for (var controller in portfolioControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
