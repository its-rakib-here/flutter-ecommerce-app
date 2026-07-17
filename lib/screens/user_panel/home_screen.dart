import 'package:e_commerce/widgets/banner_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

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

            // Categories

            // Products
          ],
        ),
      ),
    );
  }
}
