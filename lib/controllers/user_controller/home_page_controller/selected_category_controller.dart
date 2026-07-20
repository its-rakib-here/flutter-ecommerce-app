import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/category_model.dart';

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryController, CategoryModel?>(
      SelectedCategoryController.new,
    );

class SelectedCategoryController extends Notifier<CategoryModel?> {
  @override
  CategoryModel? build() => null;

  void selectCategory(CategoryModel category) {
    state = category;
  }

  void clearCategory() {
    state = null;
  }
}
