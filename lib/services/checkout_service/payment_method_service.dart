import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/payment_method_model.dart';

class PaymentMethodService {
  PaymentMethodService._();

  static final PaymentMethodService instance = PaymentMethodService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _paymentRef =>
      _firestore.collection("users").doc(_uid).collection("payment_methods");

  Stream<List<PaymentMethodModel>> paymentMethodsStream() {
    return _paymentRef
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PaymentMethodModel.fromFirestore(doc))
              .toList(),
        );
  }

  Future<void> addPaymentMethod(PaymentMethodModel payment) async {
    try {
      print("Writing to: ${_paymentRef.path}");
      print(payment.toMap());

      await _paymentRef.doc(payment.id).set(payment.toMap());

      print("Firestore Write Success");
    } catch (e, st) {
      print("Firestore Error: $e");
      print(st);
    }
    await _paymentRef.doc(payment.id).set(payment.toMap());

    final check = await _paymentRef.get();

    print("Total payment methods: ${check.docs.length}");

    for (final doc in check.docs) {
      print(doc.id);
      print(doc.data());
    }

    await _paymentRef.doc(payment.id).set(payment.toMap());

    final doc = await _paymentRef.doc(payment.id).get();

    print("Exists: ${doc.exists}");
    print(doc.data());
  }

  Future<void> updatePaymentMethod(PaymentMethodModel payment) async {
    await _paymentRef.doc(payment.id).update(payment.toMap());
  }

  Future<void> deletePaymentMethod(String paymentId) async {
    await _paymentRef.doc(paymentId).delete();
  }

  Future<void> setDefaultPaymentMethod(String paymentId) async {
    final batch = _firestore.batch();

    final snapshot = await _paymentRef.get();

    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {"isDefault": false});
    }

    batch.update(_paymentRef.doc(paymentId), {"isDefault": true});

    await batch.commit();
  }

  Future<PaymentMethodModel?> getDefaultPaymentMethod() async {
    final snapshot = await _paymentRef
        .where("isDefault", isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    return PaymentMethodModel.fromFirestore(snapshot.docs.first);
  }
}
