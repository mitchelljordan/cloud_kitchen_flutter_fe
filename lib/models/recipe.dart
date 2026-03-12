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
      recipeId: json["recipe_id"],
      recipeName: json["recipe_name"],
      servings: json["servings"],
      missingCount: json["missing_count"],
      inPantryCount: json["in_pantry_count"],
      ingredients: json["ingredients_breakdown"],
    );
  }
}
