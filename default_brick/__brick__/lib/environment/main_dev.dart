import 'package:flutter/material.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_config.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_settings.dart';
import 'package:{{name.snakeCase()}}/environment/main.dart';

void main() {
  FlavorConfig(
    name: 'Dev',
    settings: FlavorSettings(
      baseUrl: const String.fromEnvironment('DEV_BASE_URL'),
      enableLogging: true,
      type: FlavorType.dev,
    ),
    color: Colors.green,
    location: BannerLocation.bottomEnd,
  );

  return app();
}
