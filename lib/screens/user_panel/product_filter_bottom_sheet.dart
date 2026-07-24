import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/filter_controller/product_filter_controller.dart';
import '../../controllers/user_controller/home_page_controller/filter_controller/product_filter_state.dart';

class ProductFilterBottomSheet extends ConsumerWidget {
  const ProductFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(productFilterProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sort By",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            RadioListTile<ProductSort>(
              value: ProductSort.newest,
              groupValue: filter.sort,
              title: const Text("Newest"),
              onChanged: (value) {
                ref.read(productFilterProvider.notifier).sort(value!);
                Navigator.pop(context);
              },
            ),

            RadioListTile<ProductSort>(
              value: ProductSort.priceLowHigh,
              groupValue: filter.sort,
              title: const Text("Price: Low → High"),
              onChanged: (value) {
                ref.read(productFilterProvider.notifier).sort(value!);
                Navigator.pop(context);
              },
            ),

            RadioListTile<ProductSort>(
              value: ProductSort.priceHighLow,
              groupValue: filter.sort,
              title: const Text("Price: High → Low"),
              onChanged: (value) {
                ref.read(productFilterProvider.notifier).sort(value!);
                Navigator.pop(context);
              },
            ),

            RadioListTile<ProductSort>(
              value: ProductSort.rating,
              groupValue: filter.sort,
              title: const Text("Highest Rated"),
              onChanged: (value) {
                ref.read(productFilterProvider.notifier).sort(value!);
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  ref.read(productFilterProvider.notifier).clear();
                  Navigator.pop(context);
                },
                child: const Text("Clear Filters"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
