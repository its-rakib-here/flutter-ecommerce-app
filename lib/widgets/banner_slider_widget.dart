import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/controllers/banner_controller.dart';
import 'package:e_commerce/controllers/banner_index_controller.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSliderWidget extends ConsumerWidget {
  const BannerSliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerState = ref.watch(bannerControllerProvider);
    final Size size = MediaQuery.of(context).size;

    return bannerState.when(
      loading: () => SizedBox(
        height: size.height * .22,
        child: const Center(child: CircularProgressIndicator()),
      ),

      error: (error, stackTrace) {
        debugPrint("Banner Error: $error");

        return SizedBox(
          height: size.height * .22,
          child: const Center(child: Text("Failed to load banners")),
        );
      },

      data: (banners) {
        if (banners.isEmpty) {
          return SizedBox(
            height: size.height * .22,
            child: const Center(child: Text("No banners available")),
          );
        }

        final currentIndex = ref.watch(bannerIndexPorovider);

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: banners.length,
              itemBuilder: (context, index, realIndex) {
                final banner = banners[index];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                    imageUrl: banner.img_url,
                    width: double.infinity,
                    fit: BoxFit.cover,

                    placeholder: (_, __) => Container(
                      color: Colors.grey.shade100,
                      child: const Center(child: CircularProgressIndicator()),
                    ),

                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(Icons.broken_image_outlined, size: 40),
                    ),
                  ),
                );
              },

              options: CarouselOptions(
                height: size.height * .22,
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                autoPlay: true,
                autoPlayCurve: Curves.easeInOut,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),

                onPageChanged: (index, reason) {
                  ref.read(bannerIndexPorovider.notifier).changeIndex(index);
                },
              ),
            ),

            SizedBox(height: size.height * .015),

            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: banners.length,
              effect: ExpandingDotsEffect(
                dotHeight: size.width * .02,
                dotWidth: size.width * .02,
                expansionFactor: 3,
                spacing: 6,
                dotColor: Colors.grey.shade300,
                activeDotColor: AppConstants.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
