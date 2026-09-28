# 0.4.0

- **MCP server** — Added `.mcp.json` pre-configured with the `flutter-skill` MCP server. `post_gen.dart` now installs `flutter-skill` globally via `npm install -g flutter-skill` if not already on the PATH (non-fatal warn if npm is unavailable).
- **`flutter_skill` dependency** — Added `flutter_skill: ^0.9.37` to `dev_dependencies` in the generated `pubspec.yaml`.

# 0.3.0

- **Core datasource + repository** — Added `CoreDatasource` (`core/data/core_datasource.dart`) and `CoreRepository` (`core/domain/repositories/core_repository.dart`). `CoreDatasource implements CoreRepository` and wraps the available clients (`DioClient`, `FirestoreManager`, `StorageController`) behind Mustache conditionals. Feature datasources inject `coreDatasourceProvider` for shared remote and local access.
- **Example feature — naming alignment** — Renamed `i_example_repository.dart` → `example_repository.dart` (interface `IExampleRepository` → `ExampleRepository`); renamed `example_repository.dart` → `example_datasource.dart` (implementation `ExampleRepository` → `ExampleDatasource`). `ExampleDatasource implements ExampleRepository`; provider renamed to `exampleDatasourceProvider`.

# 0.2.0

- **Failure types** — Added `UnknownFailure`, `AppFailure`, `NetworkFailure`, and `FirebaseFailure` subclasses. `UnknownFailure` has localized static defaults and a no-arg constructor; the other types accept optional `type`/`message`.
- **Error handling** — `_handleError` in `DioClient` and `FirestoreManager` now accepts `Object`, matches on the specific exception type internally, and returns `Left<Failure, Never>`. All try/catch blocks collapsed to a single `catch (e) { return _handleError(e); }`.
- **Firebase** — `post_gen.dart` now prompts before running `flutterfire configure`. If skipped, a placeholder `lib/firebase_options.dart` is generated to keep the project compilable.
- **Splash assets** — Added `assets/images/logo-dark.png` and `assets/images/logo-light.png` placeholder images. `flutter_native_splash.yaml` updated to `logo-{theme}` naming and platform flags now reflect only the platforms chosen at generation time.
- **Example feature** — `lib/features/example/` scaffold included in every generated project, demonstrating the three-layer architecture: domain model + repository interface, data implementation, `NotifierProvider` + `Notifier`, and a `HookConsumerWidget` screen.
- **Agent skills** — Added `.agents/skills/` with 35 curated skill modules across `dart/`, `flutter/`, and `riverpod/` categories, aligned to the brick's stack (easy_localization, Dio, GoRouter, Riverpod 3.x, HookConsumerWidget).

# 0.1.0+1

- Initial release of the `default_brick` Flutter project Mason template.
- Generates a Flutter project scaffold with clean architecture (presentation / domain / data layers).
- Includes Riverpod + Flutter Hooks state management, GoRouter navigation, Sentry crash reporting, and EasyLocalization.
- Provides dev and prod flavor configurations via `FlavorConfig` singleton with per-flavor `FlavorSettings`.
- Includes `StorageController` wrapping `SharedPreferences` and `FlutterSecureStorage` for typed local storage.
- Material Design 3 theming with `Palette`, `CustomTextTheme`, and `ColorScheme` extensions for semantic colors.
- `brick.yaml` variables: `name`, `bundle_id`, `platforms`, `use_remote`, `use_firebase`, `sentry_dsn`, `dev_base_url`, `prod_base_url`.
