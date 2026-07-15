import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signinProvider = AsyncNotifierProvider<SignInController, UserModel?>(
  SignInController.new,
);

class SignInController extends AsyncNotifier<UserModel?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWIthEmailAndPassword(
    String email,
    String password,
  ) async {
    state = const AsyncLoading();
    EasyLoading.show(status: "Signing in...");

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user!;

      // সর্বশেষ verification status আনো
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser!;

      // Email verify না হলে login করতে দিও না
      if (!refreshedUser.emailVerified) {
        await _auth.signOut();

        throw FirebaseAuthException(
          code: "email-not-verified",
          message: "Please verify your email first.",
        );
      }

      final doc = await _firestore
          .collection("users")
          .doc(refreshedUser.uid)
          .get();

      if (!doc.exists) {
        throw Exception("User data not found");
      }

      final userModel = UserModel.fromMap(doc.data()!);

      state = AsyncData(userModel);

      return userCredential;
    } on FirebaseAuthException catch (e, stack) {
      state = AsyncError(e, stack);
      debugPrint("Sign in error: ${e.code} - ${e.message}");
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  FutureOr<UserModel?> build() {
    // TODO: implement build
    return null;
  }
}
