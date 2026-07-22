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
