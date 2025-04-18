/// Custom exception class for API-related errors.
/// This class will be used to handle various API errors in a structured way.
/// Example usage:
/// ```dart
/// class ApiException implements Exception {
///   final String message;
///   final int? statusCode;
///   final dynamic error;
/// 
///   ApiException({
///     required this.message,
///     this.statusCode,
///     this.error,
///   });
/// 
///   @override
///   String toString() => 'ApiException: $message (Status Code: $statusCode)';
/// }
/// 
/// // Usage example:
/// throw ApiException(
///   message: 'Failed to fetch user data',
///   statusCode: 404,
///   error: response.data,
/// );
/// ``` 