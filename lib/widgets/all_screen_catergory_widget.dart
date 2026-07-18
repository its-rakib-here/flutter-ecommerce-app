import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:flutter/material.dart';

class AllScreenCategoryWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String productCount;
  final CategoryModel categoryModel;

  const AllScreenCategoryWidget({
    super.key,
    this.onPress,
    required this.productCount,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppConstants.primaryLight,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: categoryModel.imageUrl,
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoryModel.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    productCount,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppConstants.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
