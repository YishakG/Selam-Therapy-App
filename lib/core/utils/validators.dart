/// Validation functions used throughout the application.
/// This file contains utility functions for validating user input and data.
/// 
/// Example usage:
/// ```dart
/// import 'package:selam_app/core/utils/validators.dart';
/// 
/// // Validate email
/// final String? emailError = validateEmail('user@example.com');
/// 
/// // Validate password
/// final String? passwordError = validatePassword('password123');
/// 
/// // Validate phone number
/// final String? phoneError = validatePhoneNumber('251911234567');
/// ```
/// 
/// Implementation:
/// ```dart
/// /// Regular expression for email validation
/// final _emailRegex = RegExp(
///   r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
///   caseSensitive: false,
/// );
/// 
/// /// Regular expression for phone number validation (Ethiopian format)
/// final _phoneRegex = RegExp(r'^251[7-9][0-9]{8}$');
/// 
/// /// Regular expression for username validation
/// final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
/// 
/// /// Regular expression for URL validation
/// final _urlRegex = RegExp(
///   r'^(https?:\/\/)?' // protocol
///   r'((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|' // domain name
///   r'((\d{1,3}\.){3}\d{1,3}))' // OR ip (v4) address
///   r'(\:\d+)?(\/[-a-z\d%_.~+]*)*' // port and path
///   r'(\?[;&a-z\d%_.~+=-]*)?' // query string
///   r'(\#[-a-z\d_]*)?$', // fragment locator
///   caseSensitive: false,
/// );
/// 
/// /// Validate an email address
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validateEmail('user@example.com');
/// /// if (error != null) {
/// ///   print('Invalid email: $error');
/// /// }
/// /// ```
/// String? validateEmail(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Email is required';
///   }
///   if (!_emailRegex.hasMatch(value)) {
///     return 'Please enter a valid email address';
///   }
///   return null;
/// }
/// 
/// /// Validate a password
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validatePassword('password123');
/// /// if (error != null) {
/// ///   print('Invalid password: $error');
/// /// }
/// /// ```
/// String? validatePassword(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Password is required';
///   }
///   if (value.length < 8) {
///     return 'Password must be at least 8 characters long';
///   }
///   if (!value.contains(RegExp(r'[A-Z]'))) {
///     return 'Password must contain at least one uppercase letter';
///   }
///   if (!value.contains(RegExp(r'[a-z]'))) {
///     return 'Password must contain at least one lowercase letter';
///   }
///   if (!value.contains(RegExp(r'[0-9]'))) {
///     return 'Password must contain at least one number';
///   }
///   if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
///     return 'Password must contain at least one special character';
///   }
///   return null;
/// }
/// 
/// /// Validate a phone number (Ethiopian format)
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validatePhoneNumber('251911234567');
/// /// if (error != null) {
/// ///   print('Invalid phone number: $error');
/// /// }
/// /// ```
/// String? validatePhoneNumber(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Phone number is required';
///   }
///   if (!_phoneRegex.hasMatch(value)) {
///     return 'Please enter a valid Ethiopian phone number';
///   }
///   return null;
/// }
/// 
/// /// Validate a username
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validateUsername('john_doe');
/// /// if (error != null) {
/// ///   print('Invalid username: $error');
/// /// }
/// /// ```
/// String? validateUsername(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Username is required';
///   }
///   if (!_usernameRegex.hasMatch(value)) {
///     return 'Username must be 3-20 characters long and can only contain letters, numbers, and underscores';
///   }
///   return null;
/// }
/// 
/// /// Validate a URL
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validateUrl('https://example.com');
/// /// if (error != null) {
/// ///   print('Invalid URL: $error');
/// /// }
/// /// ```
/// String? validateUrl(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'URL is required';
///   }
///   if (!_urlRegex.hasMatch(value)) {
///     return 'Please enter a valid URL';
///   }
///   return null;
/// }
/// 
/// /// Validate a name
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validateName('John Doe');
/// /// if (error != null) {
/// ///   print('Invalid name: $error');
/// /// }
/// /// ```
/// String? validateName(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Name is required';
///   }
///   if (value.length < 2) {
///     return 'Name must be at least 2 characters long';
///   }
///   if (value.length > 50) {
///     return 'Name must be less than 50 characters long';
///   }
///   if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
///     return 'Name can only contain letters and spaces';
///   }
///   return null;
/// }
/// 
/// /// Validate a bio
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validateBio('My bio');
/// /// if (error != null) {
/// ///   print('Invalid bio: $error');
/// /// }
/// /// ```
/// String? validateBio(String? value) {
///   if (value == null || value.isEmpty) {
///     return null; // Bio is optional
///   }
///   if (value.length > 160) {
///     return 'Bio must be less than 160 characters long';
///   }
///   return null;
/// }
/// 
/// /// Validate a post content
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validatePostContent('My post');
/// /// if (error != null) {
/// ///   print('Invalid post content: $error');
/// /// }
/// /// ```
/// String? validatePostContent(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Post content is required';
///   }
///   if (value.length > 500) {
///     return 'Post content must be less than 500 characters long';
///   }
///   return null;
/// }
/// 
/// /// Validate a comment content
/// /// 
/// /// Returns null if valid, error message if invalid
/// /// 
/// /// Example:
/// /// ```dart
/// /// final error = validateCommentContent('My comment');
/// /// if (error != null) {
/// ///   print('Invalid comment content: $error');
/// /// }
/// /// ```
/// String? validateCommentContent(String? value) {
///   if (value == null || value.isEmpty) {
///     return 'Comment content is required';
///   }
///   if (value.length > 200) {
///     return 'Comment content must be less than 200 characters long';
///   }
///   return null;
/// }
/// ``` 