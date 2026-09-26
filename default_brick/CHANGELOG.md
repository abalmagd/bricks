# 0.1.0+1

- Initial release of the `default_brick` Flutter project Mason template.
- Generates a Flutter project scaffold with clean architecture (presentation / domain / data layers).
- Includes Riverpod + Flutter Hooks state management, GoRouter navigation, Sentry crash reporting, and EasyLocalization.
- Provides dev and prod flavor configurations via `FlavorConfig` singleton with per-flavor `FlavorSettings`.
- Includes `StorageController` wrapping `SharedPreferences` and `FlutterSecureStorage` for typed local storage.
- Material Design 3 theming with `Palette`, `CustomTextTheme`, and `ColorScheme` extensions for semantic colors.
- `brick.yaml` variables: `name`, `bundle_id`, `platforms`, `use_remote`, `use_firebase`, `sentry_dsn`, `dev_base_url`, `prod_base_url`.
