import 'dart:async';

import 'package:e_commerce/screens/auth_ui/auth_gate.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // User? user = FirebaseAuth.instance.currentUser;
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthGate()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      appBar: AppBar(backgroundColor: AppConstants.primaryColor, elevation: 0),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: size.width,
                alignment: Alignment.center,

                child: Lottie.asset('assets/images/splash.json'),
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: size.width,
              alignment: Alignment.center,
              child: Text(
                AppConstants.appCreatedBy,
                style: TextStyle(
                  color: AppConstants.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
