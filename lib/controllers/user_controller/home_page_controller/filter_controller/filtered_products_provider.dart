import 'package:e_commerce/controllers/user_controller/home_page_controller/filter_controller/product_filter_controller.dart';
import 'package:e_commerce/controllers/user_controller/home_page_controller/filter_controller/product_filter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/product_model.dart';
import '../products_controller.dart';

final filteredProductsProvider = Provider<List<ProductModel>>((ref) {
  final products = ref.watch(allProductsProvider).value ?? [];

  final filter = ref.watch(productFilterProvider);

  List<ProductModel> filtered = [...products];

  /// Search
  if (filter.query.isNotEmpty) {
    filtered = filtered.where((product) {
      final query = filter.query.toLowerCase();

      return product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);
    }).toList();
  }

  /// Sorting
  switch (filter.sort) {
    case ProductSort.newest:
      break;

    case ProductSort.priceLowHigh:
      filtered.sort((a, b) => a.discountPrice.compareTo(b.discountPrice));
      break;

    case ProductSort.priceHighLow:
      filtered.sort((a, b) => b.discountPrice.compareTo(a.discountPrice));
      break;

    case ProductSort.rating:
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
      break;
  }

  return filtered;
});
