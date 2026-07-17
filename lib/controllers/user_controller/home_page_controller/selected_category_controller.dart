import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryController, String?>(
      SelectedCategoryController.new,
    );

class SelectedCategoryController extends Notifier<String?> {
  @override
  String? build() => null;

  void selectCategory(String categoryId) {
    state = categoryId;
  }

  void clearCategory() {
    state = null;
  }

  void toggleCategory(String categoryId) {
    if (state == categoryId) {
      state = null;
    } else {
      state = categoryId;
    }
  }
}
