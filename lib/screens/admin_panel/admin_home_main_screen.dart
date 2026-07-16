import 'package:e_commerce/screens/auth_ui/login_in_screen.dart';
import 'package:e_commerce/utills/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomeMainScreen extends StatefulWidget {
  const AdminHomeMainScreen({super.key});

  @override
  State<AdminHomeMainScreen> createState() => _AdminHomeMainScreenState();
}

class _AdminHomeMainScreenState extends State<AdminHomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin panel"),
        centerTitle: true,
        backgroundColor: AppConstants.primaryColor,
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth firebaseAuth = FirebaseAuth.instance;
              firebaseAuth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginInScreen()),
              );
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
