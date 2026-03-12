import 'package:flutter/material.dart';
import '../../../models/pantry_item.dart';
import 'pantry_item_tile.dart';

class PantryList extends StatelessWidget {

  final List<PantryItem> items;
  final Function(String id) onDelete;

  const PantryList({
    super.key,
    required this.items,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    if (items.isEmpty) {
      return const Center(
        child: Text("Pantry is empty"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {

        final item = items[index];

        return PantryItemTile(
          item: item,
          onDelete: () => onDelete(item.id),
          onTap: () {},
        );
      },
    );
  }
}