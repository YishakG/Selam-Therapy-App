import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:image_picker/image_picker.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Signs in a user with email and password.
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      email = email.toLowerCase();
      print('Signing in with email: $email');

      // Validate inputs
      if (email.isEmpty ||
          !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(email)) {
        print('Invalid email format: $email');
        return {
          'success': false,
          'errorCode': 'invalid-email',
          'errorMessage': 'Invalid email format',
        };
      }
      if (password.isEmpty) {
        print('Empty password');
        return {
          'success': false,
          'errorCode': 'invalid-password',
          'errorMessage': 'Password cannot be empty',
        };
      }

      print('Attempting Firebase Authentication sign-in');
      await _auth.currentUser?.reload();
      firebase_auth.UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      print('Firebase Auth sign-in successful, UID: $uid');

      // Fetch user data
      print('Fetching user data for UID: $uid');
      final userData = await fetchUserData();
      if (!userData['success']) {
        print(
            'Failed to fetch user data: ${userData['errorCode']} - ${userData['errorMessage']}');
        return {
          'success': false,
          'errorCode': userData['errorCode'],
          'errorMessage': userData['errorMessage'],
        };
      }

      print('User data fetched, role: ${userData['role']}');
      return {
        'success': true,
        'uid': uid,
        'role': userData['role'],
        'userData': userData,
      };
    } catch (e) {
      print('Error during sign-in: $e');
      String errorCode;
      String errorMessage = e.toString();
      if (e is firebase_auth.FirebaseAuthException) {
        errorCode = e.code;
        errorMessage = e.message ?? 'Unknown Firebase error';
      } else {
        errorCode = 'unknown-error';
      }
      return {
        'success': false,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
    }
  }

  /// Creates a new user account.
  Future<Map<String, dynamic>> createAccount({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required UserRole role,
    DateTime? dateOfBirth,
    String? gender,
    String? preferredLanguage,
    List<String>? concerns,
    bool? hasHadTherapy,
    String? therapyType,
    String? therapyDuration,
    String? therapistBackground,
    String? therapistGender,
    String? bio,
    List<String>? expertise,
    List<String>? specializations,
    List<String>? languages,
    String? credentials,
    String? availability,
    List<String>? portfolioLinks,
    XFile? profilePicture,
    XFile? licenseDocument,
    String? academicBackground,
    String? certifications,
    List<String>? trainingExpertise,
    XFile? certificationDocument,
  }) async {
    try {
      email = email.toLowerCase();
      print('Creating account with email: $email, role: ${role.name}');

      // Validate inputs
      if (email.isEmpty ||
          !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(email)) {
        print('Invalid email: $email');
        return {
          'success': false,
          'errorCode': 'invalid-email',
          'errorMessage': 'Invalid email format',
        };
      }
      if (password.length < 8) {
        print('Weak password: length ${password.length}');
        return {
          'success': false,
          'errorCode': 'weak-password',
          'errorMessage': 'Password must be at least 8 characters',
        };
      }
      if (!RegExp(
              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(password)) {
        print('Password does not meet requirements');
        return {
          'success': false,
          'errorCode': 'weak-password',
          'errorMessage':
              'Password must include uppercase, lowercase, number, and special character',
        };
      }
      // Require dateOfBirth for clients
      if (role == UserRole.client && dateOfBirth == null) {
        print('Missing date of birth for client');
        return {
          'success': false,
          'errorCode': 'missing-date-of-birth',
          'errorMessage': 'Date of birth is required for clients',
        };
      }

      print('Attempting Firebase Authentication for email: $email');
      firebase_auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      print('User created in Firebase Auth: $uid');

      // Prepare user data
      Map<String, dynamic> userData = {
        'uid': uid,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phoneNumber,
        'role': role.name,
        'created_at': FieldValue.serverTimestamp(),
      };

      // Add to users collection
      try {
        await _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'role': role.name,
          'created_at': FieldValue.serverTimestamp(),
        });
        print('User data stored in users collection for UID: $uid');
      } catch (e) {
        print('Failed to store user data in users collection: $e');
        // Clean up Firebase Auth user if Firestore write fails
        await _auth.currentUser?.delete();
        return {
          'success': false,
          'errorCode': 'firestore-error',
          'errorMessage': 'Failed to store user data in users collection: $e',
        };
      }

      // Handle profile picture upload
      String? profilePictureUrl;
      if (profilePicture != null) {
        try {
          final fileName =
              '$uid/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
          print('Uploading profile picture to Supabase: $fileName');
          if (kIsWeb) {
            final bytes = await profilePicture.readAsBytes();
            await _supabase.storage.from('profile-pictures').uploadBinary(
                  fileName,
                  bytes,
                  fileOptions: const FileOptions(contentType: 'image/jpeg'),
                );
          } else {
            final file = File(profilePicture.path);
            await _supabase.storage
                .from('profile-pictures')
                .upload(fileName, file);
          }
          profilePictureUrl =
              _supabase.storage.from('profile-pictures').getPublicUrl(fileName);
          print('Profile picture uploaded: $profilePictureUrl');
        } catch (e) {
          print('Profile picture upload failed: $e');
          // Clean up Firebase Auth user and Firestore data
          await _firestore.collection('users').doc(uid).delete();
          await _auth.currentUser?.delete();
          return {
            'success': false,
            'errorCode': 'storage-error',
            'errorMessage': 'Failed to upload profile picture: $e',
          };
        }
      }

      // Handle license document upload
      String? licenseDocumentUrl;
      if (role == UserRole.therapist && licenseDocument != null) {
        try {
          final fileName =
              '$uid/license_${DateTime.now().millisecondsSinceEpoch}.jpg';
          print('Uploading license document to Supabase: $fileName');
          if (kIsWeb) {
            final bytes = await licenseDocument.readAsBytes();
            await _supabase.storage.from('license-documents').uploadBinary(
                  fileName,
                  bytes,
                  fileOptions: const FileOptions(contentType: 'image/jpeg'),
                );
          } else {
            final file = File(licenseDocument.path);
            await _supabase.storage
                .from('license-documents')
                .upload(fileName, file);
          }
          licenseDocumentUrl = _supabase.storage
              .from('license-documents')
              .getPublicUrl(fileName);
          print('License document uploaded: $licenseDocumentUrl');
        } catch (e) {
          print('License document upload failed: $e');
          // Clean up Firebase Auth user and Firestore data
          await _firestore.collection('users').doc(uid).delete();
          await _auth.currentUser?.delete();
          return {
            'success': false,
            'errorCode': 'storage-error',
            'errorMessage': 'Failed to upload license document: $e',
          };
        }
      }

      // Handle certification document upload
      String? certificationDocumentUrl;
      if (role == UserRole.courseTrainer && certificationDocument != null) {
        try {
          final fileName =
              '$uid/certification_${DateTime.now().millisecondsSinceEpoch}.jpg';
          print('Uploading certification document to Supabase: $fileName');
          if (kIsWeb) {
            final bytes = await certificationDocument.readAsBytes();
            await _supabase.storage.from('certifications').uploadBinary(
                  fileName,
                  bytes,
                  fileOptions: const FileOptions(contentType: 'image/jpeg'),
                );
          } else {
            final file = File(certificationDocument.path);
            await _supabase.storage
                .from('certifications')
                .upload(fileName, file);
          }
          certificationDocumentUrl =
              _supabase.storage.from('certifications').getPublicUrl(fileName);
          print('Certification document uploaded: $certificationDocumentUrl');
        } catch (e) {
          print('Certification document upload failed: $e');
          // Clean up Firebase Auth user and Firestore data
          await _firestore.collection('users').doc(uid).delete();
          await _auth.currentUser?.delete();
          return {
            'success': false,
            'errorCode': 'storage-error',
            'errorMessage': 'Failed to upload certification document: $e',
          };
        }
      }

      // Add role-specific data
      if (role == UserRole.client) {
        userData.addAll({
          'date_of_birth': dateOfBirth?.toIso8601String(),
          'gender': gender,
          'preferred_language': preferredLanguage,
          'concerns': concerns ?? [],
          'has_had_therapy': hasHadTherapy,
          'therapy_type': therapyType,
          'therapy_duration': therapyDuration,
          'therapist_background': therapistBackground,
          'therapist_gender': therapistGender,
          'profile_picture_url': profilePictureUrl,
        });
      } else if (role == UserRole.contentCreator ||
          role == UserRole.contentSupervisor) {
        userData.addAll({
          'bio': bio,
          'expertise': expertise ?? [],
          'portfolio_links': portfolioLinks ?? [],
          'profile_picture_url': profilePictureUrl,
        });
      } else if (role == UserRole.courseTrainer) {
        userData.addAll({
          'bio': bio,
          'academic_background': academicBackground,
          'certifications': certifications,
          'training_expertise': trainingExpertise ?? [],
          'profile_picture_url': profilePictureUrl,
          'certification_document_url': certificationDocumentUrl,
        });
      } else if (role == UserRole.therapist) {
        userData.addAll({
          'bio': bio,
          'specializations': specializations ?? [],
          'languages': languages ?? [],
          'credentials': credentials,
          'availability': availability,
          'profile_picture_url': profilePictureUrl,
          'license_document_url': licenseDocumentUrl,
        });
      } else if (role == UserRole.admin) {
        userData.addAll({
          'bio': bio,
          'profile_picture_url': profilePictureUrl,
        });
      }

      // Store in role-specific collection
      final collectionName = role == UserRole.client
          ? 'Clients'
          : role == UserRole.contentCreator
              ? 'ContentCreators'
              : role == UserRole.contentSupervisor
                  ? 'ContentSupervisors'
                  : role == UserRole.courseTrainer
                      ? 'CourseTrainers'
                      : role == UserRole.therapist
                          ? 'Therapists'
                          : 'Admins';
      print(
          'Storing user data in Firestore collection: $collectionName, UID: $uid');
      try {
        await _firestore.collection(collectionName).doc(uid).set(userData);
        print('User data stored successfully in $collectionName/$uid');
      } catch (e) {
        print('Firestore write failed: $e');
        // Clean up Firebase Auth user and Firestore data
        await _firestore.collection('users').doc(uid).delete();
        await _auth.currentUser?.delete();
        return {
          'success': false,
          'errorCode': 'firestore-error',
          'errorMessage': 'Failed to store user data: $e',
        };
      }

      return {
        'success': true,
        'uid': uid,
        'role': role,
      };
    } catch (e) {
      print('Error during account creation: $e');
      String errorCode;
      String errorMessage = e.toString();
      if (e is firebase_auth.FirebaseAuthException) {
        errorCode = e.code;
        errorMessage = e.message ?? 'Unknown Firebase error';
      } else if (e is StorageException) {
        errorCode = 'storage-error';
        errorMessage = 'Supabase storage error: $e';
      } else {
        errorCode = 'unknown-error';
      }
      // Clean up Firebase Auth user on failure
      if (_auth.currentUser != null) {
        await _auth.currentUser?.delete();
      }
      return {
        'success': false,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
    }
  }

  /// Registers a user.
  Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
    DateTime? dateOfBirth,
    String? gender,
    String? language,
    List<String>? concerns,
    bool? hasHadTherapy,
    String? therapyType,
    String? therapyDuration,
    String? therapistBackground,
    String? therapistGender,
    String? bio,
    String? credentials,
    String? availability,
    String? academicBackground,
    String? certifications,
    List<String>? expertise,
    List<String>? specializations,
    List<String>? languages,
    List<String>? trainingExpertise,
    List<String>? portfolioLinks,
    XFile? profilePicture,
    XFile? licenseDocument,
    XFile? certificationDocument,
  }) async {
    try {
      email = email.toLowerCase();
      print('Registering user with email: $email, role: ${role.name}');

      // Validate inputs
      if (email.isEmpty ||
          !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(email)) {
        print('Invalid email: $email');
        return {
          'success': false,
          'errorCode': 'invalid-email',
          'errorMessage': 'Invalid email format',
        };
      }
      if (password.length < 8) {
        print('Weak password: length ${password.length}');
        return {
          'success': false,
          'errorCode': 'weak-password',
          'errorMessage': 'Password must be at least 8 characters',
        };
      }
      if (!RegExp(
              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(password)) {
        print('Password does not meet requirements');
        return {
          'success': false,
          'errorCode': 'weak-password',
          'errorMessage':
              'Password must include uppercase, lowercase, number, and special character',
        };
      }
      // Require dateOfBirth for clients
      if (role == UserRole.client && dateOfBirth == null) {
        print('Missing date of birth for client');
        return {
          'success': false,
          'errorCode': 'missing-date-of-birth',
          'errorMessage': 'Date of birth is required for clients',
        };
      }

      print('Attempting Firebase Authentication for email: $email');
      firebase_auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        print('User creation failed');
        return {
          'success': false,
          'errorCode': 'auth-error',
          'errorMessage': 'User creation failed',
        };
      }
      String uid = user.uid;
      print('User created in Firebase Auth: $uid');

      // Prepare user data
      Map<String, dynamic> userData = {
        'uid': uid,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'role': role.name,
        'created_at': FieldValue.serverTimestamp(),
      };

      // Add to users collection
      try {
        await _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'role': role.name,
          'created_at': FieldValue.serverTimestamp(),
        });
        print('User data stored in users collection for UID: $uid');
      } catch (e) {
        print('Failed to store user data in users collection: $e');
        // Clean up Firebase Auth user
        await _auth.currentUser?.delete();
        return {
          'success': false,
          'errorCode': 'firestore-error',
          'errorMessage': 'Failed to store user data in users collection: $e',
        };
      }

      // Handle profile picture upload
      String? profilePictureUrl;
      if (profilePicture != null) {
        try {
          final fileName =
              '$uid/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
          print('Uploading profile picture to Supabase: $fileName');
          if (kIsWeb) {
            final bytes = await profilePicture.readAsBytes();
            await _supabase.storage.from('profile-pictures').uploadBinary(
                  fileName,
                  bytes,
                  fileOptions: const FileOptions(contentType: 'image/jpeg'),
                );
          } else {
            final file = File(profilePicture.path);
            await _supabase.storage
                .from('profile-pictures')
                .upload(fileName, file);
          }
          profilePictureUrl =
              _supabase.storage.from('profile-pictures').getPublicUrl(fileName);
          print('Profile picture uploaded: $profilePictureUrl');
        } catch (e) {
          print('Profile picture upload failed: $e');
          // Clean up Firebase Auth user and Firestore data
          await _firestore.collection('users').doc(uid).delete();
          await _auth.currentUser?.delete();
          return {
            'success': false,
            'errorCode': 'storage-error',
            'errorMessage': 'Failed to upload profile picture: $e',
          };
        }
      }

      // Handle license document upload
      String? licenseDocumentUrl;
      if (role == UserRole.therapist && licenseDocument != null) {
        try {
          final fileName =
              '$uid/license_${DateTime.now().millisecondsSinceEpoch}.jpg';
          print('Uploading license document to Supabase: $fileName');
          if (kIsWeb) {
            final bytes = await licenseDocument.readAsBytes();
            await _supabase.storage.from('license-documents').uploadBinary(
                  fileName,
                  bytes,
                  fileOptions: const FileOptions(contentType: 'image/jpeg'),
                );
          } else {
            final file = File(licenseDocument.path);
            await _supabase.storage
                .from('license-documents')
                .upload(fileName, file);
          }
          licenseDocumentUrl = _supabase.storage
              .from('license-documents')
              .getPublicUrl(fileName);
          print('License document uploaded: $licenseDocumentUrl');
        } catch (e) {
          print('License document upload failed: $e');
          // Clean up Firebase Auth user and Firestore data
          await _firestore.collection('users').doc(uid).delete();
          await _auth.currentUser?.delete();
          return {
            'success': false,
            'errorCode': 'storage-error',
            'errorMessage': 'Failed to upload license document: $e',
          };
        }
      }

      // Handle certification document upload
      String? certificationDocumentUrl;
      if (role == UserRole.courseTrainer && certificationDocument != null) {
        try {
          final fileName =
              '$uid/certification_${DateTime.now().millisecondsSinceEpoch}.jpg';
          print('Uploading certification document to Supabase: $fileName');
          if (kIsWeb) {
            final bytes = await certificationDocument.readAsBytes();
            await _supabase.storage.from('certifications').uploadBinary(
                  fileName,
                  bytes,
                  fileOptions: const FileOptions(contentType: 'image/jpeg'),
                );
          } else {
            final file = File(certificationDocument.path);
            await _supabase.storage
                .from('certifications')
                .upload(fileName, file);
          }
          certificationDocumentUrl =
              _supabase.storage.from('certifications').getPublicUrl(fileName);
          print('Certification document uploaded: $certificationDocumentUrl');
        } catch (e) {
          print('Certification document upload failed: $e');
          // Clean up Firebase Auth user and Firestore data
          await _firestore.collection('users').doc(uid).delete();
          await _auth.currentUser?.delete();
          return {
            'success': false,
            'errorCode': 'storage-error',
            'errorMessage': 'Failed to upload certification document: $e',
          };
        }
      }

      // Add role-specific data
      if (role == UserRole.client) {
        userData.addAll({
          'date_of_birth': dateOfBirth?.toIso8601String(),
          'gender': gender,
          'language': language,
          'concerns': concerns ?? [],
          'has_had_therapy': hasHadTherapy,
          'therapy_type': therapyType,
          'therapy_duration': therapyDuration,
          'therapist_background': therapistBackground,
          'therapist_gender': therapistGender,
          'profile_picture_url': profilePictureUrl,
        });
      } else if (role == UserRole.therapist) {
        userData.addAll({
          'bio': bio,
          'credentials': credentials,
          'availability': availability,
          'specializations': specializations ?? [],
          'languages': languages ?? [],
          'profile_picture_url': profilePictureUrl,
          'license_document_url': licenseDocumentUrl,
        });
      } else if (role == UserRole.courseTrainer) {
        userData.addAll({
          'academic_background': academicBackground,
          'certifications': certifications,
          'training_expertise': trainingExpertise ?? [],
          'bio': bio,
          'profile_picture_url': profilePictureUrl,
          'certification_document_url': certificationDocumentUrl,
        });
      } else if (role == UserRole.contentCreator ||
          role == UserRole.contentSupervisor) {
        userData.addAll({
          'bio': bio,
          'expertise': expertise ?? [],
          'portfolio_links': portfolioLinks ?? [],
          'profile_picture_url': profilePictureUrl,
        });
      } else if (role == UserRole.admin) {
        userData.addAll({
          'bio': bio,
          'profile_picture_url': profilePictureUrl,
        });
      }

      // Store in role-specific collection
      final collectionName = role == UserRole.client
          ? 'Clients'
          : role == UserRole.contentCreator
              ? 'ContentCreators'
              : role == UserRole.contentSupervisor
                  ? 'ContentSupervisors'
                  : role == UserRole.courseTrainer
                      ? 'CourseTrainers'
                      : role == UserRole.therapist
                          ? 'Therapists'
                          : 'Admins';
      print(
          'Storing user data in Firestore collection: $collectionName, UID: $uid');
      try {
        await _firestore.collection(collectionName).doc(uid).set(userData);
        print('User data stored successfully in $collectionName/$uid');
      } catch (e) {
        print('Firestore write failed: $e');
        // Clean up Firebase Auth user and Firestore data
        await _firestore.collection('users').doc(uid).delete();
        await _auth.currentUser?.delete();
        return {
          'success': false,
          'errorCode': 'firestore-error',
          'errorMessage': 'Failed to store user data: $e',
        };
      }

      return {
        'success': true,
        'uid': uid,
        'role': role,
      };
    } catch (e) {
      print('Error during registration: $e');
      String errorCode;
      String errorMessage = e.toString();
      if (e is firebase_auth.FirebaseAuthException) {
        errorCode = e.code;
        errorMessage = e.message ?? 'Unknown Firebase error';
      } else if (e is StorageException) {
        errorCode = 'storage-error';
        errorMessage = 'Supabase storage error: $e';
      } else {
        errorCode = 'unknown-error';
      }
      // Clean up Firebase Auth user on failure
      if (_auth.currentUser != null) {
        await _auth.currentUser?.delete();
      }
      return {
        'success': false,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
    }
  }

  /// Fetches user data.
  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('No authenticated user found');
        return {
          'success': false,
          'errorCode': 'no-user',
          'errorMessage': 'No authenticated user found',
        };
      }

      final uid = user.uid;
      print('Fetching data for user: $uid');

      // First, get the user's role from the users collection
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        print('No user data found in users collection for UID: $uid');
        return {
          'success': false,
          'errorCode': 'user-not-found',
          'errorMessage':
              'User data not found in users collection. Please register.',
        };
      }

      final userData = userDoc.data()!;
      final roleString = userData['role'] as String;
      final role = UserRole.values.firstWhere(
        (r) => r.name == roleString,
        orElse: () => UserRole.client,
      );
      print('User role from users collection: $roleString');

      // Map role to collection name
      final collectionName = role == UserRole.client
          ? 'Clients'
          : role == UserRole.contentCreator
              ? 'ContentCreators'
              : role == UserRole.contentSupervisor
                  ? 'ContentSupervisors'
                  : role == UserRole.courseTrainer
                      ? 'CourseTrainers'
                      : role == UserRole.therapist
                          ? 'Therapists'
                          : 'Admins';

      // Fetch detailed data from the role-specific collection
      final roleDoc =
          await _firestore.collection(collectionName).doc(uid).get();
      if (!roleDoc.exists) {
        print('No user data found in $collectionName for UID: $uid');
        return {
          'success': false,
          'errorCode': 'user-not-found',
          'errorMessage':
              'User data not found in $collectionName. Please register.',
        };
      }

      final data = roleDoc.data()!;
      print('Data found in $collectionName: ${data['role']}');
      final profilePictureUrl = data['profile_picture_url'] as String?;
      bool imageExists = false;

      if (profilePictureUrl != null) {
        try {
          final response = await _supabase.storage
              .from('profile-pictures')
              .getPublicUrl(profilePictureUrl.split('/').last);
          imageExists = true;
        } catch (e) {
          print('Error verifying profile picture: $e');
        }
      }

      final result = {
        'success': true,
        'uid': uid,
        'role': role,
        'email': data['email'],
        'first_name': data['first_name'],
        'last_name': data['last_name'],
        'phone': data['phone'],
        'profile_picture_url': imageExists ? profilePictureUrl : null,
      };

      if (role == UserRole.client) {
        result.addAll({
          'date_of_birth': data['date_of_birth'] != null
              ? (data['date_of_birth'] is Timestamp
                  ? (data['date_of_birth'] as Timestamp).toDate()
                  : DateTime.tryParse(data['date_of_birth'] as String))
              : null,
          'gender': data['gender'],
          'language': data['language'],
          'concerns': data['concerns']?.cast<String>(),
          'has_had_therapy': data['has_had_therapy'],
          'therapy_type': data['therapy_type'],
          'therapy_duration': data['therapy_duration'],
          'therapist_background': data['therapist_background'],
          'therapist_gender': data['therapist_gender'],
        });
      } else if (role == UserRole.therapist) {
        final licenseDocumentUrl = data['license_document_url'] as String?;
        bool licenseImageExists = false;
        if (licenseDocumentUrl != null) {
          try {
            final response = await _supabase.storage
                .from('license-documents')
                .getPublicUrl(licenseDocumentUrl.split('/').last);
            licenseImageExists = true;
          } catch (e) {
            print('Error verifying license document: $e');
          }
        }
        result.addAll({
          'bio': data['bio'],
          'specializations': data['specializations']?.cast<String>(),
          'languages': data['languages']?.cast<String>(),
          'credentials': data['credentials'],
          'availability': data['availability'],
          'license_document_url':
              licenseImageExists ? licenseDocumentUrl : null,
        });
      } else if (role == UserRole.courseTrainer) {
        final certificationDocumentUrl =
            data['certification_document_url'] as String?;
        bool certificationImageExists = false;
        if (certificationDocumentUrl != null) {
          try {
            final response = await _supabase.storage
                .from('certifications')
                .getPublicUrl(certificationDocumentUrl.split('/').last);
            certificationImageExists = true;
          } catch (e) {
            print('Error verifying certification document: $e');
          }
        }
        result.addAll({
          'bio': data['bio'],
          'academic_background': data['academic_background'],
          'certifications': data['certifications'],
          'training_expertise': data['training_expertise']?.cast<String>(),
          'certification_document_url':
              certificationImageExists ? certificationDocumentUrl : null,
        });
      } else if (role == UserRole.contentCreator ||
          role == UserRole.contentSupervisor) {
        result.addAll({
          'bio': data['bio'],
          'expertise': data['expertise']?.cast<String>(),
          'portfolio_links': data['portfolio_links']?.cast<String>(),
        });
      } else if (role == UserRole.admin) {
        result.addAll({
          'bio': data['bio'],
        });
      }

      return result;
    } catch (e) {
      print('Error fetching user data: $e');
      return {
        'success': false,
        'errorCode': 'fetch-error',
        'errorMessage': 'Failed to fetch user data: $e',
      };
    }
  }

  /// Signs out the current user.
  Future<Map<String, dynamic>> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out successfully');
      return {
        'success': true,
      };
    } catch (e) {
      print('Error during sign-out: $e');
      return {
        'success': false,
        'errorCode': 'sign-out-error',
        'errorMessage': 'Failed to sign out: $e',
      };
    }
  }

  /// Sends a password reset email.
  Future<Map<String, dynamic>> resetPassword({required String email}) async {
    try {
      email = email.toLowerCase();
      print('Sending password reset email to: $email');
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent successfully');
      return {
        'success': true,
      };
    } catch (e) {
      print('Error sending password reset: $e');
      String errorCode;
      String errorMessage = e.toString();
      if (e is firebase_auth.FirebaseAuthException) {
        errorCode = e.code;
        errorMessage = e.message ?? 'Unknown Firebase error';
      } else {
        errorCode = 'unknown-error';
      }
      return {
        'success': false,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
      };
    }
  }

  /// Gets the current authenticated user.
  firebase_auth.User? getCurrentUser() {
    return _auth.currentUser;
  }
}
