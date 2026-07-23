import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/cart_controller/cart_controller.dart';
import '../../controllers/user_controller/home_page_controller/favourite_controller/favourite_controller.dart';
import '../../models/product_model.dart';
import '../../screens/user_panel/products_details_screen.dart';
import '../../utills/app_constant.dart';

class FavouriteItemTile extends ConsumerWidget {
  const FavouriteItemTile({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider).value ?? [];

    final isInCart = cartItems.any((e) => e.productId == product.id);

    final hasDiscount = product.discountPrice < product.price;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(productModel: product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrls.first,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (_, __, ___) => const Icon(Icons.image),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            ref
                                .read(favouriteProvider.notifier)
                                .toggleFavourite(product.id);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.favorite, color: Colors.red),
                          ),
                        ),
                      ],
                    ),

                    // const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),

                        const SizedBox(width: 4),

                        Text(
                          "${product.rating}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),

                    Row(
                      children: [
                        Text(
                          "৳${product.discountPrice.toStringAsFixed(0)}",
                          style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        if (hasDiscount) ...[
                          const SizedBox(width: 8),

                          Text(
                            "৳${product.price.toStringAsFixed(0)}",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton.icon(
                        onPressed: isInCart
                            ? null
                            : () {
                                ref
                                    .read(cartProvider.notifier)
                                    .addToCart(product.id);
                              },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart
                              ? Colors.grey.shade300
                              : AppConstants.primaryColor,
                          foregroundColor: isInCart
                              ? Colors.black87
                              : Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        icon: Icon(
                          isInCart ? Icons.check : Icons.shopping_cart_outlined,
                        ),

                        label: Text(isInCart ? "In Cart" : "Add to Cart"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
