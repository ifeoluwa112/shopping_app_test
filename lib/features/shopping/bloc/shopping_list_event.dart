import 'package:equatable/equatable.dart';

/// An abstract class for the shopping list events.
abstract class ShoppingListEvent extends Equatable {
  /// The constructor for the ShoppingListEvent.
  const ShoppingListEvent();

  /// The properties of the ShoppingListEvent.
  @override
  List<Object?> get props => [];
}

class ToggleItemSelection extends ShoppingListEvent {
  /// The constructor for the ToggleItemSelection event.
  const ToggleItemSelection(this.itemId);

  /// The unique identifier for the grocery item.
  final String itemId;

  @override
  List<Object?> get props => [itemId];
}
