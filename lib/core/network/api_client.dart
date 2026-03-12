import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/token_storage.dart';

class ApiClient {
  static const baseUrl = "http://10.0.2.2:8000";

  static Future<http.Response> get(String endpoint) async {
    final token = await TokenStorage.getToken();

    return http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  static Future<http.Response> post(String endpoint, Map body) async {
    final token = await TokenStorage.getToken();

    return http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> delete(String endpoint) async {
    final token = await TokenStorage.getToken();

    return http.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }
}
