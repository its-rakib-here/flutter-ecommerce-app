import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/cart_controller/cart_controller.dart';
import '../../models/cart_product_model.dart';
import '../../utills/app_constant.dart';

class CartItemTile extends ConsumerWidget {
  const CartItemTile({super.key, required this.item});

  final CartProductModel item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDiscount = item.product.discountPrice < item.product.price;

    return Dismissible(
      key: ValueKey(item.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
      ),
      onDismissed: (_) {
        ref.read(cartProvider.notifier).removeItem(item.product.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: item.product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: item.product.imageUrls.first,
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    alignment: Alignment.center,
                    width: 95,
                    height: 95,
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        "৳${item.product.discountPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (hasDiscount) ...[
                        const SizedBox(width: 8),
                        Text(
                          "৳${item.product.price.toStringAsFixed(0)}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Subtotal: ৳${item.subtotal.toStringAsFixed(0)}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      _QtyButton(
                        icon: Icons.remove,
                        onTap: () {
                          ref
                              .read(cartProvider.notifier)
                              .decreaseQuantity(item.product.id);
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: Text(
                            "${item.cart.quantity}",
                            key: ValueKey(item.cart.quantity),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      _QtyButton(
                        icon: Icons.add,
                        onTap: () {
                          ref
                              .read(cartProvider.notifier)
                              .increaseQuantity(item.product.id);
                        },
                      ),

                      const Spacer(),

                      IconButton(
                        tooltip: "Remove",
                        onPressed: () {
                          ref
                              .read(cartProvider.notifier)
                              .removeItem(item.product.id);
                        },
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppConstants.primaryColor.withOpacity(.08),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 18, color: AppConstants.primaryColor),
        ),
      ),
    );
  }
}
