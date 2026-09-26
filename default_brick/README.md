# default_brick

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Mason brick that generates a production-ready Flutter project scaffold with clean architecture, flavors, Riverpod state management, GoRouter navigation, Sentry crash reporting, and Material Design 3 theming.

## Features

- **Flavors** — dev and prod entry points with per-flavor `FlavorConfig` (base URL, logging toggle, banner)
- **State management** — `flutter_riverpod` + `hooks_riverpod` + `flutter_hooks`
- **Navigation** — `go_router` with `SentryNavigatorObserver`
- **Error handling** — `dartz` `Either<Failure, T>` across all layers
- **Local storage** — `SharedPreferences` (non-sensitive) + `FlutterSecureStorage` (sensitive) via `StorageController`
- **Localization** — `easy_localization` with type-safe `LocaleKeys`
- **Crash reporting** — `sentry_flutter` with screenshot and thread attachment
- **Theming** — Material Design 3 with custom `Palette`, `CustomTextTheme`, and `ColorScheme` extensions
- **Architecture** — three-layer clean architecture: presentation → domain → data

## Variables

| Variable | Type | Description |
|---|---|---|
| `name` | string | Project name — used as `snake_case` for the package name and `PascalCase` for the root widget |
| `bundle_id` | string | Reverse-domain bundle ID (e.g. `com.acme.myapp`) |
| `platforms` | array | Target platforms: `android`, `ios`, `macos`, `web`, `windows`, `linux` |
| `use_remote` | boolean | Include Dio HTTP client and base URL env vars |
| `use_firebase` | boolean | Include Firebase dependencies |
| `sentry_dsn` | string | Sentry DSN for crash reporting (leave blank to skip) |
| `dev_base_url` | string | API base URL for the dev flavor (used when `use_remote` is true) |
| `prod_base_url` | string | API base URL for the prod flavor (used when `use_remote` is true) |

## Usage

```sh
mason make default_brick
```

See [`CLAUDE.md`](__brick__/CLAUDE.md) inside the generated project for the full architecture guide, conventions, and patterns.

## Getting Started with Mason

- [Official Mason Documentation](https://docs.brickhub.dev)
- [Mason CLI on GitHub](https://github.com/felangel/mason)
