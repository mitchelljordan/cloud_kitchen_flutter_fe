import 'package:flutter/material.dart';
import '../../../models/pantry_item.dart';
import 'expiry_utils.dart';

class PantryItemTile extends StatelessWidget {
  final PantryItem item;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const PantryItemTile({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final expiryStatus = ExpiryUtils.getExpiryStatus(item.expiryDate);
    final expiryColor = ExpiryUtils.getExpiryColor(expiryStatus);
    final expiryLabel = ExpiryUtils.getExpiryLabel(item.expiryDate);

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        margin: const EdgeInsets.symmetric(vertical: 8),

        child: ListTile(
          title: Text(
            item.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                '${item.quantity} ${item.unit}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: expiryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: expiryColor, width: 1),
                ),
                child: Text(
                  expiryLabel,
                  style: TextStyle(
                    fontSize: 14,
                    color: expiryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
