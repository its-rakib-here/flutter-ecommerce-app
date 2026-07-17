import 'package:e_commerce/widgets/banner_slider_widget.dart';
import 'package:e_commerce/widgets/category_widget.dart';
import 'package:e_commerce/widgets/headin_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/user_controller/home_page_controller/category_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final CategoryModel categoryModel=CategoryModel()
    final Size size = MediaQuery.of(context).size;
    final categories = ref.watch(categoryProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .02,
          vertical: size.height * .02,
        ),
        child: Column(
          children: [
            const BannerSliderWidget(),

            SizedBox(height: size.height * .03),

            //Heading
            HeadinWidgets(
              headingTitle: "Categories",
              onTap: () {},
              buttonText: "see more",
            ),
            SizedBox(height: size.height * .02),

            // Categories
            categories.when(
              data: (categorieList) {
                return SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryWidget(category: categorieList[index]);
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemCount: categorieList.length,
                  ),
                );
              },
              error: (error, stackTrace) =>
                  Center(child: Text("Not Categories found")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),

            // Products
          ],
        ),
      ),
    );
  }
}
