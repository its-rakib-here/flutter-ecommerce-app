import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discountPrice;
  final String categoryId;
  final List<String> imageUrls;
  final int stock;
  final double rating;
  final int reviewCount;
  final bool isActive;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.categoryId,
    required this.imageUrls,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    required this.isActive,
    required this.isFeatured,
  });

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    // Debug (সমস্যা বের করার জন্য)
    print("========== PRODUCT ==========");
    print("Doc ID: ${doc.id}");
    print(data);

    final imageData = data['imageUrls'];

    return ProductModel(
      id: doc.id,

      name: data['name']?.toString() ?? '',

      description: data['description']?.toString() ?? '',

      price: _toDouble(data['price']),

      discountPrice: _toDouble(data['discountPrice']),

      categoryId: data['categoryId']?.toString() ?? '',

      imageUrls: imageData is List
          ? imageData.map((e) => e.toString()).toList()
          : imageData is String
          ? [imageData]
          : [],

      stock: _toInt(data['stock']),

      rating: _toDouble(data['rating']),

      reviewCount: _toInt(data['reviewCount']),

      isActive: data['isActive'] == true,

      isFeatured: data['isFeatured'] == true,
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return 0.0;
  }

  static int _toInt(dynamic value) {
    if (value is num) return value.toInt();
    return 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'discountPrice': discountPrice,
      'categoryId': categoryId,
      'imageUrls': imageUrls,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'isActive': isActive,
      'isFeatured': isFeatured,
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discountPrice,
    String? categoryId,
    List<String>? imageUrls,
    int? stock,
    double? rating,
    int? reviewCount,
    bool? isActive,
    bool? isFeatured,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      categoryId: categoryId ?? this.categoryId,
      imageUrls: imageUrls ?? this.imageUrls,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  bool get inStock => stock > 0;

  String get thumbnail => imageUrls.isNotEmpty ? imageUrls.first : "";

  int get discountPercentage {
    if (price <= 0) return 0;

    return (((price - discountPrice) / price) * 100).round();
  }
}
