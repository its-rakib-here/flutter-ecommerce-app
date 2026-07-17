class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final int order;
  final bool isActive;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.order,
    required this.isActive,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      order: map['order'] ?? 0,
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'order': order,
      'isActive': isActive,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? order,
    bool? isActive,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
    );
  }
}
