import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/shared/domain/entities/api_erreur.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthentificationPort {
  Future<Either<ApiErreur, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  );

  Future<Either<ApiErreur, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  );

  Future<Either<Exception, void>> renvoyerCodeDemande(final String email);

  Future<Either<ApiErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  );

  Future<Either<Exception, void>> deconnexionDemandee();

  Future<Either<Exception, void>> oubliMotDePasse(final String email);

  Future<Either<ApiErreur, void>> modifierMotDePasse({
    required final String email,
    required final String code,
    required final String motDePasse,
  });

  Future<Either<Exception, Utilisateur>> recupereUtilisateur();
}
