import 'dart:async';
import 'dart:convert';

import 'package:app/features/authentification/core/domain/authentification_statut.dart';
import 'package:app/features/authentification/core/domain/authentification_statut_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthentificationTokenStorage {
  AuthentificationTokenStorage({
    required final FlutterSecureStorage secureStorage,
    required final AuthentificationStatutManagerWriter
        authentificationStatusManagerWriter,
  })  : _secureStorage = secureStorage,
        _authentificationStatusManagerWriter =
            authentificationStatusManagerWriter;

  final FlutterSecureStorage _secureStorage;
  final AuthentificationStatutManagerWriter
      _authentificationStatusManagerWriter;

  Future<bool> initialise() async {
    final token = await recupererToken;

    _authentificationStatusManagerWriter.gererAuthentificationStatut(
      _isTokenValid(token)
          ? AuthentificationStatut.connecte
          : AuthentificationStatut.pasConnecte,
    );

    return true;
  }

  final _tokenKey = 'token';
  Future<String?> get recupererToken async =>
      _secureStorage.read(key: _tokenKey);

  final _utilisateurIdKey = 'utilisateurId';

  Future<String?> get recupererUtilisateurId async =>
      _secureStorage.read(key: _utilisateurIdKey);

  Future<void> sauvegarderToken(final String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);

    final jwtToken = token.split('.').elementAtOrNull(1);

    if (jwtToken == null) {
      return;
    }

    final tokenData = _decodeJwtToken(jwtToken);
    final utilisateurId = tokenData['utilisateurId'] as String;

    await _secureStorage.write(key: _utilisateurIdKey, value: utilisateurId);
    _authentificationStatusManagerWriter
        .gererAuthentificationStatut(AuthentificationStatut.connecte);
  }

  Future<void> supprimerTokenEtUtilisateurId() async {
    _authentificationStatusManagerWriter
        .gererAuthentificationStatut(AuthentificationStatut.pasConnecte);
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _utilisateurIdKey);
  }

  bool _isTokenValid(final String? token) {
    try {
      if (token == null) {
        return false;
      }

      final jwtToken = token.split('.')[1];
      final tokenData = _decodeJwtToken(jwtToken);
      final expirationTime = DateTime.fromMillisecondsSinceEpoch(
        (tokenData['exp'] as int) * 1000,
      );

      return expirationTime.isAfter(DateTime.now());
    } on Exception catch (_) {
      return false;
    }
  }

  Map<String, dynamic> _decodeJwtToken(final String jwtToken) =>
      jsonDecode(utf8.decode(base64.decode(base64.normalize(jwtToken))))
          as Map<String, dynamic>;
}
