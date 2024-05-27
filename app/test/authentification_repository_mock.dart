import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/domain/information_de_connexion.dart';
import 'package:app/src/fonctionnalites/authentification/domain/ports/authentification_repository.dart';

class AuthentificationRepositoryMock implements AuthentificationRepository {
  AuthentificationRepositoryMock(this.authentificationStatusManager);

  final AuthentificationStatutManager authentificationStatusManager;

  @override
  Future<void> connectionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.connecte);
  }

  @override
  Future<void> deconnectionDemandee() async {
    authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.pasConnecte);
  }
}
