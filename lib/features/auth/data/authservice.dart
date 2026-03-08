import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_kitchen_flutter_fe/core/services/token_storage.dart';

class AuthService {
  static const String baseUrl = "http://10.0.2.2:8000";

  /*
  REGISTER
  */
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Register failed: ${response.body}");
    }
  }

  /* 
  LOGIN
  */
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final token = data["access_token"];

      print("TOKEN SAVED: $token");

      await TokenStorage.saveToken(token);

      return data;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  /*
  LOGOUT
  */
  Future<void> logout() async {
    await TokenStorage.deleteToken();
  }
}
