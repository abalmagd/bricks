import 'package:{{name.snakeCase()}}/core/presentation/providers/theme_provider.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Shimmer extends ConsumerWidget {
  const Shimmer({super.key, this.width, this.height, this.radius = 6});

  final double? width, height;
  final double radius;

  FadeTheme getFadeTheme(WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return themeMode == ThemeMode.dark ? FadeTheme.dark : FadeTheme.light;
  }
}

class TextShimmer extends Shimmer {
  const TextShimmer({super.key, super.width, super.height, super.radius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FadeShimmer(
      height: height ?? 20,
      width: width ?? double.infinity,
      fadeTheme: getFadeTheme(ref),
      radius: radius,
    );
  }
}

class RectShimmer extends Shimmer {
  const RectShimmer({super.key, super.width, super.height, super.radius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FadeShimmer(
          height: height ?? constraints.maxHeight,
          width: width ?? constraints.maxWidth,
          fadeTheme: getFadeTheme(ref),
          radius: radius,
        );
      },
    );
  }
}

class ButtonShimmer extends Shimmer {
  const ButtonShimmer({super.key, super.radius, super.width, super.height});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FadeShimmer(
      width: width ?? double.infinity,
      height: height ?? 52,
      fadeTheme: getFadeTheme(ref),
      radius: radius,
    );
  }
}

class CircularShimmer extends Shimmer {
  const CircularShimmer({super.key, super.radius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FadeShimmer.round(
      fadeTheme: getFadeTheme(ref),
      size: radius,
    );
  }
}

class BorderShimmer extends Shimmer {
  const BorderShimmer({
    super.key,
    super.width,
    super.height,
    super.radius,
    this.surfaceColor,
  });

  final Color? surfaceColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderThickness = 4.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;
        return Stack(
          alignment: Alignment.center,
          children: [
            FadeShimmer(
              height: height ?? maxHeight,
              width: width ?? maxWidth,
              fadeTheme: getFadeTheme(ref),
              radius: radius,
            ),
            Container(
              height: (height ?? maxHeight) - borderThickness,
              width: (width ?? maxWidth) - borderThickness,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: surfaceColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
