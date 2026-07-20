import 'package:e_commerce/controllers/user_controller/home_page_controller/category_controller.dart';
import 'package:e_commerce/screens/user_panel/category_wise_producsts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/all_screen_catergory_widget.dart';

class AllCategoryScreen extends ConsumerStatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  ConsumerState<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends ConsumerState<AllCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  String searchText = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryAsync = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("All Categories"), centerTitle: true),

      body: Column(
        children: [
          /// Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search categories...",
                prefixIcon: const Icon(Icons.search),
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

          Expanded(
            child: categoryAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),

              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),

              data: (categories) {
                final filtered = categories.where((category) {
                  return category.name.toLowerCase().contains(searchText);
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text("No Categories Found"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: filtered.length,

                  itemBuilder: (context, index) {
                    return AllScreenCategoryWidget(
                      categoryModel: filtered[index],

                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (Context) => CategoryWiseProductsScreen(
                              appbarTitle: filtered[index].name,
                              productCount: filtered[index].productsCount,
                              categoryId: filtered[index].id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
