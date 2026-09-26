import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:logger/logger.dart';
import 'package:test_journal/core/app/utils/alerts.dart';

/// Logs provider lifecycle events (add, update, dispose, fail) during development.
base class AppProviderObserver extends ProviderObserver {
  final List<ProviderBase> _excludedProviders = [];

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    final provider = context.provider;
    Alerts.debugLog(
      message: '[Added] ${provider.name ?? provider.runtimeType} = $value',
      level: Level.info,
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (newValue is AsyncError) return;
    final provider = context.provider;
    if (_excludedProviders.contains(provider)) return;
    Alerts.debugLog(
      message:
          '[Updated] ${provider.name ?? provider.runtimeType}: $previousValue → $newValue',
      level: Level.trace,
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    final provider = context.provider;
    Alerts.debugLog(
      message: '[Disposed] ${provider.name ?? provider.runtimeType}',
      level: Level.warning,
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object? error,
    StackTrace stackTrace,
  ) {
    final provider = context.provider;
    Alerts.debugLog(
      message:
          '[Failed] ${provider.name ?? provider.runtimeType}: $error\n'
          '[Stack Trace] => $stackTrace',
      error: error,
      stackTrace: stackTrace,
      level: Level.error,
    );
  }
}
