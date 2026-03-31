import 'dart:convert';
import '../network/api_client.dart';

class RecipeService {
  // GET recipes from the user's pantry
  static Future<List<dynamic>> getRecipesFromPantry() async {
    final res = await ApiClient.get("/recipes/bypantry");

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to fetch recipes from pantry');
    }
  }

  // POST recipes by selected ingredient IDs
  static Future<List<dynamic>> getRecipesByIngredients(List<int> ids) async {
    final res = await ApiClient.post("/recipes/byingredients", {
      "ingredient_ids": ids,
    });

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to fetch recipes by ingredients');
    }
  }

  // GET favourite recipes
  static Future<List<dynamic>> getFavouriteRecipes() async {
    final res = await ApiClient.get("/recipes/favourites");

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to fetch favourite recipes');
    }
  }

  // POST add recipe to favourites
  static Future<bool> addFavourite(int recipeId) async {
    final res = await ApiClient.post("/recipes/favourites/$recipeId", {});

    if (res.statusCode == 201 || res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add recipe to favourites');
    }
  }

  // DELETE remove recipe from favourites
  static Future<bool> removeFavourite(int recipeId) async {
    final res = await ApiClient.delete("/recipes/favourites/$recipeId");

    if (res.statusCode == 204 || res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to remove recipe from favourites');
    }
  }
}
