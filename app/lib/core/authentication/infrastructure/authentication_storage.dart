import 'dart:convert';

import 'package:app/core/authentication/domain/expiration_date.dart';
import 'package:app/core/authentication/domain/token.dart';
import 'package:app/core/authentication/domain/user_id.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationStorage {
  AuthenticationStorage(this._secureStorage);

  static const _key = 'token';
  final FlutterSecureStorage _secureStorage;

  Token? _cachedToken;
  UserId? _cachedUserId;
  ExpirationDate? _cachedExpirationDate;

  Future<void> init() async {
    final token = await _secureStorage.read(key: _key);
    if (token != null) {
      _cachedToken = Token(token);
      final value = _cachedToken!;
      final jwtPayload = value.payload;
      final payloadMap = _decodeJwtToken(jwtPayload);
      final userId = payloadMap['utilisateurId'] as String;
      _cachedUserId = UserId(userId);
      final expirationTime = DateTime.fromMillisecondsSinceEpoch((payloadMap['exp'] as int) * 1000, isUtc: true);
      _cachedExpirationDate = ExpirationDate(expirationTime);
    }
  }

  Future<void> saveToken(final String token) async {
    _cachedUserId = null;
    _cachedExpirationDate = null;
    await _secureStorage.write(key: _key, value: token);

    _cachedToken = Token(token);
    final value = _cachedToken!;
    final jwtPayload = value.payload;
    final payloadMap = _decodeJwtToken(jwtPayload);
    final userId = payloadMap['utilisateurId'] as String;
    _cachedUserId = UserId(userId);
    final expirationTime = DateTime.fromMillisecondsSinceEpoch((payloadMap['exp'] as int) * 1000, isUtc: true);
    _cachedExpirationDate = ExpirationDate(expirationTime);
  }

  Future<void> deleteAuthToken() async {
    _cachedUserId = null;
    _cachedExpirationDate = null;

    await _secureStorage.delete(key: _key);
  }

  Token get token {
    if (_cachedToken == null) {
      throw Exception('Token not found');
    }

    return _cachedToken!;
  }

  UserId get userId {
    if (_cachedUserId == null) {
      throw Exception('User ID not found');
    }

    return _cachedUserId!;
  }

  ExpirationDate get expirationDate {
    if (_cachedExpirationDate == null) {
      throw Exception('Expiration date not found');
    }

    return _cachedExpirationDate!;
  }

  Map<String, dynamic> _decodeJwtToken(final String jwtToken) =>
      jsonDecode(utf8.decode(base64.decode(base64.normalize(jwtToken)))) as Map<String, dynamic>;
}
