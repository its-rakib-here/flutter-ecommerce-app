import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryWidget({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: size.width * .22,
        child: Column(
          children: [
            Container(
              width: size.width * .16,
              height: size.width * .16,
              decoration: BoxDecoration(
                color: AppConstants.primaryLight,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: category.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * .01),

            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppConstants.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
