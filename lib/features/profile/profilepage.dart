import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/core/network/api_client.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> prefs = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final response = await ApiClient.get(
      "/auth/users/1/preferences",
    ); // replace with real userId

    if (response.statusCode == 200) {
      setState(() {
        prefs = jsonDecode(response.body);
        loading = false;
      });
    }
  }

  Widget preferenceSwitch(String label, String key) {
    return SwitchListTile(
      title: Text(label),
      value: prefs[key] ?? false,
      onChanged: (value) {
        setState(() {
          prefs[key] = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Profile",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// DROPDOWN SECTION
          ExpansionTile(
            title: const Text(
              "Dietary Preferences",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            children: [
              preferenceSwitch("Nut Free", "nut_free"),
              preferenceSwitch("Dairy Free", "dairy_free"),
              preferenceSwitch("Low Sugar", "low_sugar"),
              preferenceSwitch("Low Carb", "low_carb"),
              preferenceSwitch("Low Sodium", "low_sodium"),
              preferenceSwitch("Low Saturated Fat", "low_sat_fat"),
              preferenceSwitch("Vegetarian", "vegetarian"),
              preferenceSwitch("Vegan", "vegan"),
              preferenceSwitch("Halal", "halal"),
              preferenceSwitch("Kosher", "kosher"),
              preferenceSwitch("Gluten Free", "gluten_free"),
              preferenceSwitch("Soy Free", "soy_free"),
              preferenceSwitch("Egg Free", "egg_free"),
              preferenceSwitch("Shellfish Free", "shellfish_free"),
            ],
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              await ApiClient.put(
                "/auth/users/1/preferences", // replace with real userId
                prefs,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Preferences updated")),
              );
            },
            child: const Text("Save Preferences"),
          ),
        ],
      ),
    );
  }
}
