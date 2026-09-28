# {{name.pascalCase()}} — Project Guide

## Stack

| Concern | Package |
|---|---|
| State management | `flutter_riverpod` + `hooks_riverpod` |
| Hooks | `flutter_hooks` |
| Navigation | `go_router` |
| Error handling | `dartz` (`Either<Failure, T>`) |
| Local storage | `shared_preferences` + `flutter_secure_storage` |
| Localization | `easy_localization` |
| Crash reporting | `sentry_flutter` |
| Theming | Material Design 3 |

---

## Architecture

Three layers per feature:

```
Presentation  →  Domain  →  Data
```

| Layer | Contains | Rule |
|---|---|---|
| **Presentation** | Screens, widgets, views, Riverpod providers | No business logic; calls notifier methods only |
| **Domain** | Models, use-cases | Pure Dart — no Flutter or network imports |
| **Data** | Repositories | Fetches and persists data; returns `Either<Failure, T>` |

> **No `StatefulWidget` or `ConsumerStatefulWidget`** — use `HookConsumerWidget` with `flutter_hooks` instead.

---

## Directory Structure

```
lib/
├── environment/               # App entry points & flavor config
│   ├── main.dart              # App entry function (app()) + Sentry init
│   ├── main_dev.dart          # Dev flavor entry point
│   ├── main_prod.dart         # Prod flavor entry point
│   └── flavor/
│       ├── flavor_config.dart # FlavorConfig singleton (baseUrl, logging, banner)
│       └── flavor_settings.dart # FlavorType enum: dev | prod
│
├── core/
│   ├── app/
│   │   ├── constants/
│   │   │   ├── assets.dart        # AssetPaths, ImageAssets, IconAssets
│   │   │   └── constants.dart     # App-wide constants
│   │   ├── error/
│   │   │   └── failure.dart       # Failure model (custom factory, toast)
│   │   ├── localization/
│   │   │   ├── locale_keys.dart   # Type-safe translation keys
│   │   │   └── localization.dart  # AppLocale enum + supportedLocales list
│   │   ├── router/
│   │   │   ├── go_router.dart     # GoRouterController (NotifierProvider<GoRouter>)
│   │   │   └── routes.dart        # routesProvider — add new GoRoute entries here
│   │   └── utils/
│   │       ├── alerts.dart        # Alerts mixin: debugLog(), showToast()
│   │       └── core.dart          # Core.initApp() + Core.appRunner() — app bootstrap
│   │
│   ├── data/
│   │   ├── core_datasource.dart   # CoreDatasource — wraps DioClient / FirestoreManager / StorageController
│   │   ├── local/
│   │   │   ├── local_storage.dart # StorageController: setPrefs<T>(), getPrefs<T>(), setSecured(), getSecured()
│   │   │   ├── shared_prefs.dart  # storageProvider (NotifierProvider<StorageController>)
│   │   │   └── storage_keys.dart  # StorageKeys enum — add new keys here
│   ├── domain/
│   │   ├── models/                # Shared domain models go here
│   │   └── repositories/
│   │       └── core_repository.dart  # CoreRepository — abstract interface for shared data access
│   │
│   └── presentation/
│       ├── providers/
│       │   ├── theme_provider.dart              # ThemeController — changeThemeMode(), persists to SharedPrefs
│       │   ├── app_lifecycle_effect_provider.dart # Tracks AppLifecycleState changes
│       │   └── provider_observer.dart           # AppProviderObserver — logs provider events (dev only)
│       ├── screens/               # Feature screens go here
│       ├── theme/
│       │   ├── custom_theme.dart                # CustomTheme mixin — lightTheme, darkTheme
│       │   ├── palette.dart                     # Palette sealed class — color constants
│       │   ├── text_theme.dart                  # CustomTextTheme — predefined text styles
│       │   └── color_scheme_extension.dart      # ColorScheme extension — semantic color getters
│       └── widgets/
│           ├── shimmers.dart                    # Loading skeleton widgets
│           ├── app_lifecycle_wrapper.dart        # Wrap root widget to observe lifecycle events
│           ├── locale_switch.dart               # Language toggle button
│           └── theme_switch.dart                # Theme mode toggle button
│
└── features/                  # Feature modules — one folder per feature
```

---

## State Management (Riverpod + Hooks)

### Widget base classes

| Class | When to use |
|---|---|
| `HookConsumerWidget` | Any screen or widget that reads providers or uses hooks |
| `ConsumerWidget` | Widgets that only read providers, no local state needed |
| `HookWidget` | Widgets that use hooks but don't read providers |
| `StatelessWidget` | Pure UI with no state or providers |

