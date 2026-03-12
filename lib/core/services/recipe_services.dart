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
}
