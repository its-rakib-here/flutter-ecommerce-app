import 'package:flutter/material.dart';

class CartOrderSummary extends StatelessWidget {
  const CartOrderSummary({
    super.key,
    this.subtotal = 720,
    this.shipping = 20,
    this.discount = 50,
  });

  final double subtotal;
  final double shipping;
  final double discount;

  @override
  Widget build(BuildContext context) {
    final total = subtotal + shipping - discount;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FD),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          _SummaryRow(title: "Subtotal", value: subtotal),

          const SizedBox(height: 18),

          _SummaryRow(title: "Shipping", value: shipping),

          const SizedBox(height: 18),

          _SummaryRow(
            title: "Discount",
            value: -discount,
            valueColor: Colors.green,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 22),
            child: Divider(thickness: 1, height: 1),
          ),

          Row(
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const Spacer(),

              Text(
                "\$${total.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFF7A00),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.title,
    required this.value,
    this.valueColor,
  });

  final String title;
  final double value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final isNegative = value < 0;

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        Text(
          "${isNegative ? "-" : ""}\$${value.abs().toStringAsFixed(0)}",
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
