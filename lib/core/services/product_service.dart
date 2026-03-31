import 'dart:convert';
import 'package:cloud_kitchen_flutter_fe/core/network/api_client.dart';

class ProductService {
  static Future<bool> createProduct({
    required String productName,
    String? brand,
    String? barcode,
    String? category,
    String? defaultUnit,
    String? storageLocation,
    String? source,
  }) async {
    final response = await ApiClient.post("/products/", {
      "product_name": productName,
      "brand": brand,
      "barcode": barcode,
      "category": category,
      "default_unit": defaultUnit,
      "storage_location": storageLocation,
      "source": source,
    });

    return response.statusCode == 201;
  }

  static Future<Map<String, dynamic>> getProductByBarcode(
    String barcode,
  ) async {
    final response = await ApiClient.get("/products/barcode/$barcode");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Product not found");
    }
  }
}
