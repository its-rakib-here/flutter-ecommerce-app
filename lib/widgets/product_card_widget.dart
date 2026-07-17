import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../utills/app_constant.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
    this.onTap,
    this.onFavouriteTap,
    this.onCartTap,
    this.isFavourite = false,
  });

  final ProductModel product;

  final VoidCallback? onTap;
  final VoidCallback? onFavouriteTap;
  final VoidCallback? onCartTap;

  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final image = product.imageUrls.isNotEmpty ? product.imageUrls.first : "";

    final hasDiscount = product.discountPrice < product.price;

    final discount =
        (((product.price - product.discountPrice) / product.price) * 100)
            .round();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size.width * .05),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * .05),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///==========================
            /// IMAGE SECTION
            ///==========================
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Hero(
                    tag: product.id,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(size.width * .05),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.width * .03),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(size.width * .05),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.contain,

                            placeholder: (_, __) => const Center(
                              child: CircularProgressIndicator(),
                            ),

                            errorWidget: (_, __, ___) => Icon(
                              Icons.image_not_supported_outlined,
                              size: size.width * .10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Discount Badge
                  if (hasDiscount)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _DiscountBadge(discount: discount),
                    ),

                  /// Favourite Button
                  Positioned(
                    right: 10,
                    top: 10,
                    child: InkWell(
                      onTap: onFavouriteTap,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: EdgeInsets.all(size.width * .022),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.92),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: isFavourite ? Colors.red : Colors.black87,
                          size: size.width * .05,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///==========================
            /// DETAILS SECTION
            ///==========================
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .03,
                  vertical: size.height * .010,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.width * .037,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: size.height * .005),

                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: size.width * .042,
                        ),

                        SizedBox(width: size.width * .01),

                        Text(
                          product.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * .031,
                          ),
                        ),

                        SizedBox(width: size.width * .01),

                        Text(
                          "(${product.reviewCount})",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: size.width * .028,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    _PriceSection(product: product, onCartTap: onCartTap),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.discount});

  final int discount;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .025,
        vertical: size.height * .004,
      ),
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        borderRadius: BorderRadius.circular(size.width * .025),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_offer_rounded,
            color: Colors.white,
            size: size.width * .035,
          ),
          SizedBox(width: size.width * .01),
          Text(
            "$discount% OFF",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * .028,
              fontWeight: FontWeight.bold,
              letterSpacing: .3,
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceSection extends StatelessWidget {
  const _PriceSection({required this.product, this.onCartTap});

  final ProductModel product;
  final VoidCallback? onCartTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final hasDiscount = product.discountPrice < product.price;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Discount Price
              Text(
                "৳${product.discountPrice.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: size.width * .042,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                ),
              ),

              /// Original Price
              if (hasDiscount)
                Padding(
                  padding: EdgeInsets.only(top: size.height * .002),
                  child: Text(
                    "৳${product.price.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: size.width * .030,
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
            ],
          ),
        ),

        /// Add To Cart Button
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onCartTap,
            borderRadius: BorderRadius.circular(50),
            child: Ink(
              height: size.width * .105,
              width: size.width * .105,
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.primaryColor.withOpacity(.30),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.white,
                size: size.width * .048,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
