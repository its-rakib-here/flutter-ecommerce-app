import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_filter_state.dart';

final productFilterProvider =
    NotifierProvider<ProductFilterNotifier, ProductFilterState>(
      ProductFilterNotifier.new,
    );

class ProductFilterNotifier extends Notifier<ProductFilterState> {
  @override
  ProductFilterState build() {
    return const ProductFilterState();
  }

  void search(String query) {
    state = state.copyWith(query: query);
  }

  void sort(ProductSort sort) {
    state = state.copyWith(sort: sort);
  }

  void clear() {
    state = const ProductFilterState();
  }
}
