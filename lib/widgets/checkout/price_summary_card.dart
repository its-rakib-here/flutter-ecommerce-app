import 'package:flutter/material.dart';

class PriceSummaryCard extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const PriceSummaryCard({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Price Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),

            _PriceRow(title: "Subtotal", value: subtotal),

            const SizedBox(height: 10),

            _PriceRow(title: "Delivery Fee", value: deliveryFee),

            const SizedBox(height: 10),

            _PriceRow(
              title: "Discount",
              value: -discount,
              valueColor: Colors.green,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1),
            ),

            _PriceRow(title: "Total", value: total, isTotal: true),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final double value;
  final bool isTotal;
  final Color? valueColor;

  const _PriceRow({
    required this.title,
    required this.value,
    this.isTotal = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isTotal ? 18 : 15,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
      color: valueColor,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: style.copyWith(color: Colors.black87)),
        Text("৳ ${value.toStringAsFixed(2)}", style: style),
      ],
    );
  }
}
