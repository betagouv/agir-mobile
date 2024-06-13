import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';

class AuthentificationPortMock implements AuthentificationPort {
  const AuthentificationPortMock(this.authentificationStatusManager);

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
