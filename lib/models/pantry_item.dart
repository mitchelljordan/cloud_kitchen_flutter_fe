class PantryItem {
  final String id;
  final String name;
  final double quantity;
  final String unit;

  PantryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory PantryItem.fromJson(Map<String, dynamic> json) {
    return PantryItem(
      id: json["pantry_id"].toString(),
      name: json["product_name"] ?? "Unknown",
      quantity: (json["quantity"] ?? 0).toDouble(),
      unit: json["unit"] ?? "",
    );
  }
}