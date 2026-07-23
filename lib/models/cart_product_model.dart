import 'package:e_commerce/models/cart_item_model.dart';
import 'package:e_commerce/models/product_model.dart';

class CartProductModel {
  final ProductModel product;
  final CartItemModel cart;

  const CartProductModel({required this.product, required this.cart});

  double get subtotal => product.discountPrice * cart.quantity;
}
 