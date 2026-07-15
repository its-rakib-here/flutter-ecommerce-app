import 'package:e_commerce/utills/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_ui/wellcome_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(AppConstants.appName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth _auth = FirebaseAuth.instance;
              _auth.signOut();
              GoogleSignIn googleSignIn = GoogleSignIn.instance;

              googleSignIn.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WellcomeScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
