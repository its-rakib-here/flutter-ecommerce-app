class CartItemModel {
  final String productId;
  final int quantity;

  const CartItemModel({required this.productId, required this.quantity});

  factory CartItemModel.fromMap(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'productId': productId, 'quantity': quantity};
  }
}
