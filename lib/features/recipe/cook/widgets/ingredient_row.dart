import 'package:flutter/material.dart';
import '../../../../models/ingredient.dart';

class IngredientRow extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientRow({super.key, required this.ingredient});

  Color getStatusColor() {
    switch (ingredient.status) {
      case "missing":
        return Colors.red;
      case "insufficient":
        return Colors.amber;
      default:
        return Colors.green;
    }
  }

  String getStatusLabel() {
    switch (ingredient.status) {
      case "missing":
        return "Missing";
      case "insufficient":
        return "Insufficient";
      default:
        return "Available";
    }
  }

  String getDeficitText() {
    if (ingredient.status == "insufficient" &&
        ingredient.pantryQuantity != null) {
      final deficit = ingredient.amount - ingredient.pantryQuantity!;
      return "Need ${deficit.toStringAsFixed(1)}${ingredient.unit} more";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor();
    final statusLabel = getStatusLabel();
    final deficitText = getDeficitText();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
        ),
        title: Text(
          ingredient.productName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "Need: ${ingredient.amount.toStringAsFixed(1)} ${ingredient.unit}",
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(width: 12),
                if (ingredient.pantryQuantity != null)
                  Text(
                    "Have: ${ingredient.pantryQuantity!.toStringAsFixed(1)} ${ingredient.unit}",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
              ],
            ),
            if (deficitText.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                deficitText,
                style: TextStyle(fontSize: 12, color: Colors.amber.shade700),
              ),
            ],
          ],
        ),
        trailing: Chip(
          label: Text(
            statusLabel,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          backgroundColor: statusColor.withOpacity(0.15),
          side: BorderSide(color: statusColor),
        ),
        isThreeLine: true,
      ),
    );
  }
}
