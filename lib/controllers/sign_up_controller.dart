import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/notification_service.dart';

final signUpProvider = AsyncNotifierProvider<SignUpController, UserModel?>(
  SignUpController.new,
);

class SignUpController extends AsyncNotifier<UserModel?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signUPWithEmailAndPassword(
    String email,
    String password,
    String username,
    String phone,
    String city,
    String userDeviceToken,
  ) async {
    state = const AsyncLoading();
    EasyLoading.show(status: "Signing in...");

    try {
      final deviceToken = await NotificationService.getDeviceToken();
      debugPrint("device token:${deviceToken}");

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        username: username,
        email: email,
        phone: phone,
        userImg: "",
        userDeviceToken: deviceToken,
        country: "",
        userAddress: "",
        street: "",
        city: city,
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      state = AsyncData(userModel);
    } on FirebaseAuthException catch (e, stack) {
      state = AsyncError(e, stack);

      print("================ ERROR ================");
      print(e);
      print("======================================");
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
