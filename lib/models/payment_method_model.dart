import 'package:cloud_firestore/cloud_firestore.dart';

enum PaymentType { visa, mastercard, bkash, nagad }

class PaymentMethodModel {
  final String id;
  final String userId;
  final PaymentType type;
  final String nickname;
  final String holderName;
  final String last4;
  final int expiryMonth;
  final int expiryYear;
  final String phone;
  final bool isDefault;
  final Timestamp createdAt;

  const PaymentMethodModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.nickname,
    required this.holderName,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.phone,
    required this.isDefault,
    required this.createdAt,
  });

  factory PaymentMethodModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return PaymentMethodModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      type: PaymentType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => PaymentType.visa,
      ),
      nickname: data['nickname'] ?? '',
      holderName: data['holderName'] ?? '',
      last4: data['last4'] ?? '',
      expiryMonth: data['expiryMonth'] ?? 0,
      expiryYear: data['expiryYear'] ?? 0,
      phone: data['phone'] ?? '',
      isDefault: data['isDefault'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type.name,
      'nickname': nickname,
      'holderName': holderName,
      'last4': last4,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'phone': phone,
      'isDefault': isDefault,
      'createdAt': createdAt,
    };
  }

  PaymentMethodModel copyWith({
    String? id,
    String? userId,
    PaymentType? type,
    String? nickname,
    String? holderName,
    String? last4,
    int? expiryMonth,
    int? expiryYear,
    String? phone,
    bool? isDefault,
    Timestamp? createdAt,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      nickname: nickname ?? this.nickname,
      holderName: holderName ?? this.holderName,
      last4: last4 ?? this.last4,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      phone: phone ?? this.phone,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isCard => type == PaymentType.visa || type == PaymentType.mastercard;

  bool get isMobileWallet =>
      type == PaymentType.bkash || type == PaymentType.nagad;
}
