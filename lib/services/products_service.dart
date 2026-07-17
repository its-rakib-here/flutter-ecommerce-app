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

    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }
}
