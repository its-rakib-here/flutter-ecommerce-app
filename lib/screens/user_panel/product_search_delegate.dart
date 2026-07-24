import 'package:e_commerce/controllers/user_controller/home_page_controller/filter_controller/filtered_products_provider.dart';
import 'package:e_commerce/screens/user_panel/products_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductSearchDelegate extends SearchDelegate<void> {
  ProductSearchDelegate(this.ref);

  final WidgetRef ref;

  @override
  String get searchFieldLabel => "Search products";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final allProducts = ref.watch(filteredProductsProvider);

        final products = allProducts.where((product) {
          final q = query.trim().toLowerCase();

          return product.name.toLowerCase().contains(q) ||
              product.description.toLowerCase().contains(q);
        }).toList();

        if (query.isEmpty) {
          return const Center(child: Text("Search products..."));
        }

        if (products.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return ListTile(
              leading: const Icon(Icons.search),
              title: Text(product.name),
              onTap: () {
                query = product.name;
                showResults(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final allProducts = ref.watch(filteredProductsProvider);

        final products = allProducts.where((product) {
          final q = query.trim().toLowerCase();

          return product.name.toLowerCase().contains(q) ||
              product.description.toLowerCase().contains(q);
        }).toList();

        if (products.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return ListView.separated(
          itemCount: products.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final product = products[index];

            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.thumbnail,
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(product.name),
              subtitle: Text("৳${product.discountPrice}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                close(context, null);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsScreen(productModel: product),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
