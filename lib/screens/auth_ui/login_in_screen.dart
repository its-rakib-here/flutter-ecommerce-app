import 'package:e_commerce/controllers/sign_in_controller.dart';
import 'package:e_commerce/screens/auth_ui/sign_up_screen.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:e_commerce/widgets/auth_button.dart';
import 'package:e_commerce/widgets/auth_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'auth_gate.dart';
import 'forgot_password_screen.dart';

class LoginInScreen extends ConsumerStatefulWidget {
  const LoginInScreen({super.key});

  @override
  ConsumerState<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends ConsumerState<LoginInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();

    ref.listenManual(signinProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AuthGate()),
            );
          }
        },
        error: (error, stackTrace) {
          String message = "Something went wrong";

          if (error is FirebaseAuthException) {
            switch (error.code) {
              case "email-not-verified":
                message = "Please verify your email before logging in.";
                break;

              case "wrong-password":
              case "invalid-credential":
                message = "Invalid email or password.";
                break;

              case "user-not-found":
                message = "No account found with this email.";
                break;

              default:
                message = error.message ?? "Login failed";
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
          backgroundColor: AppConstants.primaryColor,
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
                AuthTextField(
                  controller: password,
                  hintText: "Enter Your Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassowrd(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.01),
                AuthButton(
                  text: "Login",
                  onPressed: signInState.isLoading
                      ? () {}
                      : () {
                          if (email.text.trim().isEmpty ||
                              password.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill all the fields"),
                              ),
                            );
                            return;
                          }
                          ref
                              .read(signinProvider.notifier)
                              .signInWIthEmailAndPassword(
                                email.text.trim(),
                                password.text.trim(),
                              );
                        },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppConstants.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
