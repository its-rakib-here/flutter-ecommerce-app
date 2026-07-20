import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product_model.dart';
import '../../../services/products_service.dart';
import 'selected_category_controller.dart';

final productsServiceProvider = Provider((ref) => ProductsService());

final productsProvider =
    AsyncNotifierProvider<ProductsController, List<ProductModel>>(
      ProductsController.new,
    );

class ProductsController extends AsyncNotifier<List<ProductModel>> {
  @override
  Future<List<ProductModel>> build() async {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return ref
        .read(productsServiceProvider)
        .getProducts(categoryId: selectedCategory?.id);
  }

  Future<void> refreshProducts() async {
    state = const AsyncLoading();

    final selectedCategory = ref.read(selectedCategoryProvider);

    state = await AsyncValue.guard(() {
      return ref
          .read(productsServiceProvider)
          .getProducts(categoryId: selectedCategory?.id);
    });
  }
}
