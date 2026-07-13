import 'package:e_commerce/widgets/auth_button.dart';
import 'package:e_commerce/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

import '../../utills/app_constant.dart';
import 'login_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();

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
                  obscureText: true,
                ),
                SizedBox(height: 15),
                AuthTextField(
                  controller: city,
                  hintText: "Enter your City",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),

                SizedBox(height: 15),
                AuthTextField(
                  controller: password,
                  hintText: "Enter your Password",
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),

                SizedBox(height: 15),

                AuthButton(text: "Create Account", onPressed: () {}),

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
              ],
            ),
          ),
        );
      },
    );
  }
}
