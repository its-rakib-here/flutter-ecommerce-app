import 'package:e_commerce/controllers/user_controller/home_page_controller/selected_category_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product_model.dart';
import '../../../services/products_service.dart';

final productsServiceProvider = Provider((ref) => ProductsService());

final productsProvider =
    AsyncNotifierProvider<ProductsController, List<ProductModel>>(
      ProductsController.new,
    );

class ProductsController extends AsyncNotifier<List<ProductModel>> {
  @override
  Future<List<ProductModel>> build() async {
    final categoryId = ref.watch(selectedCategoryProvider);

    return ref
        .read(productsServiceProvider)
        .getProducts(categoryId: categoryId);
  }

  Future<void> refreshProducts() async {
    state = const AsyncLoading();

    final categoryId = ref.read(selectedCategoryProvider);

    state = await AsyncValue.guard(() {
      return ref
          .read(productsServiceProvider)
          .getProducts(categoryId: categoryId);
    });
  }
}
