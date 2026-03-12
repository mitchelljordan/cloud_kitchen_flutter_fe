import 'package:flutter/material.dart';
import '../../../models/pantry_item.dart';

class PantryItemTile extends StatelessWidget {

  final PantryItem item;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const PantryItemTile({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),

      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        margin: const EdgeInsets.symmetric(vertical: 8),

        child: ListTile(
          title: Text(
            item.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          subtitle: Text(
            '${item.quantity} ${item.unit}',
            style: const TextStyle(fontSize: 16),
          ),

          trailing: const Icon(Icons.edit),
          onTap: onTap,
        ),
      ),
    );
  }
}