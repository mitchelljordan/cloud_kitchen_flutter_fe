import 'package:flutter/material.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/product_service.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();

  final productNameController = TextEditingController();
  final brandController = TextEditingController();
  final barcodeController = TextEditingController();
  final categoryController = TextEditingController();
  final unitController = TextEditingController();
  final locationController = TextEditingController();
  final sourceController = TextEditingController();

  bool loading = false;

  Future<void> submitProduct() async {
    if (!_formKey.currentState!.validate()) return;
  
    setState(() => loading = true);

    bool success = await ProductService.createProduct(
      productName: productNameController.text,
      brand: brandController.text,
      barcode: barcodeController.text,
      category: categoryController.text,
      defaultUnit: unitController.text,
      storageLocation: locationController.text,
      source: sourceController.text,
    );

    setState(() => loading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product created")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error creating product")),
      );
    }
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildField("Product Name", productNameController),
              buildField("Brand", brandController),
              buildField("Barcode", barcodeController),
              buildField("Category", categoryController),
              buildField("Default Unit", unitController),
              buildField("Storage Location", locationController),
              buildField("Source", sourceController),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: loading ? null : submitProduct,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Create Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}