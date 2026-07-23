import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/cart_controller/cart_controller.dart';
import '../../controllers/user_controller/home_page_controller/products_controller.dart';
import '../../models/cart_product_model.dart';
import '../../utills/app_constant.dart';
import '../../widgets/cart_widget/cart_item_tile.dart';
import '../../widgets/cart_widget/cart_summary.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);
    final productsAsync = ref.watch(allProductsProvider);
    final selectedMap = ref.watch(cartSelectionProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())),
        data: (products) {
          return cartAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text(e.toString())),
            data: (cartItems) {
              if (cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 90,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Your cart is empty",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Looks like you haven't\nadded anything yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Continue Shopping"),
                      ),
                    ],
                  ),
                );
              }

              final items = cartItems.map((cart) {
                final product = products.firstWhere(
                  (e) => e.id == cart.productId,
                );

                return CartProductModel(product: product, cart: cart);
              }).toList();

              /// Only selected items
              final selectedItems = items.where((item) {
                return selectedMap[item.product.id] ?? true;
              }).toList();

              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(cartProvider);
                    ref.invalidate(allProductsProvider);
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];

                            return CartItemTile(
                              item: item,
                              isSelected: selectedMap[item.product.id] ?? true,
                              onSelectedChanged: (value) {
                                ref
                                    .read(cartSelectionProvider.notifier)
                                    .setSelected(
                                      item.product.id,
                                      value ?? false,
                                    );
                              },
                            );
                          },
                        ),
                      ),

                      /// Total only selected items
                      CartSummary(items: selectedItems),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
