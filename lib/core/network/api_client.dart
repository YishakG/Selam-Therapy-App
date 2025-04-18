/// Base API client for handling HTTP requests.
/// This class will be responsible for making HTTP requests and handling responses.
/// Example usage:
/// ```dart
/// class ApiClient {
///   final Dio _dio;
///   
///   ApiClient() {
///     _dio = Dio(BaseOptions(
///       baseUrl: AppConstants.baseUrl,
///       connectTimeout: const Duration(seconds: 30),
///       receiveTimeout: const Duration(seconds: 30),
///     ));
///   }
///   
///   Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
///     try {
///       final response = await _dio.get(path, queryParameters: queryParameters);
///       return response;
///     } catch (e) {
///       throw ApiException(message: e.toString());
///     }
///   }
///   
///   // Similar methods for post, put, delete, etc.
/// }
/// ``` 