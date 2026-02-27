import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pantry_controller.dart';
import 'pantry_list.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  final controller = PantryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pantry'),
      ),
      body: controller.items.isEmpty
          ? const Center(
              child: Text('Your pantry is empty.'),
            )
          : PantryList(
              items: controller.items,
              onDelete: (id) {
                setState(() {
                  controller.deleteItem(id);
                });
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/scan'),
        child: const Icon(Icons.add),
      ),
    );
  }
}