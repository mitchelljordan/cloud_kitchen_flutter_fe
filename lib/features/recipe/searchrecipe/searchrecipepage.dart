import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/models/recipe.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/recipe_services.dart';
import 'package:go_router/go_router.dart';

class SearchRecipePage extends StatefulWidget {
  final List<Recipe>? recipes;

  const SearchRecipePage({super.key, this.recipes});

  @override
  State<SearchRecipePage> createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  List<Recipe> recipes = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    // If recipes were passed from ingredient search
    if (widget.recipes != null) {
      recipes = widget.recipes!;
      setState(() {
        loading = false;
      });
      return;
    }

    // Otherwise load pantry recipes
    try {
      final data = await RecipeService.getRecipesFromPantry();

      recipes = data.map<Recipe>((e) => Recipe.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Recipe load error: $e");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (recipes.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Recipes")),
        body: const Center(
          child: Text(
            "No recipes found with these ingredients",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Recipes")),

      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: recipes.length,

        itemBuilder: (context, index) {
          final recipe = recipes[index];

          final totalIngredients = recipe.ingredients.isEmpty
              ? 1
              : recipe.ingredients.length;

          final matchPercent = ((recipe.inPantryCount / totalIngredients) * 100)
              .round();

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,

            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),

              title: Text(
                recipe.recipeName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pantry Match: $matchPercent%",
                      style: TextStyle(
                        color: matchPercent == 100
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      "Pantry: ${recipe.inPantryCount}  •  Missing: ${recipe.missingCount}",
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),

              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text("Cook Recipe"),
                    onTap: () => context.push('/cookpage', extra: recipe),
                  ),
                ],
              ),

              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Servings: ${recipe.servings}",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 8),

                      ...recipe.ingredients.map((ing) {
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,

                          leading: Icon(
                            ing.status == "missing"
                                ? Icons.cancel
                                : Icons.check_circle,
                            color: ing.status == "missing"
                                ? Colors.red
                                : Colors.green,
                          ),

                          title: Text(ing.productName),

                          subtitle: Text("${ing.amount} ${ing.unit}"),

                          trailing: Text(
                            ing.status,
                            style: TextStyle(
                              color: ing.status == "missing"
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () =>
                                context.push('/cookpage', extra: recipe),
                            icon: const Icon(Icons.restaurant_menu),
                            label: const Text("Cook"),
                          ),
                          IconButton(
                            icon: Icon(
                              recipe.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: recipe.isFavourite
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () async {
                              try {
                                if (recipe.isFavourite) {
                                  await RecipeService.removeFavourite(
                                    recipe.recipeId,
                                  );
                                } else {
                                  await RecipeService.addFavourite(
                                    recipe.recipeId,
                                  );
                                }
                                setState(() {
                                  recipe.isFavourite = !recipe.isFavourite;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: $e")),
                                );
                              }
                            },
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
