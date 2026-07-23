import 'package:flutter/material.dart';

import '../../../utills/app_constant.dart';

class PaymentMethodCard extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String?> onChanged;

  const PaymentMethodCard({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            RadioListTile<String>(
              value: AppConstants.cashOnDelivery,
              groupValue: selectedMethod,
              onChanged: onChanged,
              contentPadding: EdgeInsets.zero,
              title: const Text("Cash On Delivery"),
              subtitle: const Text("Pay when your order is delivered."),
            ),

            const Divider(height: 1),

            RadioListTile<String>(
              value: AppConstants.sslCommerz,
              groupValue: selectedMethod,
              onChanged: onChanged,
              contentPadding: EdgeInsets.zero,
              title: const Text("SSLCommerz"),
              subtitle: const Text(
                "Pay securely using bKash, Nagad, Card, Rocket, etc.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
