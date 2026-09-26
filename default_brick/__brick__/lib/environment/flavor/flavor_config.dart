import 'package:flutter/material.dart';
import 'package:test_journal/environment/flavor/flavor_settings.dart';

/// This class is used to configure the flavor of the app.
/// It is used to set the name of the flavor, the color of the banner,
/// the location of the banner, and the settings of the flavor.
class FlavorConfig {
  /// Name of flavor
  final String name;

  /// Color of the banner
  final Color color;

  /// Location of the banner
  final BannerLocation location;

  /// Settings
  final FlavorSettings settings;

  /// Private constructor
  FlavorConfig._internal(this.name, this.color, this.location, this.settings);

  /// Internal instance of FlavorConfig
  static late FlavorConfig _instance;

  /// Instance of FlavorConfig
  static FlavorConfig get instance => _instance;

  /// Factory constructor
  factory FlavorConfig({
    required String name,
    required FlavorSettings settings,
    Color color = Colors.red,
    BannerLocation location = BannerLocation.topStart,
  }) {
    _instance = FlavorConfig._internal(
      name,
      color,
      location,
      settings,
    );

    return _instance;
  }
}
