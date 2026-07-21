import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/product_model.dart';

class ProductsDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProductModel?> getProductDetails(String productId) async {
    try {
      final doc = await _firestore.collection("products").doc(productId).get();

      if (!doc.exists) return null;

      return ProductModel.fromFirestore(doc);
    } catch (e) {
      throw Exception("Failed to fetch product details: $e");
    }
  }
}
