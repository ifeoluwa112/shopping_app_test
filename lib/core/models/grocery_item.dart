import 'package:equatable/equatable.dart';

/// A model class for a grocery item.
class GroceryItem extends Equatable {
  /// The unique identifier for the grocery item.
  const GroceryItem({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });

  /// The unique identifier for the grocery item.
  final String id;

  /// The name of the grocery item.
  final String name;

  /// The price of the grocery item.
  final double price;

  /// Whether the grocery item is selected.
  final bool isSelected;

  /// Creates a copy of the grocery item with the given properties updated.
  GroceryItem copyWith({
    String? id,
    String? name,
    double? price,
    bool? isSelected,
  }) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  /// The properties of the grocery item.
  @override
  List<Object?> get props => [id, name, price, isSelected];
}
