import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/address_model.dart';
import '../../../../models/cart_product_model.dart';
import '../../../../models/order_item_model.dart';
import '../../../../models/order_model.dart';
import '../../../../services/checkout_service/order_service.dart';
import '../../../../utills/app_constant.dart';

final orderProvider = StreamNotifierProvider<OrderNotifier, List<OrderModel>>(
  OrderNotifier.new,
);

class OrderNotifier extends StreamNotifier<List<OrderModel>> {
  final OrderService _orderService = OrderService.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Stream<List<OrderModel>> build() {
    return _orderService.orderStream();
  }

  Future<void> placeOrder({
    required List<CartProductModel> cartProducts,
    required AddressModel address,
    required String paymentMethod,
    required bool fromCart,
  }) async {
    final orderItems = cartProducts
        .map(OrderItemModel.fromCartProduct)
        .toList();

    final subtotal = orderItems.fold<double>(
      0,
      (sum, item) => sum + item.subtotal,
    );

    const double deliveryFee = 60;
    const double discount = 0;

    final total = subtotal + deliveryFee - discount;

    final order = OrderModel(
      orderId: '',
      userId: uid,
      items: orderItems,
      address: address,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      discount: discount,
      total: total,
      paymentMethod: paymentMethod,
      paymentStatus: paymentMethod == AppConstants.cashOnDelivery
          ? AppConstants.paymentPending
          : AppConstants.paymentPaid,
      orderStatus: AppConstants.orderPending,
      createdAt: Timestamp.now(),
    );

    await _orderService.createOrder(order);

    if (fromCart) {
      await _orderService.clearCart();
    }
  }

  Future<OrderModel?> getOrder(String orderId) {
    return _orderService.getOrder(orderId);
  }

  Future<void> cancelOrder(String orderId) async {
    await _orderService.cancelOrder(orderId);
  }
}
