class Recipe {
  final int recipeId;
  final String recipeName;
  final int servings;
  final int missingCount;
  final int inPantryCount;
  final List ingredients;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.servings,
    required this.missingCount,
    required this.inPantryCount,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json["recipe_id"] ?? 0,
      recipeName: json["recipe_name"] ?? "Unknown Recipe",
      servings: json["servings"] ?? 0,
      missingCount: json["missing_count"] ?? 0,
      inPantryCount: json["in_pantry_count"] ?? 0,
      ingredients: json["ingredients_breakdown"] ?? [],
    );
  }
}