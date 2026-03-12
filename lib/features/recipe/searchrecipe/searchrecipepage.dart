import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/models/recipe.dart';

class SearchRecipePage extends StatelessWidget {
  final List<Recipe> recipes;

  const SearchRecipePage({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipes")),

      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];

          return Card(
            margin: const EdgeInsets.all(10),

            child: ExpansionTile(
              title: Text(
                recipe.recipeName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Text(
                "Missing: ${recipe.missingCount} | Pantry: ${recipe.inPantryCount}",
              ),

              children: [
                Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Servings: ${recipe.servings}"),

                      const SizedBox(height: 10),

                      const Text(
                        "Ingredients",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 8),

                      ...recipe.ingredients.map((i) {
                        return ListTile(
                          dense: true,

                          title: Text(i["product_name"]),

                          subtitle: Text("${i["amount"]} ${i["unit"]}"),

                          trailing: Text(
                            i["status"],
                            style: TextStyle(
                              color: i["status"] == "missing"
                                  ? Colors.red
                                  : Colors.green,
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
