import 'package:flutter/material.dart';
import '../../../models/pantry_item.dart';

class PantryItemEditDialog extends StatefulWidget {
  final PantryItem item;
  final Future<bool> Function(double quantity, String expiryDate) onUpdate;

  const PantryItemEditDialog({
    super.key,
    required this.item,
    required this.onUpdate,
  });

  @override
  State<PantryItemEditDialog> createState() => _PantryItemEditDialogState();
}

class _PantryItemEditDialogState extends State<PantryItemEditDialog> {
  late TextEditingController quantityController;
  late DateTime selectedDate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController(
      text: widget.item.quantity.toString(),
    );
    selectedDate = DateTime.parse(widget.item.expiryDate);
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _handleUpdate() async {
    final quantityStr = quantityController.text.trim();

    if (quantityStr.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Quantity cannot be empty")));
      return;
    }

    final quantity = double.tryParse(quantityStr);
    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Quantity must be a positive number")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final expiryDateStr = selectedDate.toIso8601String().split('T')[0];
      final success = await widget.onUpdate(quantity, expiryDateStr);

      if (!mounted) return;

      if (success) {
        Navigator.of(
          context,
        ).pop(true); // Return true to indicate update success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update pantry item")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit ${widget.item.name}"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quantity",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: quantityController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: "Enter quantity",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixText: widget.item.unit,
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 20),
            const Text(
              "Expiry Date",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: isLoading ? null : () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: isLoading ? null : _handleUpdate,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Update"),
        ),
      ],
    );
  }
}
