import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selam_app/core/constants/user_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      await _auth.currentUser?.reload(); // Ensure fresh auth state
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      print('Firebase Auth sign-in successful, UID: $uid');

      // Fetch user data to get role
      print('Fetching user data for UID: $uid');
      final userData = await fetchUserData();
      if (!userData['success']) {
        print(
            'Failed to fetch user data: ${userData['errorCode']} - ${userData['errorMessage']}');
        return userData;
      }

      print(
          'User data fetched successfully, role: ${userData['role']}, type: ${userData['role'].runtimeType}');
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
      if (e is FirebaseAuthException) {
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

  /// Creates a new user account and stores data in Firebase and Supabase.
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
    List<String>? portfolioLinks,
    XFile? profilePicture,
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

      print('Attempting Firebase Authentication for email: $email');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      print('User created in Firebase Auth: $uid');

      // Prepare common user data
      Map<String, dynamic> userData = {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'role': role.name,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Handle profile picture upload
      String? profilePictureUrl;
      if (profilePicture != null) {
        try {
          final fileName = '$uid/${DateTime.now().millisecondsSinceEpoch}.jpg';
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
          return {
            'success': false,
            'errorCode': 'storage-error',
            'errorMessage': 'Failed to upload profile picture: $e',
          };
        }
      }

      // Add role-specific data
      if (role == UserRole.client) {
        userData.addAll({
          'dateOfBirth': dateOfBirth,
          'gender': gender,
          'preferredLanguage': preferredLanguage,
          'concerns': concerns,
          'hasHadTherapy': hasHadTherapy,
          'therapyType': therapyType,
          'therapyDuration': therapyDuration,
          'therapistBackground': therapistBackground,
          'therapistGender': therapistGender,
          'profilePictureUrl': profilePictureUrl,
        });
      } else if (role == UserRole.contentCreator ||
          role == UserRole.contentSupervisor ||
          role == UserRole.courseTrainer) {
        userData.addAll({
          'bio': bio,
          'expertise': expertise,
          'portfolioLinks': portfolioLinks,
          'profilePictureUrl': profilePictureUrl,
        });
      } else if (role == UserRole.therapist || role == UserRole.admin) {
        userData.addAll({
          'bio': bio,
          'profilePictureUrl': profilePictureUrl,
        });
      }

      // Store in appropriate Firestore collection
      final collectionName = role == UserRole.client
          ? 'Clients'
          : role == UserRole.contentCreator
              ? 'ContentCreators'
              : role == UserRole.admin
                  ? 'Admins'
                  : role == UserRole.therapist
                      ? 'Therapists'
                      : role == UserRole.contentSupervisor
                          ? 'ContentSupervisors'
                          : 'CourseTrainers';
      print(
          'Storing user data in Firestore collection: $collectionName, UID: $uid');
      try {
        await _firestore.collection(collectionName).doc(uid).set(userData);
        print('User data stored successfully in $collectionName/$uid');
      } catch (e) {
        print('Firestore write failed: $e');
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
      if (e is FirebaseAuthException) {
        errorCode = e.code;
        errorMessage = e.message ?? 'Unknown Firebase error';
      } else if (e is StorageException) {
        errorCode = 'storage-error';
        errorMessage = 'Supabase storage error';
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

  /// Fetches user data from Firebase and Supabase for the current user.
  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      // Get current user from Firebase Authentication
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

      // Try fetching from Clients collection
      final clientDoc = await _firestore.collection('Clients').doc(uid).get();
      if (clientDoc.exists) {
        final data = clientDoc.data()!;
        print('Stored role in Firestore: ${data['role']}');
        final profilePictureUrl = data['profilePictureUrl'] as String?;
        bool imageExists = false;

        // Verify profile picture in Supabase
        if (profilePictureUrl != null) {
          try {
            final response = await _supabase.storage
                .from('profile-pictures')
                .getPublicUrl(profilePictureUrl.split('/').last);
            imageExists = true;
          } catch (e) {
            print('Error verifying profile picture: $e');
            imageExists = false;
          }
        }

        print('Client data found for UID: $uid');
        return {
          'success': true,
          'uid': uid,
          'role': UserRole.client,
          'email': data['email'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          'phoneNumber': data['phoneNumber'],
          'dateOfBirth': data['dateOfBirth'] != null
              ? (data['dateOfBirth'] as Timestamp).toDate()
              : null,
          'gender': data['gender'],
          'preferredLanguage': data['preferredLanguage'],
          'concerns': data['concerns']?.cast<String>(),
          'hasHadTherapy': data['hasHadTherapy'],
          'therapyType': data['therapyType'],
          'therapyDuration': data['therapyDuration'],
          'therapistBackground': data['therapistBackground'],
          'therapistGender': data['therapistGender'],
          'profilePictureUrl': imageExists ? profilePictureUrl : null,
        };
      }

      // Try fetching from ContentCreators collection
      final creatorDoc =
          await _firestore.collection('ContentCreators').doc(uid).get();
      if (creatorDoc.exists) {
        final data = creatorDoc.data()!;
        print('Stored role in Firestore: ${data['role']}');
        final profilePictureUrl = data['profilePictureUrl'] as String?;
        bool imageExists = false;

        if (profilePictureUrl != null) {
          try {
            final response = await _supabase.storage
                .from('profile-pictures')
                .getPublicUrl(profilePictureUrl.split('/').last);
            imageExists = true;
          } catch (e) {
            print('Error verifying profile picture: $e');
            imageExists = false;
          }
        }

        print('ContentCreator data found for UID: $uid');
        return {
          'success': true,
          'uid': uid,
          'role': UserRole.contentCreator,
          'email': data['email'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          'phoneNumber': data['phoneNumber'],
          'bio': data['bio'],
          'expertise': data['expertise']?.cast<String>(),
          'portfolioLinks': data['portfolioLinks']?.cast<String>(),
          'profilePictureUrl': imageExists ? profilePictureUrl : null,
        };
      }

      // Try fetching from ContentSupervisors collection
      final supervisorDoc =
          await _firestore.collection('ContentSupervisors').doc(uid).get();
      if (supervisorDoc.exists) {
        final data = supervisorDoc.data()!;
        print('Stored role in Firestore: ${data['role']}');
        final profilePictureUrl = data['profilePictureUrl'] as String?;
        bool imageExists = false;

        if (profilePictureUrl != null) {
          try {
            final response = await _supabase.storage
                .from('profile-pictures')
                .getPublicUrl(profilePictureUrl.split('/').last);
            imageExists = true;
          } catch (e) {
            print('Error verifying profile picture: $e');
            imageExists = false;
          }
        }

        print('ContentSupervisor data found for UID: $uid');
        return {
          'success': true,
          'uid': uid,
          'role': UserRole.contentSupervisor,
          'email': data['email'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          'phoneNumber': data['phoneNumber'],
          'bio': data['bio'],
          'expertise': data['expertise']?.cast<String>(),
          'portfolioLinks': data['portfolioLinks']?.cast<String>(),
          'profilePictureUrl': imageExists ? profilePictureUrl : null,
        };
      }

      // Try fetching from CourseTrainers collection
      final trainerDoc =
          await _firestore.collection('CourseTrainers').doc(uid).get();
      if (trainerDoc.exists) {
        final data = trainerDoc.data()!;
        print('Stored role in Firestore: ${data['role']}');
        final profilePictureUrl = data['profilePictureUrl'] as String?;
        bool imageExists = false;

        if (profilePictureUrl != null) {
          try {
            final response = await _supabase.storage
                .from('profile-pictures')
                .getPublicUrl(profilePictureUrl.split('/').last);
            imageExists = true;
          } catch (e) {
            print('Error verifying profile picture: $e');
            imageExists = false;
          }
        }

        print('CourseTrainer data found for UID: $uid');
        return {
          'success': true,
          'uid': uid,
          'role': UserRole.courseTrainer,
          'email': data['email'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          'phoneNumber': data['phoneNumber'],
          'bio': data['bio'],
          'expertise': data['expertise']?.cast<String>(),
          'portfolioLinks': data['portfolioLinks']?.cast<String>(),
          'profilePictureUrl': imageExists ? profilePictureUrl : null,
        };
      }

      // Try fetching from Therapists collection
      final therapistDoc =
          await _firestore.collection('Therapists').doc(uid).get();
      if (therapistDoc.exists) {
        final data = therapistDoc.data()!;
        print('Stored role in Firestore: ${data['role']}');
        final profilePictureUrl = data['profilePictureUrl'] as String?;
        bool imageExists = false;

        if (profilePictureUrl != null) {
          try {
            final response = await _supabase.storage
                .from('profile-pictures')
                .getPublicUrl(profilePictureUrl.split('/').last);
            imageExists = true;
          } catch (e) {
            print('Error verifying profile picture: $e');
            imageExists = false;
          }
        }

        print('Therapist data found for UID: $uid');
        return {
          'success': true,
          'uid': uid,
          'role': UserRole.therapist,
          'email': data['email'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          'phoneNumber': data['phoneNumber'],
          'bio': data['bio'],
          'profilePictureUrl': imageExists ? profilePictureUrl : null,
        };
      }

      // Try fetching from Admins collection
      final adminDoc = await _firestore.collection('Admins').doc(uid).get();
      if (adminDoc.exists) {
        final data = adminDoc.data()!;
        print('Stored role in Firestore: ${data['role']}');
        final profilePictureUrl = data['profilePictureUrl'] as String?;
        bool imageExists = false;

        if (profilePictureUrl != null) {
          try {
            final response = await _supabase.storage
                .from('profile-pictures')
                .getPublicUrl(profilePictureUrl.split('/').last);
            imageExists = true;
          } catch (e) {
            print('Error verifying profile picture: $e');
            imageExists = false;
          }
        }

        print('Admin data found for UID: $uid');
        return {
          'success': true,
          'uid': uid,
          'role': UserRole.admin,
          'email': data['email'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          'phoneNumber': data['phoneNumber'],
          'bio': data['bio'],
          'profilePictureUrl': imageExists ? profilePictureUrl : null,
        };
      }

      print('No user data found in Firestore for UID: $uid');
      return {
        'success': false,
        'errorCode': 'user-not-found',
        'errorMessage': 'User data not found in Firestore',
      };
    } catch (e) {
      print('Error fetching user data: $e');
      return {
        'success': false,
        'errorCode': 'fetch-error',
        'errorMessage': 'Failed to fetch user data: $e',
      };
    }
  }
}
