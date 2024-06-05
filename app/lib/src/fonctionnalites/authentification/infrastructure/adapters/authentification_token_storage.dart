import 'dart:async';

import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthentificationTokenStorage {
  AuthentificationTokenStorage({
    required final FlutterSecureStorage secureStorage,
    required final AuthentificationStatutManager authentificationStatusManager,
  })  : _secureStorage = secureStorage,
        _authentificationStatusManager = authentificationStatusManager;

  final FlutterSecureStorage _secureStorage;
  final AuthentificationStatutManager _authentificationStatusManager;

  Future<bool> initialise() async {
    final token = await recupererToken;
    if (token == null) {
      _authentificationStatusManager
          .gererAuthentificationStatut(AuthentificationStatut.pasConnecte);
    } else {
      _authentificationStatusManager
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

  Future<void> sauvegarderTokenEtUtilisateurId(
    final String token,
    final String utilisateurId,
  ) async {
    await _secureStorage.write(key: _tokenKey, value: token);
    await _secureStorage.write(key: _utilisateurIdKey, value: utilisateurId);
    _authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.connecte);
  }

  Future<void> supprimerTokenEtUtilisateurId() async {
    _authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.pasConnecte);
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _utilisateurIdKey);
  }
}
