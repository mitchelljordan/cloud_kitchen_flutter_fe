class Ingredient {
  final int productId;
  final String productName;
  final double amount;
  final String unit;
  final Map<String, dynamic>? nutrients;
  String status; // Mutable to allow status updates
  double? pantryQuantity;

  Ingredient({
    required this.productId,
    required this.productName,
    required this.amount,
    required this.unit,
    this.nutrients,
    this.status = "sufficient",
    this.pantryQuantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      productId: json["product_id"] ?? 0,
      productName: json["product_name"] ?? "Unknown",
      amount: (json["amount"] ?? 0).toDouble(),
      unit: json["unit"] ?? "",
      nutrients: json["nutrients"],
      status: json["status"] ?? "sufficient",
      pantryQuantity: json["pantry_quantity"] != null
          ? (json["pantry_quantity"]).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "product_name": productName,
      "amount": amount,
      "unit": unit,
      "nutrients": nutrients,
      "status": status,
      "pantry_quantity": pantryQuantity,
    };
  }
}
