import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/pantry_service.dart';

class AddPantryItemPage extends StatefulWidget {
  const AddPantryItemPage({super.key});

  @override
  State<AddPantryItemPage> createState() => _AddPantryItemPageState();
}

class _AddPantryItemPageState extends State<AddPantryItemPage> {
  final _formKey = GlobalKey<FormState>();

  final productIdController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final expiryDateController = TextEditingController();
  final purchaseDateController = TextEditingController();
  final notesController = TextEditingController();

  bool sharedWithHousehold = false;
  bool loading = false;

  Future<void> submitPantryItem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    bool success = await PantryService.addPantryItem(
      productId: int.parse(productIdController.text),
      quantity: double.parse(quantityController.text),
      unit: unitController.text,
      expiryDate: expiryDateController.text,
      purchaseDate: purchaseDateController.text,
      notes: notesController.text,
      sharedWithHousehold: sharedWithHousehold,
    );

    setState(() => loading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pantry item added")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error adding pantry item")),
      );
    }
  }

  Widget buildField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    productIdController.dispose();
    quantityController.dispose();
    unitController.dispose();
    expiryDateController.dispose();
    purchaseDateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Pantry Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              buildField(
                "Product ID",
                productIdController,
                type: TextInputType.number,
              ),

              buildField(
                "Quantity",
                quantityController,
                type: TextInputType.number,
              ),

              buildField("Unit", unitController),

              buildField(
                "Expiry Date (YYYY-MM-DD)",
                expiryDateController,
              ),

              buildField(
                "Purchase Date (YYYY-MM-DD)",
                purchaseDateController,
              ),

              buildField("Notes", notesController),

              const SizedBox(height: 10),

              SwitchListTile(
                title: const Text("Shared With Household"),
                value: sharedWithHousehold,
                onChanged: (value) {
                  setState(() {
                    sharedWithHousehold = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: loading ? null : submitPantryItem,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Add To Pantry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}