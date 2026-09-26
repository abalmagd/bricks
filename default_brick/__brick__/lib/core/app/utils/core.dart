import 'package:{{name.snakeCase()}}/core/app/constants/assets.dart';
import 'package:{{name.snakeCase()}}/core/app/localization/localization.dart';
import 'package:{{name.snakeCase()}}/core/data/local/local_storage.dart';
import 'package:{{name.snakeCase()}}/core/presentation/providers/provider_observer.dart';
import 'package:{{name.snakeCase()}}/environment/main.dart';
import 'package:{{name.snakeCase()}}/environment/flavor/flavor_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
{{#use_firebase}}
import 'package:firebase_core/firebase_core.dart';
import 'package:{{name.snakeCase()}}/firebase_options.dart';
{{/use_firebase}}

class Core {
  static Future<void> initApp() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await _initEasyLocalization();
    {{#use_firebase}}
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    {{/use_firebase}}
  }

  static Future<void> _initEasyLocalization() async {
    await EasyLocalization.ensureInitialized();
  }

  static Future<ProviderScope> appRunner() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final showLogs = FlavorConfig.instance.settings.enableLogging;

    return ProviderScope(
      overrides: [
        storageProvider.overrideWith(() => StorageController(sharedPrefs)),
      ],
      observers: showLogs ? [AppProviderObserver()] : null,
      child: SentryWidget(
        child: DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: EasyLocalization(
            supportedLocales: Localization.supportedLocales
                .map((locale) => locale.locale)
                .toList(),
            path: AssetPaths.translations,
            fallbackLocale: AppLocale.en.locale,
            useOnlyLangCode: true,
            child: const {{name.pascalCase()}}(),
          ),
        ),
      ),
    );
  }
}