**Never use `StatefulWidget`, `ConsumerStatefulWidget`, or `State<T>`.**

### HookConsumerWidget pattern

```dart
class MyScreen extends HookConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hooks for local state — replaces StatefulWidget fields
    final controller = useTextEditingController();
    final scrollController = useScrollController();
    final isFocused = useState(false);

    // Riverpod — watch providers
    final data = ref.watch(myProvider);

    return Scaffold(...);
  }
}
```

### Common hooks

| Hook | Replaces |
|---|---|
| `useTextEditingController()` | `TextEditingController` + `dispose()` |
| `useScrollController()` | `ScrollController` + `dispose()` |
| `useAnimationController(...)` | `AnimationController` + `dispose()` |
| `useState<T>(initial)` | `setState` for simple local values |
| `useMemoized(() => value, [keys])` | `initState` one-time initialisation |
| `useEffect(() { ... }, [keys])` | `initState` / `didUpdateWidget` side effects |

### Provider types

| Type | When to use |
|---|---|
| `NotifierProvider` | Mutable state with methods (screens, flows) |
| `Provider` | Read-only values, repository singletons |
| `Provider.autoDispose` | Scoped state freed when widget is removed |

### Dependency injection

Providers act as the DI container, chained bottom-up:

```dart
// Data layer
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserDataSource(),
);

// Presentation layer
final userProvider = NotifierProvider<UserNotifier, User?>(UserNotifier.new);

class UserNotifier extends Notifier<User?> with Alerts {
  @override
  User? build() => null;

  Future<void> loadUser({required String id}) async {
    final result = await ref.read(userRepositoryProvider).getUser(id: id);
    result.fold((failure) => failure.toast(), (user) => state = user);
  }
}
```

### Caching auto-dispose providers

```dart
final myProvider = Provider.autoDispose<Foo>((ref) {
  ref.cacheFor(const Duration(minutes: 5));
  return Foo();
});
```

---

## Error Handling

`Failure` ([lib/core/app/error/failure.dart](lib/core/app/error/failure.dart)) is the single error type across all layers. Use the most specific subclass from [lib/core/app/error/failure_types.dart](lib/core/app/error/failure_types.dart):

| Class | When to use |
|---|---|
| `AppFailure` | Business logic / validation errors |
| `NetworkFailure` | HTTP / Dio errors (emitted by `DioClient`) |
| `FirebaseFailure` | Firestore / Firebase errors (emitted by `FirestoreManager`) |
| `UnknownFailure` | Unexpected exceptions; no-arg constructor, localized defaults |

| Factory | Source |
|---|---|
| `Failure.custom(type, message)` | Any manual inline error |

Call `failure.toast()` to show an error toast to the user.

---

## Local Storage

`StorageController` ([lib/core/data/local/local_storage.dart](lib/core/data/local/local_storage.dart)):

```dart
// SharedPreferences — non-sensitive data
_storage.setPrefs<bool>(key: StorageKeys.themeMode.name, value: true);
_storage.getPrefs<bool>(key: StorageKeys.themeMode.name); // bool?

// FlutterSecureStorage — tokens and sensitive data
_storage.setSecured(key: StorageKeys.authToken.name, value: token);
await _storage.getSecured(key: StorageKeys.authToken.name); // String?
```

Add keys to `StorageKeys` enum in [lib/core/data/local/storage_keys.dart](lib/core/data/local/storage_keys.dart).

---

## Remote Data

### Dio (`use_remote: true`)

`DioClient` ([lib/core/data/remote/dio_manager.dart](lib/core/data/remote/dio_manager.dart)) — pre-configured HTTP client with base URL, timeouts, and optional logging.

```dart
// Inject via Riverpod
final client = ref.read(dioProvider);

// All methods return Either<Failure, T>
final result = await client.get<User>(
  '/users/1',
  fromJson: User.fromJson,
);

result.fold(
  (failure) => failure.toast(),
  (user) => state = user,
);
```

Available methods: `get`, `post`, `put`, `patch`, `delete`.

### Firestore (`use_firebase: true`)

`FirestoreManager` ([lib/core/data/remote/firebase_manager.dart](lib/core/data/remote/firebase_manager.dart)) — typed Firestore wrapper.

> **Setup required:** run `flutterfire configure` to generate `lib/firebase_options.dart` before building.

