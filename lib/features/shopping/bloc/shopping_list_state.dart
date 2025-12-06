import 'package:equatable/equatable.dart';
import 'package:shopping_app_test/core/models/grocery_item.dart';

/// A state class for the shopping list.
class ShoppingListState extends Equatable {
  /// The constructor for the ShoppingListState.
  const ShoppingListState({required this.items, required this.totalPrice});

  /// The list of grocery items.
  final List<GroceryItem> items;

  /// The total price of the grocery items.
  final double totalPrice;

  /// Creates a copy of the shopping list state with the given properties
  /// updated.
  ShoppingListState copyWith({List<GroceryItem>? items, double? totalPrice}) {
    return ShoppingListState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  /// The properties of the ShoppingListState.
  @override
  List<Object?> get props => [items, totalPrice];
}
