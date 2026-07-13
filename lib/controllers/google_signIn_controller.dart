import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider =
    AsyncNotifierProvider<GoogleSignInController, UserModel?>(
      GoogleSignInController.new,
    );

class GoogleSignInController extends AsyncNotifier<UserModel?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  FutureOr<UserModel?> build() {
    return null;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      // Start sign in
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Firebase login
      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        throw Exception("User is null");
      }

      final userModel = UserModel(
        uId: user.uid,
        username: user.displayName ?? "",
        email: user.email ?? "",
        phone: user.phoneNumber ?? "",
        userImg: user.photoURL ?? "",
        userDeviceToken: "",
        country: "",
        userAddress: "",
        street: "",
        city: "",
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      );

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) {
        await _firestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toMap());
      }

      state = AsyncData(userModel);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}
