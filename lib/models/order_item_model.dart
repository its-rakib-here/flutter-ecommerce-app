import 'cart_product_model.dart';

class OrderItemModel {
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final double subtotal;

  const OrderItemModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });

  /// Create an OrderItem from a CartProductModel
  factory OrderItemModel.fromCartProduct(CartProductModel item) {
    return OrderItemModel(
      productId: item.product.id,
      name: item.product.name,
      image: item.product.thumbnail,
      price: item.product.discountPrice,
      quantity: item.cart.quantity,
      subtotal: item.subtotal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "name": name,
      "image": image,
      "price": price,
      "quantity": quantity,
      "subtotal": subtotal,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productId: map["productId"] ?? "",
      name: map["name"] ?? "",
      image: map["image"] ?? "",
      price: (map["price"] as num?)?.toDouble() ?? 0.0,
      quantity: map["quantity"] ?? 0,
      subtotal: (map["subtotal"] as num?)?.toDouble() ?? 0.0,
    );
  }

  OrderItemModel copyWith({
    String? productId,
    String? name,
    String? image,
    double? price,
    int? quantity,
    double? subtotal,
  }) {
    return OrderItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
    );
  }
}
