import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/cart_controller/cart_controller.dart';
import '../../models/cart_product_model.dart';
import '../../screens/user_panel/products_details_screen.dart';
import '../../utills/app_constant.dart';

class CartItemTile extends ConsumerWidget {
  const CartItemTile({
    super.key,
    required this.item,
    this.isSelected = true,
    this.onSelectedChanged,
  });

  final CartProductModel item;
  final bool isSelected;
  final ValueChanged<bool?>? onSelectedChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDiscount = item.product.discountPrice < item.product.price;
    final discountPercent = hasDiscount
        ? (((item.product.price - item.product.discountPrice) /
                      item.product.price) *
                  100)
              .round()
        : 0;

    return Dismissible(
      key: ValueKey(item.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      onDismissed: (_) {
        ref.read(cartProvider.notifier).removeItem(item.product.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selection checkbox — Daraz/Amazon let you pick which
            // items go to checkout.
            Padding(
              padding: const EdgeInsets.only(top: 28, right: 4),
              child: SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: isSelected,
                  onChanged: onSelectedChanged,
                  activeColor: AppConstants.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsScreen(productModel: item.product),
                  ),
                );
              },
              child: Hero(
                tag: item.product.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item.product.imageUrls.first,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      width: 84,
                      height: 84,
                      color: Colors.grey.shade100,
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: 84,
                      height: 84,
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.image_not_supported, size: 20),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ref
                              .read(cartProvider.notifier)
                              .removeItem(item.product.id);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8, top: 2),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Price row: discounted price, strikethrough original,
                  // and a small "-X%" badge — the Daraz/Amazon signature.
                  Row(
                    children: [
                      Text(
                        "৳${item.product.discountPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      if (hasDiscount) ...[
                        const SizedBox(width: 6),
                        Text(
                          "৳${item.product.price.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "-$discountPercent%",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(Icons.star, size: 13, color: Colors.amber.shade700),
                      const SizedBox(width: 3),
                      Text(
                        item.product.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        " (${item.product.reviewCount})",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _QuantitySelector(item: item),
                      Text(
                        "Subtotal: ৳${item.subtotal.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
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

class _QuantitySelector extends ConsumerWidget {
  final CartProductModel item;

  const _QuantitySelector({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              ref.read(cartProvider.notifier).decreaseQuantity(item.product.id);
            },
            child: const SizedBox(
              width: 28,
              height: 28,
              child: Icon(Icons.remove, size: 15),
            ),
          ),
          Container(width: 1, height: 18, color: Colors.grey.shade300),
          SizedBox(
            width: 32,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Text(
                  "${item.cart.quantity}",
                  key: ValueKey(item.cart.quantity),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
          Container(width: 1, height: 18, color: Colors.grey.shade300),
          InkWell(
            onTap: () {
              ref.read(cartProvider.notifier).increaseQuantity(item.product.id);
            },
            child: SizedBox(
              width: 28,
              height: 28,
              child: Icon(
                Icons.add,
                size: 15,
                color: AppConstants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
