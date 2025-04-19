import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Selam Therapy'**
  String get appName;

  /// The application's tagline
  ///
  /// In en, this message translates to:
  /// **'Your mental health companion'**
  String get tagline;

  /// Text for the get started button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Text for language selection
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Name of English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Name of Amharic language
  ///
  /// In en, this message translates to:
  /// **'አማርኛ'**
  String get amharic;

  /// Title for features section
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// Title for online therapy feature
  ///
  /// In en, this message translates to:
  /// **'Online Therapy'**
  String get onlineTherapy;

  /// Description for online therapy feature
  ///
  /// In en, this message translates to:
  /// **'Access therapy sessions from anywhere'**
  String get onlineTherapyDesc;

  /// Title for expert therapists feature
  ///
  /// In en, this message translates to:
  /// **'Expert Therapists'**
  String get expertTherapists;

  /// Description for expert therapists feature
  ///
  /// In en, this message translates to:
  /// **'Connect with qualified mental health professionals'**
  String get expertTherapistsDesc;

  /// Title for data privacy feature
  ///
  /// In en, this message translates to:
  /// **'Data Privacy'**
  String get dataPrivacy;

  /// Description for data privacy feature
  ///
  /// In en, this message translates to:
  /// **'Your information is secure and confidential'**
  String get dataPrivacyDesc;

  /// Title for personalized care feature
  ///
  /// In en, this message translates to:
  /// **'Personalized Care'**
  String get personalizedCare;

  /// Description for personalized care feature
  ///
  /// In en, this message translates to:
  /// **'Tailored treatment plans for your needs'**
  String get personalizedCareDesc;

  /// Title for 24/7 support feature
  ///
  /// In en, this message translates to:
  /// **'24/7 Support'**
  String get support247;

  /// Description for 24/7 support feature
  ///
  /// In en, this message translates to:
  /// **'Get help whenever you need it'**
  String get support247Desc;

  /// Text for create account button
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Text for login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Text for new user prompt
  ///
  /// In en, this message translates to:
  /// **'New to Selam?'**
  String get newUser;

  /// Text for existing user prompt
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get existingUser;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please log in to continue'**
  String get loginToContinue;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get emailOrPhone;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @emailOrPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Email or phone number is required'**
  String get emailOrPhoneRequired;

  /// No description provided for @invalidEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email or phone number'**
  String get invalidEmailOrPhone;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginError;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Label for home navigation item
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for videos navigation item
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// Label for services navigation item
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// Title for the courses page
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// Label for profile navigation item
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @emergencyHelp.
  ///
  /// In en, this message translates to:
  /// **'Emergency Help'**
  String get emergencyHelp;

  /// No description provided for @emergencyHelpDescription.
  ///
  /// In en, this message translates to:
  /// **'Get immediate assistance for mental health emergencies'**
  String get emergencyHelpDescription;

  /// No description provided for @getEmergencyHelp.
  ///
  /// In en, this message translates to:
  /// **'Get Emergency Help'**
  String get getEmergencyHelp;

  /// No description provided for @consultationServices.
  ///
  /// In en, this message translates to:
  /// **'Consultation Services'**
  String get consultationServices;

  /// No description provided for @healthConsultation.
  ///
  /// In en, this message translates to:
  /// **'Health Consultation'**
  String get healthConsultation;

  /// No description provided for @healthConsultationDesc.
  ///
  /// In en, this message translates to:
  /// **'Express your health concerns from the basics'**
  String get healthConsultationDesc;

  /// No description provided for @psychologyConsultation.
  ///
  /// In en, this message translates to:
  /// **'Psychology Consultation'**
  String get psychologyConsultation;

  /// No description provided for @psychologyConsultationDesc.
  ///
  /// In en, this message translates to:
  /// **'Talk privately with a professional'**
  String get psychologyConsultationDesc;

  /// No description provided for @familyConsultation.
  ///
  /// In en, this message translates to:
  /// **'Family Consultation'**
  String get familyConsultation;

  /// No description provided for @familyConsultationDesc.
  ///
  /// In en, this message translates to:
  /// **'Get better support for your family'**
  String get familyConsultationDesc;

  /// No description provided for @lifeConsultation.
  ///
  /// In en, this message translates to:
  /// **'Life Consultation'**
  String get lifeConsultation;

  /// No description provided for @lifeConsultationDesc.
  ///
  /// In en, this message translates to:
  /// **'Let\'s work together for a better life'**
  String get lifeConsultationDesc;

  /// No description provided for @effectiveCommunication.
  ///
  /// In en, this message translates to:
  /// **'Effective Communication Skills'**
  String get effectiveCommunication;

  /// No description provided for @stressManagement.
  ///
  /// In en, this message translates to:
  /// **'Stress Management'**
  String get stressManagement;

  /// No description provided for @mentalHealthBasics.
  ///
  /// In en, this message translates to:
  /// **'Mental Health Basics'**
  String get mentalHealthBasics;

  /// No description provided for @instructor.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get instructor;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @enrolledCourses.
  ///
  /// In en, this message translates to:
  /// **'Enrolled Courses'**
  String get enrolledCourses;

  /// No description provided for @registeredCourses.
  ///
  /// In en, this message translates to:
  /// **'Registered Courses'**
  String get registeredCourses;

  /// No description provided for @completedCourses.
  ///
  /// In en, this message translates to:
  /// **'Completed Courses'**
  String get completedCourses;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @mentalHealth.
  ///
  /// In en, this message translates to:
  /// **'Mental Health'**
  String get mentalHealth;

  /// No description provided for @mentalHealthDescription.
  ///
  /// In en, this message translates to:
  /// **'Professional counseling services'**
  String get mentalHealthDescription;

  /// No description provided for @familyCounseling.
  ///
  /// In en, this message translates to:
  /// **'Family Counseling'**
  String get familyCounseling;

  /// No description provided for @familyCounselingDescription.
  ///
  /// In en, this message translates to:
  /// **'Support for family relationships'**
  String get familyCounselingDescription;

  /// No description provided for @childCare.
  ///
  /// In en, this message translates to:
  /// **'Child Care'**
  String get childCare;

  /// No description provided for @childCareDescription.
  ///
  /// In en, this message translates to:
  /// **'Specialized care for children'**
  String get childCareDescription;

  /// No description provided for @healthEducation.
  ///
  /// In en, this message translates to:
  /// **'Health Education'**
  String get healthEducation;

  /// No description provided for @healthEducationDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn about mental health'**
  String get healthEducationDescription;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Selam App'**
  String get appTitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['am', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am': return AppLocalizationsAm();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
