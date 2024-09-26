import 'dart:convert';

import 'package:app/features/authentication/domain/expiration_date.dart';
import 'package:app/features/authentication/domain/token.dart';
import 'package:app/features/authentication/domain/user_id.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepository {
  AuthenticationRepository(this._secureStorage);

  static const _key = 'token';
  final FlutterSecureStorage _secureStorage;

  Token? _cachedToken;
  UserId? _cachedUserId;
  ExpirationDate? _cachedExpirationDate;

  Future<void> saveToken(final String token) async {
    _cachedUserId = null;
    _cachedExpirationDate = null;

    await _secureStorage.write(key: _key, value: token);
  }

  Future<Token> get token async {
    if (_cachedToken != null) {
      return _cachedToken!;
    }

    final token = await _secureStorage.read(key: _key);
    if (token == null) {
      throw Exception('Token not found');
    }

    return _cachedToken = Token(token);
  }

  Future<void> deleteToken() async {
    _cachedUserId = null;
    _cachedExpirationDate = null;

    await _secureStorage.delete(key: _key);
  }

  Future<UserId> get userId async {
    if (_cachedUserId != null) {
      return _cachedUserId!;
    }

    final payloadMap = await _decodedPayload;
    final userId = payloadMap['utilisateurId'] as String;

    return _cachedUserId = UserId(userId);
  }

  Future<ExpirationDate> get expirationDate async {
    if (_cachedExpirationDate != null) {
      return _cachedExpirationDate!;
    }

    final payloadMap = await _decodedPayload;
    final expirationTime = DateTime.fromMillisecondsSinceEpoch(
      (payloadMap['exp'] as int) * 1000,
      isUtc: true,
    );

    return _cachedExpirationDate = ExpirationDate(expirationTime);
  }

  Future<Map<String, dynamic>> get _decodedPayload async {
    final value = await token;
    final jwtPayload = value.payload;

    return _decodeJwtToken(jwtPayload);
  }

  Map<String, dynamic> _decodeJwtToken(final String jwtToken) =>
      jsonDecode(utf8.decode(base64.decode(base64.normalize(jwtToken))))
          as Map<String, dynamic>;
}
