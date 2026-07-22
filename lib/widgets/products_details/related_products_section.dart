import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/products_controller.dart';

class RelatedProductsSection extends ConsumerWidget {
  final ProductModel productModel;

  const RelatedProductsSection({super.key, required this.productModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final relatedProductsAsync = ref.watch(
      relatedProductsProvider(productModel),
    );
    return relatedProductsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (error, stack) => const SizedBox(),

      data: (relatedProducts) {
        if (relatedProducts.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.only(
            top: size.height * .025,
            bottom: size.height * .03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "You May Also Like",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .05,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text("View All")),
                  ],
                ),
              ),

              SizedBox(height: size.height * .015),

              SizedBox(
                height: size.height * .29,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .04),
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedProducts.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: size.width * .03),
                  itemBuilder: (_, index) {
                    return SizedBox(
                      width: size.width * .42,
                      child: ProductCardWidget(product: relatedProducts[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
