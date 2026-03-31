import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/recipe.dart';
import '../../../core/services/recipe_services.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<Recipe> favourites = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    try {
      final data = await RecipeService.getFavouriteRecipes();
      setState(() {
        favourites = data.map((e) => Recipe.fromJson(e)).toList();
        loading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error loading favourites: $e")));
        setState(() => loading = false);
      }
    }
  }

  Future<void> removeFavourite(int recipeId) async {
    try {
      await RecipeService.removeFavourite(recipeId);
      setState(() {
        favourites.removeWhere((recipe) => recipe.recipeId == recipeId);
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Removed from favourites")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (favourites.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Favourite Recipes")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                "No favourite recipes yet",
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.push('/recipe'),
                child: const Text("Search Recipes"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Favourite Recipes")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          final recipe = favourites[index];
          final matchPercent =
              recipe.totalIngredients != null && recipe.totalIngredients! > 0
              ? ((recipe.inPantryCount / recipe.totalIngredients!) * 100)
                    .toStringAsFixed(0)
              : "0";
          final matchColor = double.parse(matchPercent) == 100.0
              ? Colors.green
              : Colors.orange;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ExpansionTile(
              title: Text(
                recipe.recipeName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: matchColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Match: $matchPercent%",
                      style: TextStyle(
                        color: matchColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => removeFavourite(recipe.recipeId),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Servings: ${recipe.servings} | Pantry: ${recipe.inPantryCount} • Missing: ${recipe.missingCount}",
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Ingredients:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...recipe.ingredients.map((ing) {
                        final icon = ing.status == "missing" ? "✗" : "✓";
                        final color = ing.status == "missing"
                            ? Colors.red
                            : Colors.green;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "$icon ${ing.productName} - ${ing.amount} ${ing.unit}",
                            style: TextStyle(fontSize: 12, color: color),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () =>
                                context.push('/cookpage', extra: recipe),
                            icon: const Icon(Icons.restaurant_menu),
                            label: const Text("Cook"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
