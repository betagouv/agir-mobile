import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';
import 'package:fpdart/fpdart.dart';

class UtilisateurPortMock implements UtilisateurPort {
  UtilisateurPortMock({
    required this.prenom,
    required this.fonctionnalitesDebloquees,
    required this.estIntegrationTerminee,
  });

  String prenom;
  List<Fonctionnalites> fonctionnalitesDebloquees;
  bool estIntegrationTerminee;

  @override
  Future<Either<Exception, Utilisateur>> recupereUtilisateur() async => Right(
        Utilisateur(
          prenom: prenom,
          fonctionnalitesDebloquees: fonctionnalitesDebloquees,
          estIntegrationTerminee: estIntegrationTerminee,
        ),
      );
}
