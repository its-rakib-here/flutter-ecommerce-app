import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product_model.dart';
import '../../../services/products_service.dart';

final productsServiceProvider = Provider((ref) => ProductsService());

final categoryProductsProvider =
    AsyncNotifierProvider<CategoryProductsController, List<ProductModel>>(
      CategoryProductsController.new,
    );

class CategoryProductsController extends AsyncNotifier<List<ProductModel>> {
  String? _categoryId;

  @override
  Future<List<ProductModel>> build() async {
    return [];
  }

  Future<void> loadProducts(String categoryId) async {
    _categoryId = categoryId;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      return ref
          .read(productsServiceProvider)
          .getProducts(categoryId: categoryId);
    });
  }

  Future<void> refreshProducts() async {
    if (_categoryId == null) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      return ref
          .read(productsServiceProvider)
          .getProducts(categoryId: _categoryId);
    });
  }
}
