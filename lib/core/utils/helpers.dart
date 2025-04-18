/// Helper functions used throughout the application.
/// This file contains utility functions that help with common tasks.
/// 
/// Example usage:
/// ```dart
/// import 'package:selam_app/core/utils/helpers.dart';
/// 
/// // Format date
/// final String formattedDate = formatDate(DateTime.now());
/// 
/// // Format file size
/// final String fileSize = formatFileSize(1024 * 1024); // 1MB
/// 
/// // Generate random string
/// final String randomId = generateRandomString(10);
/// ```
/// 
/// Implementation:
/// ```dart
/// import 'dart:math';
/// import 'package:intl/intl.dart';
/// 
/// /// Format a date to a readable string
/// /// 
/// /// Example:
/// /// ```dart
/// /// final date = DateTime.now();
/// /// final formatted = formatDate(date); // "Jan 1, 2024"
/// /// ```
/// String formatDate(DateTime date) {
///   return DateFormat.yMMMd().format(date);
/// }
/// 
/// /// Format a date to include time
/// /// 
/// /// Example:
/// /// ```dart
/// /// final date = DateTime.now();
/// /// final formatted = formatDateTime(date); // "Jan 1, 2024 12:00 PM"
/// /// ```
/// String formatDateTime(DateTime date) {
///   return DateFormat.yMMMd().add_jm().format(date);
/// }
/// 
/// /// Format a number to a readable file size
/// /// 
/// /// Example:
/// /// ```dart
/// /// final size = 1024 * 1024;
/// /// final formatted = formatFileSize(size); // "1.0 MB"
/// /// ```
/// String formatFileSize(int bytes) {
///   if (bytes < 1024) return '$bytes B';
///   if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
///   if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
///   return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
/// }
/// 
/// /// Generate a random string of specified length
/// /// 
/// /// Example:
/// /// ```dart
/// /// final random = generateRandomString(10); // "a1b2c3d4e5"
/// /// ```
/// String generateRandomString(int length) {
///   const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
///   final random = Random();
///   return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
/// }
/// 
/// /// Truncate a string to a specified length
/// /// 
/// /// Example:
/// /// ```dart
/// /// final text = "This is a long text";
/// /// final truncated = truncateString(text, 10); // "This is..."
/// /// ```
/// String truncateString(String text, int maxLength) {
///   if (text.length <= maxLength) return text;
///   return '${text.substring(0, maxLength)}...';
/// }
/// 
/// /// Format a phone number to a readable format
/// /// 
/// /// Example:
/// /// ```dart
/// /// final phone = "251911234567";
/// /// final formatted = formatPhoneNumber(phone); // "+251 91 123 4567"
/// /// ```
/// String formatPhoneNumber(String phone) {
///   if (phone.length != 12) return phone;
///   return '+${phone.substring(0, 3)} ${phone.substring(3, 5)} ${phone.substring(5, 8)} ${phone.substring(8)}';
/// }
/// 
/// /// Get time ago string from a date
/// /// 
/// /// Example:
/// /// ```dart
/// /// final date = DateTime.now().subtract(Duration(hours: 2));
/// /// final timeAgo = getTimeAgo(date); // "2 hours ago"
/// /// ```
/// String getTimeAgo(DateTime date) {
///   final now = DateTime.now();
///   final difference = now.difference(date);
///   
///   if (difference.inDays > 365) {
///     return '${(difference.inDays / 365).floor()} years ago';
///   } else if (difference.inDays > 30) {
///     return '${(difference.inDays / 30).floor()} months ago';
///   } else if (difference.inDays > 0) {
///     return '${difference.inDays} days ago';
///   } else if (difference.inHours > 0) {
///     return '${difference.inHours} hours ago';
///   } else if (difference.inMinutes > 0) {
///     return '${difference.inMinutes} minutes ago';
///   } else {
///     return 'Just now';
///   }
/// }
/// 
/// /// Check if a string is a valid URL
/// /// 
/// /// Example:
/// /// ```dart
/// /// final url = "https://example.com";
/// /// final isValid = isValidUrl(url); // true
/// /// ```
/// bool isValidUrl(String url) {
///   try {
///     final uri = Uri.parse(url);
///     return uri.hasScheme && uri.hasAuthority;
///   } catch (e) {
///     return false;
///   }
/// }
/// 
/// /// Get initials from a name
/// /// 
/// /// Example:
/// /// ```dart
/// /// final name = "John Doe";
/// /// final initials = getInitials(name); // "JD"
/// /// ```
/// String getInitials(String name) {
///   final names = name.split(' ');
///   if (names.length == 1) return names[0][0].toUpperCase();
///   return names.map((n) => n[0].toUpperCase()).join();
/// }
/// 
/// /// Format a number with commas
/// /// 
/// /// Example:
/// /// ```dart
/// /// final number = 1000000;
/// /// final formatted = formatNumber(number); // "1,000,000"
/// /// ```
/// String formatNumber(int number) {
///   return NumberFormat('#,###').format(number);
/// }
/// 
/// /// Format a number to K/M/B format
/// /// 
/// /// Example:
/// /// ```dart
/// /// final number = 1500;
/// /// final formatted = formatCompactNumber(number); // "1.5K"
/// /// ```
/// String formatCompactNumber(int number) {
///   if (number < 1000) return number.toString();
///   if (number < 1000000) return '${(number / 1000).toStringAsFixed(1)}K';
///   if (number < 1000000000) return '${(number / 1000000).toStringAsFixed(1)}M';
///   return '${(number / 1000000000).toStringAsFixed(1)}B';
/// }
/// ``` 