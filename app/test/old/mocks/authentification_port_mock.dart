import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/utilisateur/domain/utilisateur.dart';
import 'package:fpdart/fpdart.dart';

import '../api/constants.dart';

class AuthentificationPortMock implements AuthentificationPort {
  AuthentificationPortMock(
    this.authenticationService, {
    required this.prenom,
    required this.estIntegrationTerminee,
  });

  final AuthenticationService authenticationService;

  bool connexionAppele = false;
  bool creerCompteAppele = false;
  bool validationAppele = false;
  bool renvoyerCodeAppele = false;
  bool oublieMotDePasseAppele = false;
  bool modifierMotDePasseAppele = false;

  @override
  Future<Either<ApiErreur, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    connexionAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> deconnexionDemandee() async {
    await authenticationService.logout();

    return const Right(null);
  }

  @override
  Future<Either<ApiErreur, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async {
    creerCompteAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> renvoyerCodeDemande(
    final String email,
  ) async {
    renvoyerCodeAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<ApiErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  ) async {
    validationAppele = true;

    await authenticationService.login(token);

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> oubliMotDePasse(final String email) async {
    oublieMotDePasseAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<ApiErreur, void>> modifierMotDePasse({
    required final String email,
    required final String code,
    required final String motDePasse,
  }) async {
    modifierMotDePasseAppele = true;

    return const Right(null);
  }

  String prenom;
  bool estIntegrationTerminee;

  @override
  Future<Either<Exception, Utilisateur>> recupereUtilisateur() async => Right(
        Utilisateur(
          prenom: prenom,
          estIntegrationTerminee: estIntegrationTerminee,
          aMaVilleCouverte: false,
        ),
      );
}
