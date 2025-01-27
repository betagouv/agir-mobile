import 'package:app/core/authentication/domain/authentication_service.dart';
import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:fpdart/fpdart.dart';

import '../api/constants.dart';

class AuthentificationPortMock implements AuthentificationPort {
  const AuthentificationPortMock(this.authenticationService);

  final AuthenticationService authenticationService;

  @override
  Future<Either<ApiErreur, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async =>
      const Right(null);

  @override
  Future<Either<Exception, void>> deconnexionDemandee() async {
    await authenticationService.logout();

    return const Right(null);
  }

  @override
  Future<Either<ApiErreur, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  ) async =>
      const Right(null);

  @override
  Future<Either<Exception, void>> renvoyerCodeDemande(
    final String email,
  ) async =>
      const Right(null);

  @override
  Future<Either<ApiErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  ) async {
    await authenticationService.login(token);

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> oubliMotDePasse(final String email) async =>
      const Right(null);

  @override
  Future<Either<ApiErreur, void>> modifierMotDePasse({
    required final String email,
    required final String code,
    required final String motDePasse,
  }) async =>
      const Right(null);
}
