import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app_test/core/services/sound_service.dart';
import 'package:shopping_app_test/features/features.dart';
import 'package:shopping_app_test/ui/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final soundService = SoundService();

    return BlocProvider(
      create: (context) => ShoppingListBloc(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: CustomScrollView(
          slivers: [
            // Collapsible App Bar
            SliverAppBar(
              expandedHeight: 120,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.blue.shade700,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  'Shopping List',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: false,
                titlePadding: EdgeInsets.only(left: 16, bottom: 16),
              ),
            ),

            // Pinned Total Price Display
            SliverPersistentHeader(
              pinned: true,
              delegate: _TotalPriceDelegate(),
            ),

            // Grocery Items List
            BlocBuilder<ShoppingListBloc, ShoppingListState>(
              builder: (context, state) {
                return SliverPadding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = state.items[index];
                        return GroceryItemTile(
                          item: item,
                          onTap: () {
                            // Play sound effect
                            if (item.isSelected) {
                              soundService.playDeselectSound();
                            } else {
                              soundService.playSelectSound();
                            }
                            // Toggle selection
                            context.read<ShoppingListBloc>().add(
                                  ToggleItemSelection(item.id),
                                );
                          },
                        );
                      },
                      childCount: state.items.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom delegate for pinned total price header
class _TotalPriceDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final currencyFormat = NumberFormat.currency(
      symbol: r'$',
      decimalDigits: 2,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                height: constraints.maxHeight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        currencyFormat.format(state.totalPrice),
                        key: ValueKey(state.totalPrice),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: state.totalPrice > 0
                              ? Colors.green.shade700
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(_TotalPriceDelegate oldDelegate) => true;
}
