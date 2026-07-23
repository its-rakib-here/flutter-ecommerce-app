import 'package:flutter/material.dart';

import '../../../models/order_model.dart';

class OrderPriceSummaryCard extends StatelessWidget {
  final OrderModel order;

  const OrderPriceSummaryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row("Subtotal", order.subtotal),
            const SizedBox(height: 10),
            _row("Delivery Fee", order.deliveryFee),
            const SizedBox(height: 10),
            _row("Discount", order.discount),
            const Divider(height: 30),
            _row("Total", order.total, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, double value, {bool bold = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Text(
          "৳ ${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
