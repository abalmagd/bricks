import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:{{name.snakeCase()}}/core/presentation/theme/palette.dart';
import 'package:{{name.snakeCase()}}/core/presentation/theme/text_theme.dart';

base mixin CustomTheme {
  static ThemeData _properties(BuildContext context, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final surfaceText = isDark ? Palette.onDarkSurface : Palette.onLightSurface;
    final locale = context.locale;
    final isRTL = Bidi.isRtlLanguage(locale.languageCode);
    final textTheme = CustomTextTheme.textTheme.apply(
      fontFamily: isRTL ? 'Cairo' : 'Roboto',
      bodyColor: surfaceText,
      displayColor: surfaceText,
    );
    final inputBorderRadius = BorderRadius.circular(12);
    return ThemeData(
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        surface: isDark ? Palette.darkSurface : Palette.lightSurface,
        inverseSurface: isDark ? Palette.lightSurface : Palette.darkSurface,
        onInverseSurface: isDark
            ? Palette.onLightSurface
            : Palette.onDarkSurface,
        seedColor: Palette.primary,
        primary: Palette.primary,
        secondary: Palette.secondary,
        onPrimary: Palette.onPrimary,
        onSecondary: Palette.onSecondary,
        error: Palette.error,
        brightness: brightness,
      ),
      dividerTheme: const DividerThemeData(
        color: Palette.neutral300,
        space: 0,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Palette.neutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Palette.neutral200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Palette.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Palette.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: inputBorderRadius,
          borderSide: const BorderSide(color: Palette.primary),
        ),
        hintStyle: textTheme.labelSmall?.copyWith(color: Palette.neutral500),
        prefixIconConstraints: const BoxConstraints(),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
      ),
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: isDark ? Palette.darkSurface : Palette.lightSurface,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      iconTheme: IconThemeData(color: surfaceText),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: surfaceText),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: Palette.primary,
        selectedLabelStyle: textTheme.labelMedium,
        unselectedLabelStyle: textTheme.labelMedium,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ThemeData lightTheme(BuildContext context) =>
      _properties(context, Brightness.light);

  ThemeData darkTheme(BuildContext context) =>
      _properties(context, Brightness.dark);
}
