import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/cart_item_model.dart';
import '../../../../services/firestore_service.dart';

final cartProvider = StreamNotifierProvider<CartNotifier, List<CartItemModel>>(
  CartNotifier.new,
);

class CartNotifier extends StreamNotifier<List<CartItemModel>> {
  final _service = FirestoreService.instance;

  @override
  Stream<List<CartItemModel>> build() {
    return _service.cartStream();
  }

  Future<void> addToCart(String productId) async {
    await _service.addToCart(productId);
  }

  Future<void> increaseQuantity(String productId) async {
    await _service.increaseQuantity(productId);
  }

  Future<void> decreaseQuantity(String productId) async {
    await _service.decreaseQuantity(productId);
  }

  Future<void> removeItem(String productId) async {
    await _service.removeCartItem(productId);
  }
}

final cartSelectionProvider =
    NotifierProvider<CartSelectionNotifier, Map<String, bool>>(
      CartSelectionNotifier.new,
    );

class CartSelectionNotifier extends Notifier<Map<String, bool>> {
  @override
  Map<String, bool> build() {
    return {};
  }

  bool isSelected(String productId) {
    return state[productId] ?? true;
  }

  void toggle(String productId) {
    state = {...state, productId: !(state[productId] ?? true)};
  }

  void setSelected(String productId, bool value) {
    state = {...state, productId: value};
  }

  void selectAll(List<String> productIds) {
    state = {for (final id in productIds) id: true};
  }

  void unselectAll(List<String> productIds) {
    state = {for (final id in productIds) id: false};
  }

  List<String> getSelectedIds() {
    return state.entries.where((e) => e.value).map((e) => e.key).toList();
  }

  bool areAllSelected(List<String> productIds) {
    if (productIds.isEmpty) return false;

    return productIds.every((id) => state[id] ?? true);
  }
}
