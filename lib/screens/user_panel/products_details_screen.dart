import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/widgets/products_details/bottom_action_bar.dart';
import 'package:e_commerce/widgets/products_details/products_header_section.dart';
import 'package:e_commerce/widgets/products_details/related_products_section.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductsHeaderSection(productModel: productModel),

              RelatedProductsSection(productModel: productModel),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        onAddToCart: () {
          // TODO: Add to Cart Logic
        },
        onBuyNow: () {
          // TODO: Buy Now Logic
        },
      ),
    );
  }
}
