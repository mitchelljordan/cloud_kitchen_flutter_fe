import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/pantry_service.dart';
import '../../models/pantry_item.dart';
import 'widgets/pantry_list.dart';
import 'widgets/pantry_item_edit_dialog.dart';
import '../../core/services/recipe_services.dart';
import '../../models/recipe.dart';
import 'package:go_router/go_router.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  List<PantryItem> items = [];
  bool loading = true;

  Set<String> selectedIds = {};

  @override
  void initState() {
    super.initState();
    loadPantry();
  }

  Future<void> loadPantry() async {
    try {
      final data = await PantryService.getUserPantry();

      setState(() {
        items = data.map((e) => PantryItem.fromJson(e)).toList();
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteItem(String id) async {
    await PantryService.deletePantryItem(int.parse(id));

    setState(() {
      items.removeWhere((item) => item.id == id);
      selectedIds.remove(id);
    });
  }

  void editItem(String id) {
    final item = items.firstWhere((item) => item.id == id);

    showDialog(
      context: context,
      builder: (context) => PantryItemEditDialog(
        item: item,
        onUpdate: (quantity, expiryDate) async {
          try {
            final success = await PantryService.updatePantryItem(
              pantryId: int.parse(id),
              quantity: quantity,
              expiryDate: expiryDate,
            );

            if (success && mounted) {
              // Refresh the pantry list
              await loadPantry();
              // Clear selection after update
              setState(() {
                selectedIds.remove(id);
              });
            }

            return success;
          } catch (e) {
            print("Error updating pantry item: $e");
            return false;
          }
        },
      ),
    );
  }

  void toggleSelection(String id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }

  Future<void> generateRecipe() async {
    // If nothing selected → just open search page
    if (selectedIds.isEmpty) {
      GoRouter.of(context).push('/searchrecipes');
      return;
    }

    // Otherwise search by selected ingredients
    final ids = items
        .where((item) => selectedIds.contains(item.id))
        .map((item) => item.productId)
        .toSet()
        .toList();

    print("Selected pantry rows: $selectedIds");
    print("Sending product IDs: $ids");

    try {
      final data = await RecipeService.getRecipesByIngredients(ids);

      final recipes = data.map<Recipe>((e) => Recipe.fromJson(e)).toList();

      if (!mounted) return;

      if (recipes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No recipes found for these ingredients"),
          ),
        );
        return;
      }

      GoRouter.of(context).push('/searchrecipes', extra: recipes);
    } catch (e, stack) {
      print("RECIPE ERROR:");
      print(e);
      print(stack);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Recipe error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Pantry")),

      body: PantryList(
        items: items,
        onDelete: deleteItem,
        onEdit: editItem,
        onSelect: toggleSelection,
        selectedIds: selectedIds,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: generateRecipe,
        child: const Icon(Icons.restaurant_menu),
      ),
    );
  }
}
