import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:{{name.snakeCase()}}/core/app/localization/locale_keys.dart';
import 'package:{{name.snakeCase()}}/core/app/utils/core.dart';
import 'package:{{name.snakeCase()}}/core/presentation/providers/theme_provider.dart';
import 'package:{{name.snakeCase()}}/core/presentation/widgets/app_lifecycle_wrapper.dart';

import 'package:{{name.snakeCase()}}/core/app/router/go_router.dart';
import 'package:{{name.snakeCase()}}/core/presentation/theme/custom_theme.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_config.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_settings.dart';

void app() async {
  await Core.initApp();

  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment('SENTRY_DSN');
      options.attachScreenshot = true;
      options.enableLogs = true;
      options.attachThreads = true;
      options.sendClientReports = true;
      options.sendDefaultPii = true;
      options.enableAppHangTracking = false;
      options.privacy.maskAllImages = false;
      options.privacy.maskAllText = false;
      options.privacy.maskAssetImages = false;
    },
    appRunner: () async {
      final app = await Core.appRunner();
      runApp(app);
      FlutterNativeSplash.remove();
    },
  );
}

final class {{name.pascalCase()}} extends ConsumerWidget with CustomTheme {
  const {{name.pascalCase()}}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastificationWrapper(
      child: AppLifecycleWrapper(
        app: MaterialApp.router(
          title: LocaleKeys.app_name.tr(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          darkTheme: darkTheme(context),
          themeMode: ref.watch(themeProvider),
          routerConfig: ref.watch(goRouterProvider),
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(),
          ),
          builder: (context, child) {
            final flavor = FlavorConfig.instance;
            if (flavor.settings.type == FlavorType.prod) return child!;
            return Banner(
              message: flavor.name,
              location: flavor.location,
              color: flavor.color,
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
