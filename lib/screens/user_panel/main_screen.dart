import 'package:e_commerce/utills/app_constant.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_drawer_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(
          "e-commerce",
          style: TextStyle(color: AppConstants.textPrimary),
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawerWidget(),
    );
  }
}
