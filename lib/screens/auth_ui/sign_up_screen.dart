import 'package:e_commerce/widgets/auth_button.dart';
import 'package:e_commerce/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

import '../../utills/app_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          backgroundColor: AppConstants.secondaryColor,
          appBar: AppBar(
            backgroundColor: AppConstants.primaryColor,
            title: Text("Sign In "),
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                isKeyboardVisible
                    ? Text("Please sign in with your credentials")
                    : Lottie.asset("assets/images/Login.json"),

                SizedBox(height: 20),

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
                  controller: password,
                  hintText: "Enter your Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                SizedBox(height: 15),

                SizedBox(height: 15),

                AuthButton(text: "Create Account", onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}
