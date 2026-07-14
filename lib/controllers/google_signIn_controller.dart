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
      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId:
            '1071534318503-564smi5jld6a9ginc1fjmhltj470dbid.apps.googleusercontent.com',
      );

      print("Google SignIn Initialized");

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      print("Selected Email: ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      print("ID Token: ${googleAuth.idToken}");
      // print("Access Token: ${googleAuth.accessToken}");

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      print("Signing into Firebase...");

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      print("Firebase Login Success");

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception("Firebase returned null user");
      }

      print("UID: ${user.uid}");
      print("Email: ${user.email}");

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

        print("User saved to Firestore");
      } else {
        print("User already exists");
      }

      state = AsyncData(userModel);
    } catch (e, stack) {
      print("================ ERROR ================");
      print(e);
      print(stack);
      print("======================================");

      state = AsyncError(e, stack);
    }
  }
}
