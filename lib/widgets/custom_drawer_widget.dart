import 'package:e_commerce/utills/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/auth_ui/wellcome_screen.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.06),
      child: Drawer(
        backgroundColor: const Color(0xFFEEF2FF),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Rakib",
                  style: TextStyle(color: AppConstants.textPrimary),
                ),
                subtitle: Text(
                  "version 1.0",
                  style: TextStyle(color: AppConstants.textPrimary),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstants.secondaryColor,
                  child: Text("R"),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home"),
                leading: Icon(Icons.home),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Producst"),
                leading: Icon(Icons.production_quantity_limits),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Orders"),
                leading: Icon(Icons.shopping_bag),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Contact"),
                leading: Icon(Icons.contact_page),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
              child: ListTile(
                onTap: () {
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  _auth.signOut();
                  GoogleSignIn googleSignIn = GoogleSignIn.instance;

                  googleSignIn.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WellcomeScreen()),
                  );
                },

                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
