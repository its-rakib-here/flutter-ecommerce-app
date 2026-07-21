import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/widgets/products_details/product_description_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/category_controller.dart';
import '../../utills/app_constant.dart';

class ProductsHeaderSection extends ConsumerStatefulWidget {
  final ProductModel productModel;

  const ProductsHeaderSection({super.key, required this.productModel});

  @override
  ConsumerState<ProductsHeaderSection> createState() =>
      _ProductsHeaderSectionState();
}

class _ProductsHeaderSectionState extends ConsumerState<ProductsHeaderSection> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final categoryState = ref.watch(categoryProvider);

    String categoryName = "Unknown";

    categoryState.whenData((categories) {
      final matchedCategory = categories.firstWhere(
        (e) => e.id == widget.productModel.categoryId,
      );

      categoryName = matchedCategory.name;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: widget.productModel.thumbnail,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.42,
              fit: BoxFit.cover,
            ),

            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(
                    icon: Icons.arrow_back_outlined,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildIconButton(
                    icon: Icons.favorite_border_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: size.height * 0.02),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.productModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            _priceSection(
              price: widget.productModel.price.toString(),
              discountPrice: widget.productModel.discountPrice.toString(),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ratingWidget(
            rating: widget.productModel.rating,
            reviewCount: widget.productModel.reviewCount,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        productInfoSection(
          stock: widget.productModel.stock,
          category: categoryName,
        ),
        SizedBox(height: size.height * 0.01),

        ProductDescriptionSection(description: widget.productModel.description),
      ],
    );
  }
}

Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
  return Material(
    color: Colors.white.withOpacity(0.9),
    shape: const CircleBorder(),
    elevation: 3,
    child: InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: Colors.black87, size: 24),
      ),
    ),
  );
}

Widget _priceSection({required String price, required String discountPrice}) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "৳$discountPrice",
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppConstants.saleColor,
          ),
        ),
        Text(
          "৳$price",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    ),
  );
}

Widget ratingWidget({required double rating, required int reviewCount}) {
  return Row(
    children: [
      ...List.generate(
        5,
        (index) => Icon(
          index < rating.floor()
              ? Icons.star_rounded
              : Icons.star_border_rounded,
          color: Colors.amber,
          size: 20,
        ),
      ),

      const SizedBox(width: 8),

      Text(
        rating.toStringAsFixed(1),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),

      const SizedBox(width: 6),

      Text(
        "($reviewCount Reviews)",
        style: TextStyle(color: Colors.grey.shade600),
      ),
    ],
  );
}

Widget productInfoSection({required int stock, required String category}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: IntrinsicHeight(
      child: Row(
        children: [
          /// Stock
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.green,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "In Stock",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      "$stock Available",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          VerticalDivider(thickness: 1, color: Colors.grey.shade300),

          /// Category
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.sell_outlined,
                    color: Colors.black54,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Category",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 14,
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
