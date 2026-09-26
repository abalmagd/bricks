import 'package:flutter/material.dart';

/// App color palette. Access colors via [Theme.of(context).colorScheme] or
/// the [CustomColorScheme] extension — avoid using [Palette] directly in UI.
sealed class Palette {
  // Main
  static const primary = Color(0xffF48E2A);
  static const secondary = Color(0xff6966FF);

  // On Background
  static const onPrimary = Colors.white;
  static const onSecondary = Colors.white;
  static const onSuccess = Colors.white;
  static const onWarning = Colors.black;
  static const onError = Colors.black;
  static const onNeutral = Colors.black;

  // Semantic
  static const error = Color(0xffEF4D24);
  static const warning = Color(0xffD67507);
  static const success = Color(0xff23A15D);

  // Dark Theme
  static const darkSurface = Colors.black;
  static const onDarkSurface = Colors.white;

  // Light Theme
  static const lightSurface = Colors.white;
  static const onLightSurface = Colors.black;

  // Variants
  static const primary100 = Color(0xFFF8B877);
  static const primary200 = Color(0xFFF8B877);
  static const primary300 = Color(0xFFF8B877);
  static const primary400 = Color(0xFFF6A351);
  static const primary500 = primary;

  static const secondary100 = Color(0xFFAFADFF);
  static const secondary200 = Color(0xFFAFADFF);
  static const secondary300 = Color(0xFFAFADFF);
  static const secondary400 = Color(0xFF9B99FF);
  static const secondary500 = secondary;

  static const neutral100 = Color(0xffF8F8F8);
  static const neutral200 = Color(0xffE6E6E6);
  static const neutral300 = Color(0xffD5D5D5);
  static const neutral400 = Color(0xffB1B1B1);
  static const neutral500 = Color(0xffA0A0A0);
}
