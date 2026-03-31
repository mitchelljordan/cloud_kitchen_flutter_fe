import 'package:flutter/material.dart';
import '../../../models/recipe.dart';
import '../../../models/pantry_item.dart';
import '../../../core/services/recipe_services.dart';
import '../../../core/services/pantry_service.dart';
import 'widgets/ingredient_row.dart';
import 'widgets/nutrition_panel.dart';

class CookPage extends StatefulWidget {
  final Recipe recipe;

  const CookPage({super.key, required this.recipe});

  @override
  State<CookPage> createState() => _CookPageState();
}

class _CookPageState extends State<CookPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<PantryItem> pantryItems = [];
  bool loading = true;
  bool cooking = false;
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    isFavourite = widget.recipe.isFavourite;
    loadPantry();
    updateIngredientStatus();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadPantry() async {
    try {
      final data = await PantryService.getUserPantry();
      setState(() {
        pantryItems = data.map((e) => PantryItem.fromJson(e)).toList();
      });
      updateIngredientStatus();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error loading pantry: $e")));
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  void updateIngredientStatus() {
    for (final ingredient in widget.recipe.ingredients) {
      PantryItem? pantryItem;
      try {
        pantryItem = pantryItems.firstWhere(
          (item) => item.productId == ingredient.productId,
        );
      } catch (e) {
        pantryItem = null;
      }

      if (pantryItem == null) {
        ingredient.status = "missing";
        ingredient.pantryQuantity = 0;
      } else if (pantryItem.quantity < ingredient.amount) {
        ingredient.status = "insufficient";
        ingredient.pantryQuantity = pantryItem.quantity;
      } else {
        ingredient.status = "sufficient";
        ingredient.pantryQuantity = pantryItem.quantity;
      }
    }
  }

  Future<void> toggleFavourite() async {
    try {
      if (isFavourite) {
        await RecipeService.removeFavourite(widget.recipe.recipeId);
      } else {
        await RecipeService.addFavourite(widget.recipe.recipeId);
      }
      setState(() => isFavourite = !isFavourite);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFavourite ? "Added to favourites" : "Removed from favourites",
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> cookRecipe() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cook Recipe?"),
        content: Text(
          "This will deduct ${widget.recipe.ingredients.length} ingredient(s) from your pantry.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Cook"),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => cooking = true);

    try {
      for (final ingredient in widget.recipe.ingredients) {
        PantryItem? pantryItem;
        try {
          pantryItem = pantryItems.firstWhere(
            (item) => item.productId == ingredient.productId,
          );
        } catch (e) {
          pantryItem = null;
        }

        if (pantryItem != null) {
          final newQuantity = pantryItem.quantity - ingredient.amount;

          if (newQuantity <= 0) {
            await PantryService.deletePantryItem(int.parse(pantryItem.id));
          } else {
            // For cooking, we keep the expiry date as-is
            // We only update quantity
            await PantryService.updatePantryItem(
              pantryId: int.parse(pantryItem.id),
              quantity: newQuantity,
              expiryDate: pantryItem.expiryDate,
            );
          }
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Recipe cooked! Pantry updated.")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error cooking recipe: $e")));
      }
    } finally {
      if (mounted) {
        setState(() => cooking = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.recipeName),
        actions: [
          IconButton(
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: isFavourite ? Colors.red : null,
            ),
            onPressed: toggleFavourite,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Ingredients"),
            Tab(text: "Nutrition"),
            Tab(text: "Instructions"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ingredients tab
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Servings: ${widget.recipe.servings}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "${widget.recipe.ingredients.length} ingredients",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...widget.recipe.ingredients
                      .map((ing) => IngredientRow(ingredient: ing))
                      .toList(),
                ],
              ),
            ),
          ),
          // Nutrition tab
          NutritionPanel(ingredients: widget.recipe.ingredients),
          // Instructions tab
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child:
                  widget.recipe.instructions != null &&
                      widget.recipe.instructions!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instructions",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.recipe.instructions!,
                          style: const TextStyle(fontSize: 15, height: 1.6),
                        ),
                      ],
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          "No instructions available",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: cooking ? null : cookRecipe,
        icon: cooking
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Icon(Icons.restaurant_menu),
        label: Text(cooking ? "Cooking..." : "Cook Recipe"),
      ),
    );
  }
}
