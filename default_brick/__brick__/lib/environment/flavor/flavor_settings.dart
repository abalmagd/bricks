enum FlavorType { dev, demo, prod }

class FlavorSettings {
  final String baseUrl;
  final bool enableLogging;
  final FlavorType type;

  FlavorSettings({
    required this.baseUrl,
    required this.enableLogging,
    required this.type,
  });
}
