import 'package:{{name.snakeCase()}}/core/presentation/theme/palette.dart';
import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  // Semantics
  Color get success => Palette.success;
  Color get warning => Palette.warning;
  Color get darkSurface => Palette.darkSurface;
  Color get lightSurface => Palette.lightSurface;

  // Variants
  Color get neutral100 => Palette.neutral100;
  Color get neutral200 => Palette.neutral200;
  Color get neutral300 => Palette.neutral300;
  Color get neutral400 => Palette.neutral400;
  Color get neutral500 => Palette.neutral500;
  Color get primary100 => Palette.primary100;
  Color get primary200 => Palette.primary200;
  Color get primary300 => Palette.primary300;
  Color get primary400 => Palette.primary400;
  Color get primary500 => Palette.primary500;
  Color get secondary100 => Palette.secondary100;
  Color get secondary200 => Palette.secondary200;
  Color get secondary300 => Palette.secondary300;
  Color get secondary400 => Palette.secondary400;
  Color get secondary500 => Palette.secondary500;

  // On Background
  Color get onWarning => Palette.onWarning;
  Color get onSuccess => Palette.onSuccess;
  Color get onNeutral => Palette.onNeutral;
  Color get onDarkSurface => Palette.onDarkSurface;
  Color get onLightSurface => Palette.onLightSurface;
}
