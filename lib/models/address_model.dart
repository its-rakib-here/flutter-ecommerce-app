import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id;
  final String userId;

  final String fullName;
  final String phone;

  final String country;
  final String city;
  final String street;

  final String postalCode;

  final bool isDefault;

  final Timestamp createdAt;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.country,
    required this.city,
    required this.street,
    required this.postalCode,
    required this.isDefault,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "fullName": fullName,
      "phone": phone,
      "country": country,
      "city": city,
      "street": street,
      "postalCode": postalCode,
      "isDefault": isDefault,
      "createdAt": createdAt,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map["id"] ?? "",
      userId: map["userId"] ?? "",
      fullName: map["fullName"] ?? "",
      phone: map["phone"] ?? "",
      country: map["country"] ?? "",
      city: map["city"] ?? "",
      street: map["street"] ?? "",
      postalCode: map["postalCode"] ?? "",
      isDefault: map["isDefault"] ?? false,
      createdAt: map["createdAt"] ?? Timestamp.now(),
    );
  }

  AddressModel copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? phone,
    String? country,
    String? city,
    String? street,
    String? postalCode,
    bool? isDefault,
    Timestamp? createdAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      city: city ?? this.city,
      street: street ?? this.street,
      postalCode: postalCode ?? this.postalCode,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
