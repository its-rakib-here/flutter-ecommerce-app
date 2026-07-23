import 'package:flutter/material.dart';

import '../../../models/order_model.dart';

class OrderInfoCard extends StatelessWidget {
  final OrderModel order;

  const OrderInfoCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row("Order ID", order.orderId),
            const Divider(),
            _row("Order Status", order.orderStatus),
            const Divider(),
            _row("Payment Method", order.paymentMethod),
            const Divider(),
            _row("Payment Status", order.paymentStatus),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
