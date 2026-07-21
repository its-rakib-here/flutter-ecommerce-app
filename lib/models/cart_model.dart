import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String productId;
  final int quantity;
  final double price;
  final DateTime createdAt;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createdAt,
  });

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt,
    };
  }
}
