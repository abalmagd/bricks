import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:toastification/toastification.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_config.dart';

mixin Alerts {
  static void debugLog({
    required String message,
    Level level = Level.info,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final showLogs = FlavorConfig.instance.settings.enableLogging;
    if (!showLogs) return;
    Logger(
      printer: PrettyPrinter(),
    ).log(level, message, error: error, stackTrace: stackTrace);
  }

  static void showToast({
    required String message,
    String? description,
    ToastificationType severity = ToastificationType.info,
    Duration? autoCloseDuration,
    Alignment? alignment,
  }) {
    toastification.show(
      type: severity,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 5),
      description: description == null ? null : Text(description, maxLines: 3),
      title: Text(message, maxLines: 3),
      alignment: alignment,
    );
  }
}
