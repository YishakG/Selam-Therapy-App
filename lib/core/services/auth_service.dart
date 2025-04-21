import 'package:selam_app/core/services/local_storage_service.dart';

class AuthService {
  final LocalStorageService _localStorage;

  AuthService(this._localStorage);

  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    // TODO: Implement actual registration logic
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<bool> login(String email, String password) async {
    // TODO: Implement actual login logic
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<void> logout() async {
    await _localStorage.clear();
  }

  bool isAuthenticated() {
    return _localStorage.getToken() != null;
  }
} 