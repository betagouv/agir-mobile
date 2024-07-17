// ignore_for_file: match-getter-setter-field-names

import 'dart:async';

import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:rxdart/subjects.dart';

abstract interface class AuthentificationStatutManagerWriter {
  void gererAuthentificationStatut(final AuthentificationStatut statut);
}

abstract interface class AuthentificationStatutManagerReader {
  AuthentificationStatut get statutActuel;
  Stream<AuthentificationStatut> get statut;
}

class AuthentificationStatutManager
    implements
        AuthentificationStatutManagerWriter,
        AuthentificationStatutManagerReader {
  final _controller = BehaviorSubject<AuthentificationStatut>.seeded(
    AuthentificationStatut.inconnu,
  );

  @override
  void gererAuthentificationStatut(final AuthentificationStatut statut) {
    _controller.add(statut);
  }

  @override
  AuthentificationStatut get statutActuel => _controller.value;

  @override
  Stream<AuthentificationStatut> get statut => _controller.stream;
}
