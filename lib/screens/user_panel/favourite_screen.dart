import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/favourite_controller/favourite_controller.dart';
import '../../controllers/user_controller/home_page_controller/products_controller.dart';
import '../../widgets/favourite/favourite_empty_widget.dart';
import '../../widgets/favourite/favourite_item_tile.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteAsync = ref.watch(favouriteProvider);
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

        title: favouriteAsync.when(
          data: (ids) => Column(
            children: [
              const Text(
                "My Wishlist",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Text(
              //   "${ids.length} Saved Items",
              //   style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              // ),
            ],
          ),
          loading: () => const Text("My Wishlist"),
          error: (_, __) => const Text("My Wishlist"),
        ),
      ),

      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, s) => Center(child: Text(e.toString())),

        data: (products) {
          return favouriteAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),

            error: (e, s) => Center(child: Text(e.toString())),

            data: (favouriteIds) {
              final favouriteProducts = products
                  .where((product) => favouriteIds.contains(product.id))
                  .toList();

              if (favouriteProducts.isEmpty) {
                return const FavouriteEmptyWidget();
              }

              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(productsProvider);
                  ref.invalidate(favouriteProvider);
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: favouriteProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (_, index) {
                    return FavouriteItemTile(product: favouriteProducts[index]);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
