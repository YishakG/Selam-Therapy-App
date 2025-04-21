import 'dart:convert';
import 'package:http/http.dart' as http;

/// A client for making HTTP requests to the API.
class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  /// Makes a GET request to the specified endpoint.
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return _handleResponse(response);
  }

  /// Makes a POST request to the specified endpoint.
  Future<dynamic> post(String endpoint, {required Map<String, dynamic> data}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// Makes a PUT request to the specified endpoint.
  Future<dynamic> put(String endpoint, {required Map<String, dynamic> data}) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// Makes a DELETE request to the specified endpoint.
  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
    return _handleResponse(response);
  }

  /// Handles the HTTP response and returns the appropriate data or throws an error.
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
} 