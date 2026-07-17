import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/user_controller/home_page_controller/products_controller.dart';
import '../controllers/user_controller/home_page_controller/selected_category_controller.dart';
import '../models/product_model.dart';
import '../utills/app_constant.dart';
import 'product_grid_widget.dart';

class ProductSectionWidget extends ConsumerWidget {
  const ProductSectionWidget({
    super.key,
    this.onSeeAll,
    this.onProductTap,
    this.onFavouriteTap,
    this.onCartTap,
  });

  final VoidCallback? onSeeAll;
  final Function(ProductModel)? onProductTap;
  final Function(ProductModel)? onFavouriteTap;
  final Function(ProductModel)? onCartTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final productsAsync = ref.watch(productsProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Expanded(
                child: Text(
                  _getTitle(selectedCategory),
                  style: TextStyle(
                    fontSize: size.width * .05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (onSeeAll != null)
                TextButton(
                  onPressed: onSeeAll,
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: size.height * .01),

          productsAsync.when(
            loading: () => SizedBox(
              height: size.height * .35,
              child: const Center(child: CircularProgressIndicator()),
            ),

            error: (error, stackTrace) => SizedBox(
              height: size.height * .35,
              child: Center(
                child: Text(
                  error.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: size.width * .038,
                  ),
                ),
              ),
            ),

            data: (products) {
              for (final product in products) {
                debugPrint("All Products ${product.toMap().toString()}");
              }
              if (products.isEmpty) {
                return SizedBox(
                  height: size.height * .35,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: size.width * .15,
                        color: Colors.grey,
                      ),

                      SizedBox(height: size.height * .015),

                      Text(
                        "No Products Found",
                        style: TextStyle(
                          fontSize: size.width * .042,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: size.height * .006),

                      Text(
                        "Please try another category.",
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
        ],
      ),
    );
  }

  String _getTitle(String? categoryId) {
    switch (categoryId) {
      case null:
        return "🔥 Featured Products";
      default:
        return "Products";
    }
  }
}
