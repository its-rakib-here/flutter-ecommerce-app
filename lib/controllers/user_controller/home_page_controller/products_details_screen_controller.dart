import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/product_model.dart';
import '../../../services/products_details_service.dart';

part 'products_details_screen_controller.g.dart';

@riverpod
ProductsDetailsService productsDetailsService(Ref ref) {
  return ProductsDetailsService();
}

@riverpod
class ProductDetailsController extends _$ProductDetailsController {
  @override
  Future<ProductModel?> build(String productId) async {
    return ref
        .read(productsDetailsServiceProvider)
        .getProductDetails(productId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      return ref
          .read(productsDetailsServiceProvider)
          .getProductDetails(productId);
    });
  }
}
