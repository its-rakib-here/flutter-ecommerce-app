import 'package:e_commerce/controllers/sign_up_controller.dart';
import 'package:e_commerce/widgets/auth_button.dart';
import 'package:e_commerce/widgets/auth_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../utills/app_constant.dart';
import 'login_in_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    ref.listenManual(signUpProvider, (previous, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Verification Email send.please check you Email"),
              ),
            );

            FirebaseAuth.instance.signOut();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginInScreen()),
            );
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          debugPrint(error.toString());
          if (error is FirebaseAuthException) {
            String message;
            switch (error.code) {
              case 'email-already-in-use':
                message = "This email is alrady registerd";
                break;
              case 'weak-password':
                message = "Password should be at least 6 characters.";
                break;

              case 'invalid-email':
                message = "Please enter a valid email address.";
                break;

              default:
                message = error.message ?? "Something went wrong.";
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
        },
      );
    });
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: AppConstants.secondaryColor,
          appBar: AppBar(
            backgroundColor: AppConstants.primaryColor,
            title: Text("Sign In "),
          ),

          body: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    isKeyboardVisible
                        ? Text("Please sign up with your credentials")
                        : Lottie.asset("assets/images/Login.json"),

                    AuthTextField(
                      controller: name,
                      hintText: "Enter your Name",
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: 15),

                    AuthTextField(
                      controller: email,
                      hintText: "Enter your Email",
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: 15),
                    AuthTextField(
                      controller: phone,
                      hintText: "Enter your Number",
                      prefixIcon: Icons.phone,
                      obscureText: false,
                    ),
                    SizedBox(height: 15),
                    AuthTextField(
                      controller: city,
                      hintText: "Enter your City",
                      prefixIcon: Icons.lock_outline,
                      obscureText: false,
                    ),

                    SizedBox(height: 15),
                    AuthTextField(
                      controller: password,
                      hintText: "Enter your Password",
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    SizedBox(height: 15),

                    AuthButton(
                      text: "Create Account",

                      // isLoading: signUpState.isLoading,
                      onPressed: () {
                        if (name.text.isEmpty ||
                            email.text.isEmpty ||
                            password.text.isEmpty ||
                            phone.text.isEmpty ||
                            city.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill all the fields"),
                            ),
                          );
                          return;
                        } else {
                          ref
                              .read(signUpProvider.notifier)
                              .signUPWithEmailAndPassword(
                                email.text.trim(),
                                password.text.trim(),
                                name.text.trim(),
                                phone.text.trim(),
                                city.text.trim(),
                                "",
                              );
                        }
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: AppConstants.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: AppConstants.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (signUpState.isLoading)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppConstants.secondaryColor,
                        child: Center(
                          child: Lottie.asset("assets/images/loading.json"),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
