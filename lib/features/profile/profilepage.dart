import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/models/userpreferences.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/preferences_service.dart';
import 'widgets/preference_switch.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PreferencesService service = PreferencesService();

  Preferences? prefs;
  bool loading = true;

  final Map<String, String> preferenceLabels = {
    "nut_free": "Nut Free",
    "dairy_free": "Dairy Free",
    "low_sugar": "Low Sugar",
    "low_carb": "Low Carb",
    "low_sodium": "Low Sodium",
    "low_sat_fat": "Low Saturated Fat",
    "vegetarian": "Vegetarian",
    "vegan": "Vegan",
    "halal": "Halal",
    "kosher": "Kosher",
    "gluten_free": "Gluten Free",
    "soy_free": "Soy Free",
    "egg_free": "Egg Free",
    "shellfish_free": "Shellfish Free",
  };

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final result = await service.getPreferences(1); // replace later
    setState(() {
      prefs = result;
      loading = false;
    });
  }

  void savePreferences() async {
    await service.updatePreferences(1, prefs!);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Preferences updated")));
  }

  @override
  Widget build(BuildContext context) {
    if (loading || prefs == null) {
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

          ExpansionTile(
            title: const Text(
              "Dietary Preferences",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            children: preferenceLabels.entries.map((entry) {
              final key = entry.key;
              final label = entry.value;

              return PreferenceSwitch(
                label: label,
                value: prefs!.values[key] ?? false,
                onChanged: (val) {
                  setState(() {
                    prefs!.values[key] = val;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: savePreferences,
            child: const Text("Save Preferences"),
          ),
        ],
      ),
    );
  }
}
