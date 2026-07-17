import 'package:e_commerce/utills/app_constant.dart';
import 'package:flutter/material.dart';

class HeadinWidgets extends StatelessWidget {
  final String headingTitle;
  final VoidCallback onTap;
  final String buttonText;

  const HeadinWidgets({
    super.key,
    required this.headingTitle,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppConstants.primaryLight,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppConstants.textPrimary,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
