import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/address_model.dart';
import '../../../models/cart_product_model.dart';
import '../../controllers/user_controller/home_page_controller/checkout_controller/order_controller.dart';

class PlaceOrderButton extends ConsumerStatefulWidget {
  final AddressModel? address;
  final List<CartProductModel> cartItems;
  final String paymentMethod;
  final bool fromCart;

  const PlaceOrderButton({
    super.key,
    required this.address,
    required this.cartItems,
    required this.paymentMethod,
    required this.fromCart,
  });

  @override
  ConsumerState<PlaceOrderButton> createState() => _PlaceOrderButtonState();
}

class _PlaceOrderButtonState extends ConsumerState<PlaceOrderButton> {
  bool _isLoading = false;

  Future<void> _placeOrder() async {
    if (widget.address == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a shipping address.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final orderId = await ref
          .read(orderProvider.notifier)
          .placeOrder(
            cartProducts: widget.cartItems,
            address: widget.address!,
            paymentMethod: widget.paymentMethod,
            fromCart: widget.fromCart,
          );

      if (!mounted) return;

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (_) => OrderSuccessScreen(orderId: orderId)),
      //   (route) => false,
      // );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _placeOrder,
        child: _isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                "Place Order",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
