import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides a [StorageController] instance. Must be overridden in [ProviderScope].
final storageProvider = NotifierProvider<StorageController, void>(
  () => throw UnimplementedError(),
);

/// Manages non-secure ([SharedPreferences]) and secure ([FlutterSecureStorage]) storage.
class StorageController extends Notifier<void> {
  final SharedPreferences _prefs;
  late final FlutterSecureStorage _secureStorage;

  StorageController(this._prefs);

  @override
  void build() => _secureStorage = const FlutterSecureStorage();

  Future<void> setSecured({required String key, required String? value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  void setPrefs<T>({required String key, required T? value}) {
    if (value is String) {
      _prefs.setString(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    }
  }

  Future<String?> getSecured({required String key}) async {
    return _secureStorage.read(key: key);
  }

  T? getPrefs<T>({required String key, T? defaultValue}) {
    return (_prefs.get(key) as T?) ?? defaultValue;
  }

  Future<void> deleteKey({required String key}) async {
    await _secureStorage.delete(key: key);
    await _prefs.remove(key);
  }
}
