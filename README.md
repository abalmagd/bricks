# Bricks

A collection of [Mason](https://pub.dev/packages/mason_cli) bricks for generating Flutter project templates.

---

## Mason Overview

Mason is a CLI tool for Dart/Flutter that generates code from reusable templates called **bricks**. Each brick defines a set of variables (prompts) and a `__brick__/` directory of template files. Running `mason make <brick>` fills in the template and outputs a complete project or code scaffold.

**Install Mason CLI:**

```bash
dart pub global activate mason_cli
```

---

## Setup

After cloning this repo, install all bricks defined in `mason.yaml`:

```bash
mason get
```

---

## Available Bricks

| Brick | Description |
|---|---|
| `default_brick` | Production-ready Flutter scaffold — clean architecture, Riverpod, GoRouter, Sentry, flavors, Material 3 |

---

## How to Make (Generate from a Brick)

```bash
mason make <brick_name> --output-dir <path/to/output>
```

Mason will prompt for each variable interactively. You can also pass variables as flags to skip prompts:

```bash
mason make default_brick \
  --output-dir ~/Development/Projects \
  --name "My App" \
  --bundle_id com.example.myapp \
  --use_remote true \
  --use_firebase false
```

### `default_brick` variables

| Variable | Type | Description |
|---|---|---|
| `name` | string | Project name (e.g. `My App`) |
| `bundle_id` | string | Reverse-domain bundle ID (e.g. `com.acme.myapp`) — min 3 segments |
| `platforms` | array | Target platforms: `android`, `ios`, `macos`, `web`, `windows`, `linux` |
| `use_remote` | boolean | Include Dio HTTP client |
| `use_firebase` | boolean | Include Firebase Core + Firestore |
| `sentry_dsn` | string | Sentry DSN for crash reporting |
| `dev_base_url` | string | Dev flavor API base URL |
| `prod_base_url` | string | Prod flavor API base URL |

After generation, the post-gen hook automatically runs `flutter create`, sets the bundle ID, installs dependencies, generates locale keys, and sets up native splash.

---

## How to Save (Add a New Brick)

### 1. Scaffold a new brick

```bash
mason new <brick_name>
```

This creates the standard brick structure:

```
<brick_name>/
├── brick.yaml          # Brick metadata and variable definitions
├── __brick__/          # Template files (use {{variable}} for substitution)
├── hooks/              # Optional pre_gen.dart / post_gen.dart scripts
├── README.md
├── CHANGELOG.md
└── LICENSE
```

### 2. Register it in `mason.yaml`

```yaml
bricks:
  your_brick_name:
    path: ./your_brick_name
```

For a git-hosted brick:

```yaml
bricks:
  your_brick_name:
    git:
      url: https://github.com/user/bricks
      path: your_brick_name
      ref: main          # optional: tag, branch, or commit SHA
```

### 3. Install

```bash
mason get
```

The brick is now available via `mason make your_brick_name`.
