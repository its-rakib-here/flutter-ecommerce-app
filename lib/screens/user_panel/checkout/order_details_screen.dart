import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/user_controller/home_page_controller/checkout_controller/order_controller.dart';
import '../../../models/order_model.dart';
import '../../../utills/app_constant.dart';
import '../../../widgets/checkout/order_info_card.dart';
import '../../../widgets/checkout/order_price_summary_card.dart';
import '../../../widgets/checkout/order_timeline.dart';
import '../../../widgets/checkout/ordered_products_card.dart';
import '../../../widgets/checkout/shipping_address_card.dart';

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
            OrderInfoCard(order: order),

            const SizedBox(height: 16),

            OrderTimeline(currentStatus: order.orderStatus),

            const SizedBox(height: 16),

            ShippingAddressCard(address: order.address),

            const SizedBox(height: 16),

            OrderedProductsCard(order: order),

            const SizedBox(height: 16),

            OrderPriceSummaryCard(order: order),

            const SizedBox(height: 24),

            if (order.orderStatus == AppConstants.orderPending)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
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
