/// Authentication service for handling user authentication operations.
/// This service will manage user login, logout, token management, and authentication state.
/// Example usage:
/// ```dart
/// class AuthService {
///   final ApiClient _apiClient;
///   final StorageService _storageService;
/// 
///   AuthService(this._apiClient, this._storageService);
/// 
///   Future<UserModel> login(String email, String password) async {
///     try {
///       final response = await _apiClient.post(
///         '/auth/login',
///         data: {'email': email, 'password': password},
///       );
///       
///       final user = UserModel.fromJson(response.data);
///       await _storageService.saveToken(user.token);
///       return user;
///     } catch (e) {
///       throw AuthException(message: 'Login failed: ${e.toString()}');
///     }
///   }
/// 
///   Future<void> logout() async {
///     await _storageService.deleteToken();
///     // Additional cleanup if needed
///   }
/// 
///   Future<bool> isAuthenticated() async {
///     final token = await _storageService.getToken();
///     return token != null;
///   }
/// }
/// ``` 