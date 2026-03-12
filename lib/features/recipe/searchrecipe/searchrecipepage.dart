import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/models/recipe.dart';

class SearchRecipePage extends StatelessWidget {
  final List<Recipe> recipes;

  const SearchRecipePage({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {

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

          final totalIngredients =
              recipe.ingredients.length == 0 ? 1 : recipe.ingredients.length;

          final matchPercent =
              ((recipe.inPantryCount / totalIngredients) * 100).round();

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,

            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

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

                      ...recipe.ingredients.map((i) {

                        final status = i["status"] ?? "unknown";

                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,

                          leading: Icon(
                            status == "missing"
                                ? Icons.cancel
                                : Icons.check_circle,
                            color: status == "missing"
                                ? Colors.red
                                : Colors.green,
                          ),

                          title: Text(
                            i["product_name"] ?? "Unknown ingredient",
                          ),

                          subtitle: Text(
                            "${i["amount"] ?? 0} ${i["unit"] ?? ""}",
                          ),

                          trailing: Text(
                            status,
                            style: TextStyle(
                              color: status == "missing"
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
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

