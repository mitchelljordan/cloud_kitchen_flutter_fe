import 'dart:convert';
import 'package:cloud_kitchen_flutter_fe/core/network/api_client.dart';

class PantryService {
  static Future<List<dynamic>> getUserPantry() async {
    final response = await ApiClient.get("/pantry");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load pantry");
    }
  }

  static Future<bool> addPantryItem({
    required int productId,
    required double quantity,
    required String unit,
    String? expiryDate,
    String? purchaseDate,
    String? notes,
    bool sharedWithHousehold = false,
  }) async {
    final response = await ApiClient.post("/pantry/", {
      "product_id": productId,
      "quantity": quantity,
      "unit": unit,
      "expiry_date": expiryDate,
      "purchase_date": purchaseDate,
      "notes": notes,
      "shared_with_household": sharedWithHousehold,
    });

    return response.statusCode == 201;
  }

  static Future<bool> deletePantryItem(int pantryId) async {
    final response = await ApiClient.delete("/pantry/$pantryId");

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Failed to delete pantry item");
    }
  }

  static Future<bool> updatePantryItem({
    required int pantryId,
    required double quantity,
    required String expiryDate,
  }) async {
    final response = await ApiClient.put("/pantry/$pantryId", {
      "quantity": quantity,
      "expiry_date": expiryDate,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update pantry item");
    }
  }

  static Future<bool> deductIngredientFromPantry({
    required int pantryId,
    required double amount,
    required String expiryDate,
  }) async {
    final userPantry = await getUserPantry();

    final pantryItem = userPantry.firstWhere(
      (item) => item["pantry_id"] == pantryId,
      orElse: () => null,
    );

    if (pantryItem == null) {
      throw Exception("Pantry item not found");
    }

    final currentQuantity = (pantryItem["quantity"] ?? 0).toDouble();
    final newQuantity = currentQuantity - amount;

    if (newQuantity <= 0) {
      // Delete the item if quantity becomes 0 or negative
      return await deletePantryItem(pantryId);
    } else {
      // Update with new quantity
      return await updatePantryItem(
        pantryId: pantryId,
        quantity: newQuantity,
        expiryDate: expiryDate,
      );
    }
  }
}
