import 'package:flutter/material.dart';
import '../../../models/pantry_item.dart';
import 'pantry_item_tile.dart';

class PantryList extends StatelessWidget {
  final List<PantryItem> items;
  final Function(String) onDelete;
  final Function(String) onEdit;
  final Function(String) onSelect;
  final Set<String> selectedIds;

  const PantryList({
    super.key,
    required this.items,
    required this.onDelete,
    required this.onEdit,
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

        return GestureDetector(
          onTap: () => onSelect(item.id),
          child: Stack(
            children: [
              PantryItemTile(
                item: item,
                onDelete: () => onDelete(item.id),
                onEdit: () => onEdit(item.id),
              ),
              if (selected)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
