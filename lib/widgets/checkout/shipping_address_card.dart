import 'package:flutter/material.dart';

import '../../../models/address_model.dart';

class ShippingAddressCard extends StatelessWidget {
  final AddressModel address;

  const ShippingAddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shipping Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 15),
            Text(address.fullName),
            Text(address.phone),
            const SizedBox(height: 8),
            Text("${address.street}, ${address.city}, ${address.country}"),
            if (address.postalCode.isNotEmpty) Text(address.postalCode),
          ],
        ),
      ),
    );
  }
}
