import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, Colors.green, Icons.check_circle_rounded);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, Colors.red, Icons.error_rounded);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, Colors.blue, Icons.info_rounded);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message, Colors.orange, Icons.warning_amber_rounded);
  }

  static void _show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
          elevation: 6,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 3),
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
