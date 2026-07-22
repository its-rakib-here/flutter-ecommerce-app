import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
