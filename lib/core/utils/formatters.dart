/// Utility functions for formatting data.
/// This file contains helper functions for formatting various data types.
/// 
/// Example usage:
/// ```dart
/// import 'package:selam_app/core/utils/formatters.dart';
/// 
/// // Format a phone number
/// final String phoneNumber = '+1234567890';
/// final String formattedPhone = formatPhoneNumber(phoneNumber); // Returns '(123) 456-7890'
/// 
/// // Format a date
/// final DateTime date = DateTime.now();
/// final String formattedDate = formatDate(date, 'MM/dd/yyyy'); // Returns '04/18/2023'
/// 
/// // Format a file size
/// final int bytes = 1024 * 1024 * 5; // 5 MB
/// final String formattedSize = formatFileSize(bytes); // Returns '5.0 MB'
/// ```
/// 
/// Implementation:
/// ```dart
/// /// Formats a phone number to a standard format
/// String formatPhoneNumber(String phoneNumber) {
///   // Remove all non-digit characters
///   final digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
///   
///   // Format based on length
///   if (digits.length == 10) {
///     return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
///   } else if (digits.length == 11 && digits[0] == '1') {
///     return '(${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
///   } else {
///     return phoneNumber; // Return original if format is unknown
///   }
/// }
/// 
/// /// Formats a date according to the specified pattern
/// String formatDate(DateTime date, String pattern) {
///   final year = date.year.toString();
///   final month = date.month.toString().padLeft(2, '0');
///   final day = date.day.toString().padLeft(2, '0');
///   final hour = date.hour.toString().padLeft(2, '0');
///   final minute = date.minute.toString().padLeft(2, '0');
///   final second = date.second.toString().padLeft(2, '0');
///   
///   return pattern
///       .replaceAll('yyyy', year)
///       .replaceAll('MM', month)
///       .replaceAll('dd', day)
///       .replaceAll('HH', hour)
///       .replaceAll('mm', minute)
///       .replaceAll('ss', second);
/// }
/// 
/// /// Formats a file size in bytes to a human-readable string
/// String formatFileSize(int bytes) {
///   if (bytes < 1024) return '$bytes B';
///   if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
///   if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
///   return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
/// }
/// 
/// /// Formats a duration in seconds to a human-readable string
/// String formatDuration(int seconds) {
///   final hours = (seconds / 3600).floor();
///   final minutes = ((seconds % 3600) / 60).floor();
///   final remainingSeconds = seconds % 60;
///   
///   if (hours > 0) {
///     return '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
///   } else {
///     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
///   }
/// }
/// ``` 