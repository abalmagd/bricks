import 'package:{{name.snakeCase()}}/core/data/local/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:{{name.snakeCase()}}/core/data/local/local_storage.dart';

final themeProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);

class ThemeController extends Notifier<ThemeMode> {
  late final StorageController _storageController;

  @override
  ThemeMode build() {
    _storageController = ref.read(storageProvider.notifier);
    final ThemeMode themeMode = getThemeMode();
    return themeMode;
  }

  void changeThemeMode() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      _storageController.setPrefs<bool>(
        key: StorageKeys.themeMode.name,
        value: false,
      );
    } else {
      state = ThemeMode.dark;
      _storageController.setPrefs<bool>(
        key: StorageKeys.themeMode.name,
        value: true,
      );
    }
  }

  ThemeMode getThemeMode() {
    final isDark = _storageController.getPrefs<bool>(
      key: StorageKeys.themeMode.name,
    );

    switch (isDark) {
      case null:
        return ThemeMode.light;
      case true:
        return ThemeMode.dark;
      case false:
        return ThemeMode.light;
    }
  }
}
