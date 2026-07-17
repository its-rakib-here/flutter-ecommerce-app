import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/user_controller/home_page_controller/category_controller.dart';
import '../controllers/user_controller/home_page_controller/selected_category_controller.dart';
import 'category_widget.dart';
import 'headin_widgets.dart';

class CategorySectionWidget extends ConsumerWidget {
  const CategorySectionWidget({super.key, this.onSeeMore});

  final VoidCallback? onSeeMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final categoriesAsync = ref.watch(categoryProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadinWidgets(
            headingTitle: "Categories",
            buttonText: "See More",
            onTap: onSeeMore ?? () {},
          ),

          SizedBox(height: size.height * .01),

          categoriesAsync.when(
            loading: () => SizedBox(
              height: 110,
              child: const Center(child: CircularProgressIndicator()),
            ),

            error: (error, stackTrace) => SizedBox(
              height: 110,
              child: Center(
                child: Text(
                  "Categories not found",
                  style: TextStyle(color: Colors.red.shade400),
                ),
              ),
            ),

            data: (categories) {
              if (categories.isEmpty) {
                return const SizedBox(
                  height: 110,
                  child: Center(child: Text("No Categories Found")),
                );
              }

              return SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return CategoryWidget(
                      category: categories[index],
                      onTap: () {
                        ref
                            .read(selectedCategoryProvider.notifier)
                            .toggleCategory(categories[index].id);

                        debugPrint(
                          "Selected Category: ${categories[index].name} (${categories[index].id})",
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
