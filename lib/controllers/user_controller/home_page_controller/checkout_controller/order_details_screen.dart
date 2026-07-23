import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/order_model.dart';
import '../../../../utills/app_constant.dart';
import 'order_controller.dart';

class OrderDetailsScreen extends ConsumerWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _OrderStatusCard(order: order),

            const SizedBox(height: 16),

            _AddressCard(order: order),

            const SizedBox(height: 16),

            _ProductsCard(order: order),

            const SizedBox(height: 16),

            _PaymentCard(order: order),

            const SizedBox(height: 16),

            _PriceCard(order: order),

            const SizedBox(height: 30),

            if (order.orderStatus == AppConstants.orderPending)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Cancel Order"),
                        content: const Text(
                          "Are you sure you want to cancel this order?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("No"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );

                    if (confirm != true) return;

                    await ref
                        .read(orderProvider.notifier)
                        .cancelOrder(order.orderId);

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text("Cancel Order"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _OrderStatusCard extends StatelessWidget {
  final OrderModel order;

  const _OrderStatusCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.local_shipping),
        title: const Text("Order Status"),
        subtitle: Text(order.orderStatus),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final OrderModel order;

  const _AddressCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final address = order.address;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shipping Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(address.fullName),
            Text(address.phone),
            const SizedBox(height: 8),
            Text("${address.street}, ${address.city}, ${address.country}"),
          ],
        ),
      ),
    );
  }
}

class _ProductsCard extends StatelessWidget {
  final OrderModel order;

  const _ProductsCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: order.items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) {
          final item = order.items[index];

          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.network(
              item.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(item.name),
            subtitle: Text("Qty: ${item.quantity}"),
            trailing: Text("৳ ${item.subtotal.toStringAsFixed(2)}"),
          );
        },
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final OrderModel order;

  const _PaymentCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.payment),
        title: Text(order.paymentMethod),
        subtitle: Text(order.paymentStatus),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final OrderModel order;

  const _PriceCard({required this.order});

  Widget row(String title, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text("৳ ${value.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            row("Subtotal", order.subtotal),
            row("Delivery", order.deliveryFee),
            row("Discount", order.discount),
            const Divider(),
            row("Total", order.total),
          ],
        ),
      ),
    );
  }
}
