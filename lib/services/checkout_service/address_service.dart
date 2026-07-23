import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/address_model.dart';

class AddressService {
  AddressService._();

  static final AddressService instance = AddressService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _addressRef =>
      _firestore.collection("users").doc(_uid).collection("addresses");

  /// Get all addresses
  Stream<List<AddressModel>> addressStream() {
    return _addressRef
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AddressModel.fromMap(doc.data()))
              .toList(),
        );
  }

  /// Add Address
  Future<void> addAddress(AddressModel address) async {
    final docRef = _addressRef.doc();

    final newAddress = address.copyWith(
      id: docRef.id,
      userId: _uid,
      createdAt: Timestamp.now(),
    );

    // If this is the default address,
    // remove default from all others first.
    if (newAddress.isDefault) {
      await _removeDefaultFromOthers();
    }

    await docRef.set(newAddress.toMap());
  }

  /// Update Address
  Future<void> updateAddress(AddressModel address) async {
    if (address.isDefault) {
      await _removeDefaultFromOthers();
    }

    await _addressRef.doc(address.id).update(address.toMap());
  }

  /// Delete Address
  Future<void> deleteAddress(String addressId) async {
    await _addressRef.doc(addressId).delete();
  }

  /// Set Default Address
  Future<void> setDefaultAddress(String addressId) async {
    final snapshot = await _addressRef.get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {"isDefault": false});
    }

    batch.update(_addressRef.doc(addressId), {"isDefault": true});

    await batch.commit();
  }

  /// Get Default Address
  Future<AddressModel?> getDefaultAddress() async {
    final snapshot = await _addressRef
        .where("isDefault", isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    return AddressModel.fromMap(snapshot.docs.first.data());
  }

  /// Remove Default Flag From Other Addresses
  Future<void> _removeDefaultFromOthers() async {
    final snapshot = await _addressRef
        .where("isDefault", isEqualTo: true)
        .get();

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {"isDefault": false});
    }

    await batch.commit();
  }
}
