// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../models/product_model.dart';
// import '../../../services/related_products_service.dart';
//
// final relatedProductsServiceProvider = Provider<RelatedProductsService>((ref) {
//   return RelatedProductsService();
// });
//
// class RelatedProductsParams {
//   final String categoryId;
//   final String currentProductId;
//
//   const RelatedProductsParams({
//     required this.categoryId,
//     required this.currentProductId,
//   });
// }
//
// class RelatedProductsNotifier
//     extends FamilyAsyncNotifier<List<ProductModel>, RelatedProductsParams> {
//   @override
//   Future<List<ProductModel>> build(RelatedProductsParams params) async {
//     final service = ref.read(relatedProductsServiceProvider);
//
//     return service.getRelatedProducts(
//       categoryId: params.categoryId,
//       currentProductId: params.currentProductId,
//     );
//   }
//
//   Future<void> refreshProducts() async {
//     state = const AsyncLoading();
//
//     state = await AsyncValue.guard(() async {
//       final service = ref.read(relatedProductsServiceProvider);
//
//       return service.getRelatedProducts(
//         categoryId: arg.categoryId,
//         currentProductId: arg.currentProductId,
//       );
//     });
//   }
// }
//
// final relatedProductsProvider =
//     AsyncNotifierProvider.family<
//       RelatedProductsNotifier,
//       List<ProductModel>,
//       RelatedProductsParams
//     >(RelatedProductsNotifier.new);
