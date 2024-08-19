import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationPortMock implements AuthentificationPort {
  AuthentificationPortMock(this.authentificationStatusManager);

  final AuthentificationStatutManager authentificationStatusManager;

  bool connexionAppele = false;
  bool creerCompteAppele = false;
  bool validationAppele = false;
  bool renvoyerCodeAppele = false;

  @override
  Future<Either<Exception, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    connexionAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> deconnexionDemandee() async {
    authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.pasConnecte);

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    creerCompteAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> renvoyerCodeDemandee(
    final String email,
  ) async {
    renvoyerCodeAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  ) async {
    validationAppele = true;
    authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.connecte);

    return const Right(null);
  }
}
