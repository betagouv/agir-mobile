import 'dart:async';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';

class AuthentificationStatutManager {
  AuthentificationStatut _statut = AuthentificationStatut.inconnu;

  final _controller = StreamController<AuthentificationStatut>();

  void gererAuthentificationStatut(final AuthentificationStatut statut) {
    _statut = statut;
    _controller.add(_statut);
  }

  AuthentificationStatut statutActuel() => _statut;

  Stream<AuthentificationStatut> statutModifie() => _controller.stream;

  Future<void> dispose() async {
    await _controller.close();
  }
}
