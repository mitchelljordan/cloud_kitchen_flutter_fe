import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/pantry_service.dart';
import '../../models/pantry_item.dart';
import 'widgets/pantry_list.dart';
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
    List<int> ids;

    if (selectedIds.isEmpty) {
      ids = items.map((e) => int.parse(e.id)).toList();
    } else {
      ids = selectedIds.map((e) => int.parse(e)).toList();
    }

    try {
      final data = selectedIds.isEmpty
          ? await RecipeService.getRecipesFromPantry()
          : await RecipeService.getRecipesByIngredients(ids);

      final recipes = data.map<Recipe>((e) => Recipe.fromJson(e)).toList();

      if (!mounted) return;

      GoRouter.of(context).push('/searchrecipes', extra: recipes);
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to load recipes")));
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
