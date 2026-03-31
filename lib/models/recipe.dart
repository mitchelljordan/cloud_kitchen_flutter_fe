import 'ingredient.dart';

class Recipe {
  final int recipeId;
  final String recipeName;
  final int servings;
  final int missingCount;
  final int inPantryCount;
  final List<Ingredient> ingredients;
  final String? instructions;
  final String? thumbnailUrl;
  bool isFavourite; // Mutable for toggle functionality
  final int? totalIngredients;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.servings,
    required this.missingCount,
    required this.inPantryCount,
    required this.ingredients,
    this.instructions,
    this.thumbnailUrl,
    this.isFavourite = false,
    this.totalIngredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final ingredientsData = json["ingredients_breakdown"] ?? [];
    final List<Ingredient> parsedIngredients = ingredientsData
        .map<Ingredient>((ing) => Ingredient.fromJson(ing))
        .toList();

    return Recipe(
      recipeId: json["recipe_id"] ?? 0,
      recipeName: json["recipe_name"] ?? "Unknown Recipe",
      servings: json["servings"] ?? 0,
      missingCount: json["missing_count"] ?? 0,
      inPantryCount: json["in_pantry_count"] ?? 0,
      ingredients: parsedIngredients,
      instructions: json["instructions"],
      thumbnailUrl: json["thumbnail_url"],
      isFavourite: json["is_favourite"] ?? false,
      totalIngredients: json["total_ingredients"],
    );
  }
}
