import 'package:app/features/authentification/domain/entities/authentification_erreur.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:fpdart/fpdart.dart';

class AuthentificationPortMock implements AuthentificationPort {
  AuthentificationPortMock(
    this.authentificationStatusManager, {
    required this.prenom,
    required this.estIntegrationTerminee,
  });

  final AuthentificationStatutManager authentificationStatusManager;

  bool connexionAppele = false;
  bool creerCompteAppele = false;
  bool validationAppele = false;
  bool renvoyerCodeAppele = false;
  bool oublieMotDePasseAppele = false;
  bool modifierMotDePasseAppele = false;

  @override
  Future<Either<AuthentificationErreur, void>> connexionDemandee(
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
  Future<Either<AuthentificationErreur, void>> creationDeCompteDemandee(
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
  Future<Either<AuthentificationErreur, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  ) async {
    validationAppele = true;
    authentificationStatusManager
        .gererAuthentificationStatut(AuthentificationStatut.connecte);

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> oubliMotDePasse(final String email) async {
    oublieMotDePasseAppele = true;

    return const Right(null);
  }

  @override
  Future<Either<AuthentificationErreur, void>> modifierMotDePasse({
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
