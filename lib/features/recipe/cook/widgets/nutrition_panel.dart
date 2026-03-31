import 'package:flutter/material.dart';
import '../../../../core/utils/nutrition_helper.dart';
import 'package:cloud_kitchen_flutter_fe/models/ingredient.dart';

class NutritionPanel extends StatelessWidget {
  final List<Ingredient> ingredients;

  const NutritionPanel({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final nutrition = NutritionHelper.aggregateNutrients(ingredients);

    if (!nutrition.hasData) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            "No nutrition data available for these ingredients",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nutrition Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Main nutrition grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _NutritionCard(
                  label: "Calories",
                  value: nutrition.calories.toStringAsFixed(1),
                  unit: "kCal",
                  color: Colors.orange,
                  icon: Icons.local_fire_department,
                ),
                _NutritionCard(
                  label: "Protein",
                  value: nutrition.protein.toStringAsFixed(1),
                  unit: "g",
                  color: Colors.blue,
                  icon: Icons.fitness_center,
                ),
                _NutritionCard(
                  label: "Carbs",
                  value: nutrition.carbs.toStringAsFixed(1),
                  unit: "g",
                  color: Colors.amber,
                  icon: Icons.grain,
                ),
                _NutritionCard(
                  label: "Fat",
                  value: nutrition.fat.toStringAsFixed(1),
                  unit: "g",
                  color: Colors.red,
                  icon: Icons.opacity,
                ),
                _NutritionCard(
                  label: "Sodium",
                  value: nutrition.sodium.toStringAsFixed(0),
                  unit: "mg",
                  color: Colors.teal,
                  icon: Icons.water_drop,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NutritionCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;
  final IconData icon;

  const _NutritionCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  TextSpan(
                    text: " $unit",
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
