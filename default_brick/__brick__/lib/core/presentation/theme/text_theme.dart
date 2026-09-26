import 'package:flutter/material.dart';

/// Predefined text styles. Access via [Theme.of(context).textTheme].
class CustomTextTheme {
  static TextTheme get textTheme => const TextTheme(
    //  Display
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    // Headline
    headlineLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
    // Title
    titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    // Body
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    // Label
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  );
}
