import '../../models/pantry_item.dart';

class PantryController {
  final List<PantryItem> items = [
    PantryItem(id: '1', name: 'Eggs', quantity: 12, unit: 'pcs'),
    PantryItem(id: '2', name: 'Milk', quantity: 1, unit: 'L'),
    PantryItem(id: '3', name: 'Flour', quantity: 2, unit: 'kg'),
  ];

  void deleteItem(String id) {
    items.removeWhere((item) => item.id == id);
  }
}