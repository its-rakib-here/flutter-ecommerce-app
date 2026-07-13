import 'package:e_commerce/screens/auth_ui/sign_up_screen.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:e_commerce/widgets/auth_button.dart';
import 'package:e_commerce/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return KeyboardVisibilityBuilder(
      builder: (context, iskyeboardVisible) {
        return Scaffold(
          backgroundColor: AppConstants.secondaryColor,
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
                      onPressed: () {},
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
                AuthButton(text: "Login", onPressed: () {}),

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
