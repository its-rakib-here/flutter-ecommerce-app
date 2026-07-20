import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/category_model.dart';
import '../../../services/categoy_service.dart';

final allCategoryProvider =
    AsyncNotifierProvider<AllCategoryController, List<CategoryModel>>(
      AllCategoryController.new,
    );

class AllCategoryController extends AsyncNotifier<List<CategoryModel>> {
  final CategoryService _categoryService = CategoryService();

  String _search = "";

  @override
  Future<List<CategoryModel>> build() async {
    debugPrint("AllCategoryController build called");

    return _categoryService.getCategories(search: _search);
  }

  Future<void> loadCategories() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _categoryService.getCategories(search: _search);
    });
  }

  Future<void> searchCategory(String query) async {
    _search = query.trim();
    await loadCategories();
  }

  Future<void> clearSearch() async {
    _search = "";
    await loadCategories();
  }

  Future<void> refreshCategories() async {
    await loadCategories();
  }
}
