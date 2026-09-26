import 'package:test_journal/core/presentation/providers/app_lifecycle_effect_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppLifecycleWrapper extends HookConsumerWidget {
  final Widget app;

  const AppLifecycleWrapper({
    required this.app,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useOnAppLifecycleStateChange((prev, next) {
      ref.read(appLifecycleEffectProvider.notifier).handleLifeCycleState(next);
    });
    return app;
  }
}
