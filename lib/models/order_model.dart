import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';
import 'order_item_model.dart';

class OrderModel {
  final String orderId;
  final String userId;

  final List<OrderItemModel> items;

  final AddressModel address;

  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;

  final Timestamp createdAt;

  const OrderModel({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.address,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "userId": userId,

      "items": items.map((e) => e.toMap()).toList(),

      "address": address.toMap(),

      "subtotal": subtotal,
      "deliveryFee": deliveryFee,
      "discount": discount,
      "total": total,

      "paymentMethod": paymentMethod,
      "paymentStatus": paymentStatus,
      "orderStatus": orderStatus,

      "createdAt": createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map["orderId"] ?? "",
      userId: map["userId"] ?? "",

      items: (map["items"] as List<dynamic>? ?? [])
          .map((e) => OrderItemModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),

      address: AddressModel.fromMap(
        Map<String, dynamic>.from(map["address"] ?? {}),
      ),

      subtotal: (map["subtotal"] ?? 0).toDouble(),
      deliveryFee: (map["deliveryFee"] ?? 0).toDouble(),
      discount: (map["discount"] ?? 0).toDouble(),
      total: (map["total"] ?? 0).toDouble(),

      paymentMethod: map["paymentMethod"] ?? "",

      paymentStatus: map["paymentStatus"] ?? "",

      orderStatus: map["orderStatus"] ?? "",

      createdAt: map["createdAt"] ?? Timestamp.now(),
    );
  }

  OrderModel copyWith({
    String? orderId,
    String? userId,
    List<OrderItemModel>? items,
    AddressModel? address,
    double? subtotal,
    double? deliveryFee,
    double? discount,
    double? total,
    String? paymentMethod,
    String? paymentStatus,
    String? orderStatus,
    Timestamp? createdAt,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      address: address ?? this.address,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
