import 'package:flutter/material.dart';
import '../../../models/pantry_item.dart';

class PantryList extends StatelessWidget {
  final List<PantryItem> items;
  final Function(String) onDelete;
  final Function(String) onSelect;
  final Set<String> selectedIds;

  const PantryList({
    super.key,
    required this.items,
    required this.onDelete,
    required this.onSelect,
    required this.selectedIds,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final selected = selectedIds.contains(item.id);

        return ListTile(
          tileColor: selected ? Colors.lightBlue.withOpacity(0.2) : null,

          title: Text(item.name),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(selected ? Icons.check_box : Icons.check_box_outline_blank),

              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(item.id),
              ),
            ],
          ),

          onTap: () => onSelect(item.id),
        );
      },
    );
  }
}
