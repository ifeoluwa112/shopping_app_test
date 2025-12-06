import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app_test/core/core.dart';

import 'package:shopping_app_test/features/shopping/bloc/shopping_list_event.dart';
import 'package:shopping_app_test/features/shopping/bloc/shopping_list_state.dart';

/// A bloc for the shopping list.
class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  /// The constructor for the ShoppingListBloc.
  ShoppingListBloc() : super(_initialState()) {
    on<ToggleItemSelection>(_onToggleItemSelection);
  }

  /// The initial state of the shopping list.
  static ShoppingListState _initialState() {
    final items = [
      const GroceryItem(id: '1', name: 'Apples', price: 3.99),
      const GroceryItem(id: '2', name: 'Bread', price: 2.49),
      const GroceryItem(id: '3', name: 'Milk', price: 4.29),
      const GroceryItem(id: '4', name: 'Eggs', price: 5.99),
      const GroceryItem(id: '5', name: 'Cheese', price: 6.49),
      const GroceryItem(id: '6', name: 'Chicken', price: 8.99),
      const GroceryItem(id: '7', name: 'Rice', price: 4.79),
      const GroceryItem(id: '8', name: 'Pasta', price: 3.29),
      const GroceryItem(id: '9', name: 'Tomatoes', price: 3.49),
      const GroceryItem(id: '10', name: 'Coffee', price: 12.99),
    ];

    return ShoppingListState(items: items, totalPrice: 0);
  }

  /// Handles the ToggleItemSelection event.
  void _onToggleItemSelection(
    ToggleItemSelection event,
    Emitter<ShoppingListState> emit,
  ) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.itemId) {
        return item.copyWith(isSelected: !item.isSelected);
      }
      return item;
    }).toList();

    final totalPrice = updatedItems
        .where((item) => item.isSelected)
        .fold<double>(0, (sum, item) => sum + item.price);

    emit(state.copyWith(items: updatedItems, totalPrice: totalPrice));
  }
}