```dart
final firestore = ref.read(firestoreProvider);

// Read a document
final result = await firestore.getDocument<User>(
  path: 'users/uid',
  fromJson: User.fromJson,
);

// Write / update / delete
await firestore.setDocument(path: 'users/uid', data: user.toJson());
await firestore.updateDocument(path: 'users/uid', data: {'name': 'Alice'});
await firestore.deleteDocument(path: 'users/uid');

// Stream a collection
firestore.streamCollection<User>(
  path: 'users',
  fromJson: User.fromJson,
).listen((either) => either.fold((f) => f.toast(), (users) => state = users));
```

---

## Core Data Layer

`CoreDatasource` ([lib/core/data/core_datasource.dart](lib/core/data/core_datasource.dart)) implements `CoreRepository` and aggregates all available data clients into one injectable class:

| Field | Type | Condition |
|---|---|---|
| `dio` | `DioClient` | `use_remote: true` |
| `firestore` | `FirestoreManager` | `use_firebase: true` |
| `storage` | `StorageController` | always |

Inject via `coreDatasourceProvider` in feature datasources:

```dart
final myFeatureDatasourceProvider = Provider<MyFeatureRepository>(
  (ref) => MyFeatureDatasource(ref.read(coreDatasourceProvider)),
);

class MyFeatureDatasource implements MyFeatureRepository {
  MyFeatureDatasource(this._core);
  final CoreRepository _core;

  Future<Either<Failure, List<MyModel>>> getItems() =>
      _core.source.dio.get('/items', fromJson: MyModel.fromJson);
}
```

---

## Routing

Routes are registered in [lib/core/app/router/routes.dart](lib/core/app/router/routes.dart) via `routesProvider`. The router uses `SentryNavigatorObserver` and shows an inline error scaffold for unmatched paths.

---

## Localization

Translation files: [assets/translations/en.json](assets/translations/en.json) and [assets/translations/ar.json](assets/translations/ar.json).

Type-safe keys: [lib/core/app/localization/locale_keys.dart](lib/core/app/localization/locale_keys.dart). After adding a key to the JSON files, add the matching constant (or re-run `flutter pub run easy_localization:generate`).

Usage: `LocaleKeys.some_key.tr()`

---

## Theming

- Colors: `Palette` ([lib/core/presentation/theme/palette.dart](lib/core/presentation/theme/palette.dart))
- Text styles: [lib/core/presentation/theme/text_theme.dart](lib/core/presentation/theme/text_theme.dart)
- Theme config: [lib/core/presentation/theme/custom_theme.dart](lib/core/presentation/theme/custom_theme.dart)
- Toggle: `ref.read(themeProvider.notifier).changeThemeMode()` — toggles light ↔ dark
- Semantic colors: `Theme.of(context).colorScheme` extensions in [lib/core/presentation/theme/color_scheme_extension.dart](lib/core/presentation/theme/color_scheme_extension.dart)

---

## Flavors

| Flavor | Entry point | Env var |
|---|---|---|
| dev | `main_dev.dart` | `DEV_BASE_URL` |
| prod | `main_prod.dart` | `PROD_BASE_URL` |

Access config via `FlavorConfig.instance.settings` — exposes `baseUrl`, `enableLogging`, `showDebugBanner`.

---

## Adding a New Feature

1. Create `lib/features/<feature>/` with `data/`, `domain/`, `presentation/` subdirectories.
2. **Domain** — add model(s) extending `Equatable` with `fromJson`; add an `abstract interface class` repository in `domain/repositories/`.
3. **Data** — add a datasource class that `implements` the domain repository interface; inject `coreDatasourceProvider` for remote and local calls; returns `Either<Failure, T>`.
4. **Presentation** — add a `NotifierProvider` + `Notifier` subclass; add `HookConsumerWidget` screens.
5. Register routes in [lib/core/app/router/routes.dart](lib/core/app/router/routes.dart).
6. Add storage keys to `StorageKeys` as needed.

---

## AI Tooling

| File/Dir | Auto-loaded | Purpose |
|---|---|---|
| `CLAUDE.md` | Yes | Architecture guide and conventions (this file) |
| `.agents/rules/` | Yes | Supplemental agent rules (e.g. hot reload) |
| `.agents/skills/` | No — invoke with `/skill-name` | 35 skill modules for dart, flutter, and riverpod |
| `.mcp.json` | Yes | MCP server: `flutter-skill` |

---

## Key Conventions

- **No `StatefulWidget`** — always `HookConsumerWidget`; use hooks for local state.
- **Absolute imports** — `package:{{name.snakeCase()}}/...` everywhere; no relative imports across features or layers.
- **Either everywhere** — repositories and notifier methods never throw; always return or consume `Either<Failure, T>`.
- **No business logic in widgets** — widgets call notifier methods; notifiers call repositories.
- **`with Alerts`** — mix into notifiers that need `showToast()` or `debugLog()`.
