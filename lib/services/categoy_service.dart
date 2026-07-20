import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories({String search = ""}) async {
    try {
      final categorySnapshot = await _firestore
          .collection('categories')
          .where('isActive', isEqualTo: true)
          .orderBy('order')
          .get();

      final productSnapshot = await _firestore
          .collection('products')
          .where('isActive', isEqualTo: true)
          .get();

      final Map<String, int> categoryCounts = {};

      for (final product in productSnapshot.docs) {
        final categoryId = product['categoryId'] as String;
        categoryCounts[categoryId] = (categoryCounts[categoryId] ?? 0) + 1;
      }

      List<CategoryModel> categories = [];

      for (final doc in categorySnapshot.docs) {
        final data = doc.data();

        data['id'] = doc.id;
        data['productsCount'] = categoryCounts[doc.id] ?? 0;

        categories.add(CategoryModel.fromMap(data));
      }

      // Search filtering
      if (search.trim().isNotEmpty) {
        final keyword = search.toLowerCase();

        categories = categories.where((category) {
          return category.name.toLowerCase().contains(keyword);
        }).toList();
      }

      return categories;
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to load categories');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}
