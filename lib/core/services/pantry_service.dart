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

    final response = await ApiClient.post(
      "/pantry/",
      {
        "product_id": productId,
        "quantity": quantity,
        "unit": unit,
        "expiry_date": expiryDate,
        "purchase_date": purchaseDate,
        "notes": notes,
        "shared_with_household": sharedWithHousehold,
      },
    );

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

}