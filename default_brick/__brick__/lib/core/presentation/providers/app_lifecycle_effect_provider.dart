import 'dart:ui';

import 'package:{{name.snakeCase()}}/core/app/utils/alerts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appLifecycleEffectProvider =
    NotifierProvider<AppLifecycleEffectNotifier, void>(
      AppLifecycleEffectNotifier.new,
    );

class AppLifecycleEffectNotifier extends Notifier<void> {
  @override
  void build() {}

  void handleLifeCycleState(AppLifecycleState state) {
    Alerts.debugLog(message: 'App lifecycle state => $state');
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }
}
