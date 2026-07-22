import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cart_item_model.dart';

class FirestoreService {
  FirestoreService._();

  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  /// Add Favourite
  Future<void> addFavourite(String productId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favourites')
        .doc(productId)
        .set({'productId': productId, 'addedAt': FieldValue.serverTimestamp()});
  }

  /// Remove Favourite
  Future<void> removeFavourite(String productId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favourites')
        .doc(productId)
        .delete();
  }

  Stream<Set<String>> favouriteStream() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('favourites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toSet());
  }

  //add cart

  Future<void> addToCart(String productId) async {
    final docRef = _firestore
        .collection("users")
        .doc(_uid)
        .collection("cart")
        .doc(productId);

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({'quantity': FieldValue.increment(1)});
    } else {
      await docRef.set({
        'productId': productId,
        'quantity': 1,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> removeCartItem(String productId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .doc(productId)
        .delete();
  }

  Future<void> increaseQuantity(String productId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .doc(productId)
        .update({'quantity': FieldValue.increment(1)});
  }

  Stream<List<CartItemModel>> cartStream() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CartItemModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> decreaseQuantity(String productId) async {
    final docRef = _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .doc(productId);

    final snapshot = await docRef.get();

    if (!snapshot.exists) return;

    final quantity = snapshot['quantity'];

    if (quantity <= 1) {
      await docRef.delete();
    } else {
      await docRef.update({'quantity': FieldValue.increment(-1)});
    }
  }
}
