import 'dart:async';
import 'dart:convert';

import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
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
    if (token == null) {
      _authentificationStatusManagerWriter
          .gererAuthentificationStatut(AuthentificationStatut.pasConnecte);
    } else {
      _authentificationStatusManagerWriter
          .gererAuthentificationStatut(AuthentificationStatut.connecte);
    }

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

    final tokenData = jsonDecode(utf8.decode(base64Url.decode(jwtToken)))
        as Map<String, dynamic>;
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
}
