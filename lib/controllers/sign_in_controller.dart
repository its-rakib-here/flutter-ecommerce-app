import 'dart:async';

import 'package:e_commerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signinProvider = AsyncNotifierProvider<SignInController, UserModel?>(
  SignInController.new,
);

class SignInController extends AsyncNotifier<UserModel?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWIthEmailAndPassword(
    String email,
    String password,
  ) async {
    try {} on FirebaseAuthException catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  @override
  FutureOr<UserModel> build() {
    // TODO: implement build
    return null;
  }
}
