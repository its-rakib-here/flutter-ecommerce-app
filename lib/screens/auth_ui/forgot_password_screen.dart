import 'package:e_commerce/controllers/sign_in_controller.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:e_commerce/widgets/auth_button.dart';
import 'package:e_commerce/widgets/auth_text_field.dart';
import 'package:e_commerce/widgets/custom_snacbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/forgot_password_controller.dart';

class ForgotPassowrd extends ConsumerStatefulWidget {
  const ForgotPassowrd({super.key});

  @override
  ConsumerState<ForgotPassowrd> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends ConsumerState<ForgotPassowrd> {
  TextEditingController email = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();

    ref.listenManual(forgotPasswordProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password reset email has been sent."),
            ),
          );

          Navigator.pop(context);
        },

        error: (error, stack) {
          String message = "Something went wrong";

          if (error is FirebaseAuthException) {
            switch (error.code) {
              case "user-not-found":
                message = "No account found with this email.";
                break;

              case "invalid-email":
                message = "Please enter a valid email.";
                break;

              default:
                message = error.message ?? message;
            }
          }

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signinProvider);
    final size = MediaQuery.of(context).size;
    return KeyboardVisibilityBuilder(
      builder: (context, iskyeboardVisible) {
        return Scaffold(
          backgroundColor: AppConstants.textPrimary,
          appBar: AppBar(
            title: Text("Wellcome Back"),
            centerTitle: true,
            backgroundColor: AppConstants.primaryColor,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                iskyeboardVisible
                    ? Text("Please sign in with your credentials")
                    : Lottie.asset("assets/images/Login.json"),

                SizedBox(height: size.height * 0.02),
                AuthTextField(
                  controller: email,
                  hintText: "Enter Your Email",
                  prefixIcon: Icons.email_outlined,
                ),
                SizedBox(height: size.height * 0.03),

                AuthButton(
                  text: " Forgot ",
                  onPressed: () {
                    if (email == null) {
                      CustomSnackBar.showWarning(
                        context,
                        "Please fill all the fields.",
                      );
                    } else {
                      ref
                          .read(forgotPasswordProvider.notifier)
                          .resetPassword(email.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
