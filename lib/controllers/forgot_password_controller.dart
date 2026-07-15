import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordProvider =
    AsyncNotifierProvider<ForgotPasswordController, void>(
      ForgotPasswordController.new,
    );

class ForgotPasswordController extends AsyncNotifier<void> {
  Future<void> resetPassword(String email) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    state = const AsyncLoading();
    EasyLoading.show(status: "Sending email... ");
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: email.trim())
          .limit(1)
          .get();
      if (result.docs.isEmpty) {
        throw FirebaseAuthException(
          code: "user-not-found",
          message: "No account found with this email.",
        );
      }

      await _auth.sendPasswordResetEmail(email: email.trim());
      state = const AsyncData(null);
    } on FirebaseAuthException catch (e, stack) {
      state = AsyncError(e, stack);
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  FutureOr<dynamic> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}
