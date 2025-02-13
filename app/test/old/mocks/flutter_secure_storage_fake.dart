// ignore_for_file: avoid-collection-mutating-methods

import 'package:flutter/src/foundation/basic_types.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageFake implements FlutterSecureStorage {
  final _map = <String, String>{};

  @override
  Future<bool> containsKey({
    required final String key,
    final IOSOptions? iOptions,
    final AndroidOptions? aOptions,
    final LinuxOptions? lOptions,
    final WebOptions? webOptions,
    final MacOsOptions? mOptions,
    final WindowsOptions? wOptions,
  }) async => _map.containsKey(key);

  @override
  Future<void> delete({
    required final String key,
    final IOSOptions? iOptions,
    final AndroidOptions? aOptions,
    final LinuxOptions? lOptions,
    final WebOptions? webOptions,
    final MacOsOptions? mOptions,
    final WindowsOptions? wOptions,
  }) async {
    _map.remove(key);
  }

  @override
  Future<void> deleteAll({
    final IOSOptions? iOptions,
    final AndroidOptions? aOptions,
    final LinuxOptions? lOptions,
    final WebOptions? webOptions,
    final MacOsOptions? mOptions,
    final WindowsOptions? wOptions,
  }) async {
    _map.clear();
  }

  @override
  Future<String?> read({
    required final String key,
    final IOSOptions? iOptions,
    final AndroidOptions? aOptions,
    final LinuxOptions? lOptions,
    final WebOptions? webOptions,
    final MacOsOptions? mOptions,
    final WindowsOptions? wOptions,
  }) async => _map.containsKey(key) ? _map[key] : null;

  @override
  Future<Map<String, String>> readAll({
    final IOSOptions? iOptions,
    final AndroidOptions? aOptions,
    final LinuxOptions? lOptions,
    final WebOptions? webOptions,
    final MacOsOptions? mOptions,
    final WindowsOptions? wOptions,
  }) async => _map;

  @override
  Future<void> write({
    required final String key,
    required final String? value,
    final IOSOptions? iOptions,
    final AndroidOptions? aOptions,
    final LinuxOptions? lOptions,
    final WebOptions? webOptions,
    final MacOsOptions? mOptions,
    final WindowsOptions? wOptions,
  }) async {
    _map[key] = value ?? '';
  }

  @override
  AndroidOptions get aOptions => throw UnimplementedError();
  @override
  IOSOptions get iOptions => throw UnimplementedError();
  @override
  LinuxOptions get lOptions => throw UnimplementedError();
  @override
  MacOsOptions get mOptions => throw UnimplementedError();
  @override
  WindowsOptions get wOptions => throw UnimplementedError();
  @override
  WebOptions get webOptions => throw UnimplementedError();

  @override
  Future<bool?> isCupertinoProtectedDataAvailable() => throw UnimplementedError();

  @override
  Stream<bool> get onCupertinoProtectedDataAvailabilityChanged => throw UnimplementedError();

  @override
  void registerListener({required final String key, required final ValueChanged<String?> listener}) => throw UnimplementedError();

  @override
  void unregisterAllListeners() => throw UnimplementedError();

  @override
  void unregisterAllListenersForKey({required final String key}) => throw UnimplementedError();

  @override
  void unregisterListener({required final String key, required final ValueChanged<String?> listener}) =>
      throw UnimplementedError();
}
