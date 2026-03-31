import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/pantry_service.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/product_service.dart';

class AddPantryItemPage extends StatefulWidget {
  const AddPantryItemPage({super.key});

  @override
  State<AddPantryItemPage> createState() => _AddPantryItemPageState();
}

class _AddPantryItemPageState extends State<AddPantryItemPage> {
  final _formKey = GlobalKey<FormState>();

  final barcodeController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final notesController = TextEditingController();

  DateTime? selectedExpiryDate;
  DateTime? selectedPurchaseDate;

  int? productId;
  String? selectedProductName;
  String? selectedProductBrand;
  bool sharedWithHousehold = false;
  bool loading = false;
  bool productFound = false;

  Future<void> searchProduct() async {
    if (barcodeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a barcode")));
      return;
    }

    setState(() => loading = true);

    try {
      final product = await ProductService.getProductByBarcode(
        barcodeController.text,
      );

      setState(() {
        productId = product["product_id"];
        selectedProductName = product["product_name"];
        selectedProductBrand = product["brand"] ?? "";
        unitController.text = product["default_unit"] ?? "";
        productFound = true;
        loading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Product found!")));
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Product not found: $e")));
    }
  }

  Future<void> submitPantryItem() async {
    if (!_formKey.currentState!.validate()) return;
    if (productId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please search for a product first")),
      );
      return;
    }
    if (selectedExpiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an expiry date")),
      );
      return;
    }

    setState(() => loading = true);

    bool success = await PantryService.addPantryItem(
      productId: productId!,
      quantity: double.parse(quantityController.text),
      unit: unitController.text,
      expiryDate: selectedExpiryDate?.toIso8601String().split('T')[0] ?? "",
      purchaseDate: selectedPurchaseDate != null
          ? selectedPurchaseDate!.toIso8601String().split('T')[0]
          : null,
      notes: notesController.text.isNotEmpty ? notesController.text : null,
      sharedWithHousehold: sharedWithHousehold,
    );

    setState(() => loading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pantry item added successfully!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Error adding pantry item")));
    }
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
    bool required = true,
  }) {
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
          if (required && (value == null || value.isEmpty)) {
            return "Required";
          }
          return null;
        },
      ),
    );
  }

  Widget buildDateField(
    String label,
    DateTime? selectedDate,
    Function(DateTime) onDateSelected, {
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: label.contains("Purchase")
                    ? DateTime(2000)
                    : DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                onDateSelected(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}"
                        : "Select date",
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedDate != null
                          ? Colors.black
                          : Colors.grey.shade500,
                    ),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.grey),
                ],
              ),
            ),
          ),
          if (required && selectedDate == null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                "Required",
                style: TextStyle(color: Colors.red.shade600, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    barcodeController.dispose();
    quantityController.dispose();
    unitController.dispose();
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
              // Barcode search section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: barcodeController,
                        decoration: InputDecoration(
                          labelText: "Barcode",
                          border: const OutlineInputBorder(),
                          enabled: !productFound,
                        ),
                        enabled: !productFound,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: productFound
                          ? () {
                              setState(() {
                                productFound = false;
                                productId = null;
                                selectedProductName = null;
                                selectedProductBrand = null;
                                barcodeController.clear();
                                unitController.clear();
                                quantityController.clear();
                                selectedExpiryDate = null;
                                selectedPurchaseDate = null;
                                notesController.clear();
                              });
                            }
                          : (loading ? null : searchProduct),
                      child: Text(productFound ? "Change" : "Search"),
                    ),
                  ],
                ),
              ),
              // Product info (shown if product found)
              if (productFound)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedProductName ?? "Unknown",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (selectedProductBrand != null &&
                            selectedProductBrand!.isNotEmpty)
                          Text(
                            "Brand: $selectedProductBrand",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              // Pantry item form (only shown if product found)
              if (productFound) ...[
                buildField(
                  "Quantity",
                  quantityController,
                  type: const TextInputType.numberWithOptions(decimal: true),
                  required: true,
                ),
                buildField("Unit", unitController, required: true),
                buildDateField("Expiry Date", selectedExpiryDate, (date) {
                  setState(() {
                    selectedExpiryDate = date;
                  });
                }, required: true),
                buildDateField("Purchase Date", selectedPurchaseDate, (date) {
                  setState(() {
                    selectedPurchaseDate = date;
                  });
                }, required: false),
                buildField("Notes", notesController, required: false),
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
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Add To Pantry"),
                ),
              ] else if (!loading)
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    "Enter a barcode and click Search to begin",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
