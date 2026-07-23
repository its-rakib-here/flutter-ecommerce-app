import 'package:flutter/material.dart';

import '../../../models/address_model.dart';

class CheckoutAddressCard extends StatelessWidget {
  final AddressModel? address;
  final VoidCallback onTap;

  const CheckoutAddressCard({
    super.key,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (address == null) {
      return Card(
        elevation: 2,
        child: ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.red),
          title: const Text(
            "No Shipping Address",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: const Text("Please add or select a delivery address."),
          trailing: TextButton(onPressed: onTap, child: const Text("Add")),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Shipping Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(onPressed: onTap, child: const Text("Change")),
              ],
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                address!.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(height: 4),

            Align(alignment: Alignment.centerLeft, child: Text(address!.phone)),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                [
                  address!.street,
                  address!.city,
                  address!.country,
                  address!.postalCode,
                ].where((e) => e.isNotEmpty).join(", "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
