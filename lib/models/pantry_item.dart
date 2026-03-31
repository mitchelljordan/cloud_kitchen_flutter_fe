class PantryItem {
  final String id;
  final int productId;
  final String name;
  final double quantity;
  final String unit;
  final String expiryDate;

  PantryItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.expiryDate,
  });

  factory PantryItem.fromJson(Map<String, dynamic> json) {
    return PantryItem(
      id: json["pantry_id"].toString(),
      productId: json["product"]?["product_id"] ?? 0,
      name: json["product"]?["product_name"] ?? "Unknown",
      quantity: (json["quantity"] ?? 0).toDouble(),
      unit: json["unit"] ?? "",
      expiryDate: json["expiry_date"] ?? "",
    );
  }
}
