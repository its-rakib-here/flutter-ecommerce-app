import 'package:flutter/material.dart';

import '../../models/cart_product_model.dart';
import '../../utills/app_constant.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.items});

  final List<CartProductModel> items;

  @override
  Widget build(BuildContext context) {
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.subtotal);

    const delivery = 80.0;

    final total = subtotal + delivery;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12)],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _row("Subtotal", "৳${subtotal.toStringAsFixed(0)}"),

            const SizedBox(height: 10),

            _row("Delivery", "৳${delivery.toStringAsFixed(0)}"),

            const Divider(height: 28),

            _row("Total", "৳${total.toStringAsFixed(0)}", bold: true),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value, {bool bold = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: bold ? 18 : 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 18 : 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            color: bold ? AppConstants.primaryColor : Colors.black87,
          ),
        ),
      ],
    );
  }
}
