import 'package:{{name.snakeCase()}}/environment/flavor/flavor_config.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_settings.dart';
import 'package:{{name.snakeCase()}}/environment/main.dart';

void main() {
  FlavorConfig(
    name: 'Production',
    settings: FlavorSettings(
      baseUrl: const String.fromEnvironment('PROD_BASE_URL'),
      type: FlavorType.prod,
      enableLogging: false,
    ),
  );

  return app();
}
