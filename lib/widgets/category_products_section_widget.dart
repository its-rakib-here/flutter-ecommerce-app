import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/user_controller/home_page_controller/products_controller.dart';
import '../models/product_model.dart';
import 'product_grid_widget.dart';

class CategoryProductsSectionWidget extends ConsumerWidget {
  const CategoryProductsSectionWidget({
    super.key,
    this.onProductTap,
    this.onFavouriteTap,
    this.onCartTap,
  });

  final Function(ProductModel)? onProductTap;
  final Function(ProductModel)? onFavouriteTap;
  final Function(ProductModel)? onCartTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final productsAsync = ref.watch(productsProvider);

    return Expanded(
      child: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, _) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        ),

        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: size.width * .18,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "No Products Found",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Try another category.",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          return ProductGridWidget(
            products: products,
            onProductTap: onProductTap,
            onFavouriteTap: onFavouriteTap,
            onCartTap: onCartTap,
          );
        },
      ),
    );
  }
}
