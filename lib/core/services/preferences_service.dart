import 'dart:convert';
import 'package:cloud_kitchen_flutter_fe/core/network/api_client.dart';

class PreferencesService {
  Future<Map<String, dynamic>> getPreferences(int userId) async {
    final response = await ApiClient.get("/auth/users/$userId/preferences");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load preferences");
  }

  Future<void> updatePreferences(int userId, Map prefs) async {
    final response = await ApiClient.put(
      "/auth/users/$userId/preferences",
      prefs,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update preferences");
    }
  }
}
