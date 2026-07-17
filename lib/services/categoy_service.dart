import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await _firestore
          .collection('categories')
          .where('isActive', isEqualTo: true)
          .orderBy('order')
          .get();

      for (final doc in snapshot.docs) {
        debugPrint("Document ID: ${doc.id}");
        debugPrint("Category Data: ${doc.data()}");
      }

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return CategoryModel.fromMap(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Failed to load categories');
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}
