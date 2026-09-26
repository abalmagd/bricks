# {{name.pascalCase()}}

A Flutter application generated from the `default_brick` Mason template.

## Running the App

This project uses flavors. Pass the correct entry point and `.env` file when running:

| Flavor | Entry point | Command |
|---|---|---|
| Dev | `lib/environment/main_dev.dart` | `flutter run -t lib/environment/main_dev.dart --dart-define-from-file=.env` |
| Prod | `lib/environment/main_prod.dart` | `flutter run -t lib/environment/main_prod.dart --dart-define-from-file=.env` |

## Environment Variables

Fill in `.env` before running:

```env
# Sentry crash reporting
SENTRY_DSN=your_sentry_dsn

# API base URLs (only needed when Dio is used)
DEV_BASE_URL=https://api.example.com
PROD_BASE_URL=https://api.example.com
```

## Architecture

```
lib/
├── environment/     # Flavor entry points + app widget
├── core/
│   ├── app/         # Constants, error handling, localization, routing, utilities
│   ├── data/        # Local storage (SharedPreferences + FlutterSecureStorage)
│   └── presentation/ # Providers, theme, shared widgets
└── features/        # Feature modules (one folder per feature)
```

Each feature follows a three-layer structure: **presentation → domain → data**.

See [CLAUDE.md](CLAUDE.md) for the full architecture guide, state management patterns, conventions, and how to add new features.
