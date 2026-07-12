import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "E-Commerce";
  static const String appCreatedBy = "Created by: Rakib";

  // Brand Colors — keep indigo as the "brand" identity color (app bar, links, selected nav)
  static const Color primaryColor = Color(0xFF5B67F1);
  static const Color secondaryColor = Color(0xFF8B93F8);

  // Give the orange a real job: it IS the buy/CTA color now
  static const Color accentColor = Color(0xFFFF7A00);
  static const Color buttonColor = accentColor; // was primaryColor

  // Background
  static const Color backgroundColor = Color(0xFFF8F9FD);
  static const Color scaffoldColor = Colors.white;

  // Cards
  static const Color cardColor = Colors.white;

  // Text
  static const Color textPrimary = Color(0xFF1B1F24);
  static const Color textSecondary = Color(0xFF6C757D);

  // Icons
  static const Color iconColor = Color(0xFF1B1F24);

  // Status Colors — warning pulled toward amber/brown so it's visually distinct from accentColor
  static const Color successColor = Color(0xFF2ECC71);
  static const Color warningColor = Color(
    0xFFB8860B,
  ); // darker gold, passes contrast, no longer orange-adjacent
  static const Color errorColor = Color(0xFFE74C3C);

  // Borders & Divider
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color dividerColor = Color(0xFFF1F3F5);

  // Status Bar
  static const Color statusBarColor = Colors.white;
}
