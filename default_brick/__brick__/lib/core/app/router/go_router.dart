import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:{{name.snakeCase()}}/core/app/router/routes.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_config.dart';

final goRouterProvider = NotifierProvider<GoRouterController, GoRouter>(
  GoRouterController.new,
);

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

class GoRouterController extends Notifier<GoRouter> {
  @override
  GoRouter build() {
    return GoRouter(
      navigatorKey: ref.read(navigatorKeyProvider),
      observers: [SentryNavigatorObserver()],
      // TODO: Update initialLocation
      initialLocation: '/example',
      debugLogDiagnostics: FlavorConfig.instance.settings.enableLogging,
      routes: ref.read(routesProvider),
    );
  }
}
