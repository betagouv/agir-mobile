import 'package:app/features/authentification/domain/entities/authentification_erreur.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthentificationPort {
  Future<Either<AuthentificationErreur, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  );

  Future<Either<AuthentificationErreur, void>> connexionDemandee(
    final InformationDeConnexion informationDeConnexion,
  );

  Future<Either<Exception, void>> renvoyerCodeDemande(final String email);

  Future<Either<AuthentificationErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  );

  Future<Either<Exception, void>> deconnexionDemandee();

  Future<Either<Exception, void>> oubliMotDePasse(final String email);

  Future<Either<AuthentificationErreur, void>> modifierMotDePasse({
    required final String email,
    required final String code,
    required final String motDePasse,
  });

  Future<Either<Exception, Utilisateur>> recupereUtilisateur();
}
