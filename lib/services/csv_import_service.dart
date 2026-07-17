import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class CsvImportService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> importProducts() async {
    final csvString = await rootBundle.loadString("assets/products.csv");
  }
}
