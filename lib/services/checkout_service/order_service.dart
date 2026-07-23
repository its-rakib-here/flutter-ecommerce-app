import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/order_model.dart';
import '../../utills/app_constant.dart';

class OrderService {
  OrderService._();

  static final OrderService instance = OrderService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _orderRef =>
      _firestore.collection("orders");

  Future<String> createOrder(OrderModel order) async {
    final doc = _firestore.collection("orders").doc();

    await doc.set(order.copyWith(orderId: doc.id).toMap());

    return doc.id;
  }

  Stream<List<OrderModel>> orderStream() {
    return _orderRef
        .where("userId", isEqualTo: _uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<OrderModel?> getOrder(String orderId) async {
    final doc = await _orderRef.doc(orderId).get();

    if (!doc.exists) return null;

    return OrderModel.fromMap(doc.data()!);
  }

  Future<void> cancelOrder(String orderId) async {
    await _orderRef.doc(orderId).update({
      "orderStatus": AppConstants.orderCancelled,
    });
  }

  Future<void> clearCart() async {
    final snapshot = await _firestore
        .collection("users")
        .doc(_uid)
        .collection("cart")
        .get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
