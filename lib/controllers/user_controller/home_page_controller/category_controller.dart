import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/category_model.dart';
import '../../../services/categoy_service.dart';

final categoryProvider =
    AsyncNotifierProvider<CategoryController, List<CategoryModel>>(
      CategoryController.new,
    );

class CategoryController extends AsyncNotifier<List<CategoryModel>> {
  final CategoryService _categoryService = CategoryService();

  @override
  Future<List<CategoryModel>> build() async {
    debugPrint("CategoryController build called");
    return await _categoryService.getCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _categoryService.getCategories();
    });
  }
}
