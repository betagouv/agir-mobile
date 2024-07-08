import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationPortMock implements AuthentificationPort {
  const AuthentificationPortMock(this.authentificationStatusManager);

  final AuthentificationStatutManager authentificationStatusManager;

  @override
  Future<Either<Exception, void>> connectionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.connecte);

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> deconnectionDemandee() async {
    authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.pasConnecte);

    return const Right(null);
  }
}
