import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/pantry_service.dart';
import '../../models/pantry_item.dart';
import 'widgets/pantry_list.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {

  List<PantryItem> items = [];
  bool loading = true;

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
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Pantry")),

      body: PantryList(
        items: items,
        onDelete: deleteItem,
      ),
    );
  }
}