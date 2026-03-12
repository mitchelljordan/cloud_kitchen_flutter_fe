import 'dart:convert';
import 'package:cloud_kitchen_flutter_fe/core/services/token_storage.dart';
import 'package:cloud_kitchen_flutter_fe/core/network/api_client.dart';

class AuthService {

  /*
  REGISTER
  */
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {

    final response = await ApiClient.post(
      "/auth/register",
      {
        "username": username,
        "email": email,
        "password": password,
      },
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

    final response = await ApiClient.post(
      "/auth/login",
      {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final token = data["access_token"];

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