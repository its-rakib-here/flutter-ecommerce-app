import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts({String? categoryId}) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection("products")
        .where("isActive", isEqualTo: true);

    if (categoryId == null) {
      query = query.where("isFeatured", isEqualTo: true);
    } else {
      query = query.where("categoryId", isEqualTo: categoryId);
    }

    final snapshot = await query.get();

    // Future<int> getProductsCount(String categoryId) async {
    //   try {
    //     final snapshot = await _firestore
    //         .collection('products')
    //         .where('categoryId', isEqualTo: categoryId)
    //         .count()
    //         .get();
    //     return snapshot.count ?? 0;
    //   } catch (e) {
    //     throw Exception('Failed to load products count: $e');
    //   }
    // }

    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }
}
