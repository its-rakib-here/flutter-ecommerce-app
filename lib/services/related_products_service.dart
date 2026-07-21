import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class RelatedProductsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getRelatedProducts({
    required String categoryId,
    required String currentProductId,
  }) async {
    final snapshot = await _firestore
        .collection('products')
        .where('categoryId', isEqualTo: categoryId)
        .where('isActive', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .where((product) => product.id != currentProductId)
        .toList();
  }
}
