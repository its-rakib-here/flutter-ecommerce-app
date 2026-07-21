import 'package:flutter/material.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.onCheckout,
  });

  final double subtotal;
  final double shipping;
  final double discount;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final total = subtotal + shipping - discount;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 28),

            _row("Subtotal", "\$${subtotal.toStringAsFixed(0)}"),

            const SizedBox(height: 18),

            _row("Shipping", "\$${shipping.toStringAsFixed(0)}"),

            const SizedBox(height: 18),

            _row(
              "Discount",
              "-\$${discount.toStringAsFixed(0)}",
              valueColor: Colors.green,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 22),
              child: Divider(height: 1),
            ),

            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Including VAT",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                const Spacer(),

                Text(
                  "\$${total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFF7A00),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 62,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xffFF7A00),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline),

                    SizedBox(width: 10),

                    Text(
                      "Proceed to Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(width: 10),

                    Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value, {Color? valueColor}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
