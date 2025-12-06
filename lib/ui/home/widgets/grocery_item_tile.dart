import 'package:flutter/material.dart';
import 'package:shopping_app_test/core/models/grocery_item.dart';

class GroceryItemTile extends StatelessWidget {
  const GroceryItemTile({super.key, required this.item, required this.onTap});

  /// The grocery item to display.
  final GroceryItem item;

  /// The callback to call when the item is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: item.isSelected ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isSelected ? Colors.green.shade300 : Colors.grey.shade200,
          width: item.isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.isSelected ? Colors.green : Colors.transparent,
                    border: Border.all(
                      color: item.isSelected
                          ? Colors.green
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: item.isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: item.isSelected
                              ? Colors.green.shade900
                              : Colors.grey.shade900,
                          decoration: item.isSelected
                              ? TextDecoration.none
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: item.isSelected
                              ? Colors.green.shade700
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.isSelected)
                  Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.green.shade600,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
