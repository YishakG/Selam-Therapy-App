/// Utility extensions for common Dart types.
/// This file contains extension methods that add functionality to built-in Dart types.
/// 
/// Example usage:
/// ```dart
/// import 'package:selam_app/core/utils/extensions.dart';
/// 
/// // String extensions
/// final String name = 'John Doe';
/// final String initials = name.getInitials(); // Returns 'JD'
/// 
/// // DateTime extensions
/// final DateTime now = DateTime.now();
/// final String formattedDate = now.toFormattedString(); // Returns '2023-04-18'
/// 
/// // Number extensions
/// final double price = 99.99;
/// final String formattedPrice = price.toCurrency(); // Returns '$99.99'
/// ```
/// 
/// Implementation:
/// ```dart
/// extension StringExtensions on String {
///   /// Returns the initials of a name (e.g., "John Doe" -> "JD")
///   String getInitials() {
///     if (isEmpty) return '';
///     final parts = trim().split(' ');
///     if (parts.length == 1) return parts[0][0].toUpperCase();
///     return parts.map((part) => part[0].toUpperCase()).join();
///   }
/// 
///   /// Capitalizes the first letter of each word
///   String toTitleCase() {
///     if (isEmpty) return self;
///     return split(' ').map((word) {
///       if (word.isEmpty) return word;
///       return word[0].toUpperCase() + word.substring(1).toLowerCase();
///     }).join(' ');
///   }
/// }
/// 
/// extension DateTimeExtensions on DateTime {
///   /// Formats the date as 'YYYY-MM-DD'
///   String toFormattedString() {
///     return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
///   }
/// 
///   /// Returns a relative time string (e.g., "2 hours ago")
///   String toRelativeTime() {
///     final now = DateTime.now();
///     final difference = now.difference(this);
/// 
///     if (difference.inDays > 365) {
///       return '${(difference.inDays / 365).floor()} years ago';
///     } else if (difference.inDays > 30) {
///       return '${(difference.inDays / 30).floor()} months ago';
///     } else if (difference.inDays > 0) {
///       return '${difference.inDays} days ago';
///     } else if (difference.inHours > 0) {
///       return '${difference.inHours} hours ago';
///     } else if (difference.inMinutes > 0) {
///       return '${difference.inMinutes} minutes ago';
///     } else {
///       return 'Just now';
///     }
///   }
/// }
/// 
/// extension NumberExtensions on num {
///   /// Formats the number as currency
///   String toCurrency({String symbol = '\$'}) {
///     return '$symbol${toStringAsFixed(2)}';
///   }
/// 
///   /// Formats the number with commas for thousands
///   String withCommas() {
///     return toString().replaceAllMapped(
///       RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
///       (Match m) => '${m[1]},',
///     );
///   }
/// }
/// ``` 