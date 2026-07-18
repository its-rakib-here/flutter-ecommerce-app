import 'package:flutter/material.dart';

import '../models/product_model.dart';
import 'product_card_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({
    super.key,
    required this.products,
    this.onProductTap,
    this.onFavouriteTap,
    this.onCartTap,
  });

  final List<ProductModel> products;

  final Function(ProductModel)? onProductTap;
  final Function(ProductModel)? onFavouriteTap;
  final Function(ProductModel)? onCartTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .001,
        vertical: size.height * .02,
      ),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        // crossAxisSpacing: size.width * .035,
        //
        // mainAxisSpacing: size.height * .03,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16,
        mainAxisExtent: 300,

        /// Premium Fashion Card
        // childAspectRatio: .65,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return ProductCardWidget(
          product: product,

          onTap: () => onProductTap?.call(product),

          onFavouriteTap: () => onFavouriteTap?.call(product),

          onCartTap: () => onCartTap?.call(product),
        );
      },
    );
  }
}
