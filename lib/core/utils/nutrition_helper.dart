import 'package:cloud_kitchen_flutter_fe/models/ingredient.dart';

class NutritionData {
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double sodium;

  NutritionData({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sodium,
  });

  bool get hasData =>
      calories > 0 || protein > 0 || carbs > 0 || fat > 0 || sodium > 0;
}

class NutritionHelper {
  /// Aggregate nutrients from all ingredients
  static NutritionData aggregateNutrients(List<Ingredient> ingredients) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalSodium = 0;

    for (final ingredient in ingredients) {
      final nutrients = ingredient.nutrients;
      if (nutrients != null) {
        totalCalories += (nutrients["calories"] ?? 0).toDouble();
        totalProtein += (nutrients["protein_g"] ?? 0).toDouble();
        totalCarbs += (nutrients["total_carbs_g"] ?? 0).toDouble();
        totalFat += (nutrients["total_fat_g"] ?? 0).toDouble();
        totalSodium += (nutrients["sodium_mg"] ?? 0).toDouble();
      }
    }

    return NutritionData(
      calories: totalCalories,
      protein: totalProtein,
      carbs: totalCarbs,
      fat: totalFat,
      sodium: totalSodium,
    );
  }

  /// Get calorie color indicator
  static String getCalorieCategory(double calories) {
    if (calories < 300) return "Low";
    if (calories < 600) return "Moderate";
    if (calories < 900) return "High";
    return "Very High";
  }
}
