import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/user_panel/checkout/checkout_screen.dart';
import 'package:e_commerce/widgets/products_details/bottom_action_bar.dart';
import 'package:e_commerce/widgets/products_details/products_header_section.dart';
import 'package:e_commerce/widgets/products_details/related_products_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/cart_controller/cart_controller.dart';
import '../../models/cart_item_model.dart';
import '../../models/cart_product_model.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onAddToCart: () async {
          await ref.read(cartProvider.notifier).addToCart(productModel.id);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Product added to cart"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        onBuyNow: () {
          final item = CartProductModel(
            product: productModel,
            cart: CartItemModel(productId: productModel.id, quantity: 1),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CheckoutScreen(items: [item], fromCart: false),
            ),
          );
        },
      ),
    );
  }
}
