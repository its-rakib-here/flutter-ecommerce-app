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
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: cartAsync.when(
          data: (cartItems) => Column(
            children: [
              const Text(
                "My Cart",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${cartItems.length} Items",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
          loading: () => const Text("My Cart"),
          error: (_, __) => const Text("My Cart"),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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

              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(cartProvider);
                    ref.invalidate(productsProvider);
                  },

                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return CartItemTile(item: items[index]);
                          },
                        ),
                      ),

                      CartSummary(items: items),
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
