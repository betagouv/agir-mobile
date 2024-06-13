// ignore_for_file: match-getter-setter-field-names

import 'dart:async';

import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';

class AuthentificationStatutManager {
  AuthentificationStatut _statut = AuthentificationStatut.inconnu;

  final _controller = StreamController<AuthentificationStatut>();

  void gererAuthentificationStatut(final AuthentificationStatut statut) {
    _statut = statut;
    _controller.add(_statut);
  }

  AuthentificationStatut get statutActuel => _statut;

  Stream<AuthentificationStatut> get statutModifie => _controller.stream;
}
