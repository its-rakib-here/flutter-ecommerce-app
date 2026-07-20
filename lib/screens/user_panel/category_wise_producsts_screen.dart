import 'package:e_commerce/widgets/product_section_widget.dart';
import 'package:flutter/material.dart';

class CategoryWiseProductsScreen extends StatelessWidget {
  final String appbarTitle;
  final int productCount;
  final String categoryId;

  const CategoryWiseProductsScreen({
    super.key,
    required this.appbarTitle,
    required this.productCount,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _serachText = TextEditingController();
    String search = "";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        titleSpacing: 0,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appbarTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 2),

            Text(
              "$productCount Products",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              /// Favourite
            },
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          IconButton(
            onPressed: () {
              /// Favourite
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined),

                Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: const Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _serachText,
              decoration: InputDecoration(
                hintText: "Search items for $appbarTitle...",
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.grey.shade100,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 10),
          ProductSectionWidget(),
        ],
      ),
    );
  }
}
