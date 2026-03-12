import 'dart:convert';
import 'package:cloud_kitchen_flutter_fe/core/network/api_client.dart';
import 'package:cloud_kitchen_flutter_fe/models/userpreferences.dart';

class PreferencesService {
  Future<Preferences> getPreferences(int userId) async {
    final response = await ApiClient.get("/auth/users/$userId/preferences");

    if (response.statusCode == 200) {
      return Preferences.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load preferences");
  }

  Future<void> updatePreferences(int userId, Preferences prefs) async {
    await ApiClient.put("/auth/users/$userId/preferences", prefs.toJson());
  }
}
