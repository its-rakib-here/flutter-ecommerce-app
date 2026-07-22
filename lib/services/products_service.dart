import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts({
    String? categoryId,
    String search = "",
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection("products")
        .where("isActive", isEqualTo: true);

    if (categoryId == null) {
      query = query.where("isFeatured", isEqualTo: true);
    } else {
      query = query.where("categoryId", isEqualTo: categoryId);
    }

    final snapshot = await query.get();

    List<ProductModel> products = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();

    if (search.trim().isNotEmpty) {
      final keyword = search.toLowerCase();

      products = products.where((product) {
        return product.name.toLowerCase().contains(keyword);
      }).toList();
    }

    return products;
  }

  Future<List<ProductModel>> getRelatedProducts({
    required String categoryId,
    required String currentProductId,
  }) async {
    final snapshot = await _firestore
        .collection("products")
        .where("categoryId", isEqualTo: categoryId)
        .where("isActive", isEqualTo: true)
        .limit(10)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .where((product) => product.id != currentProductId)
        .toList();
  }
}
