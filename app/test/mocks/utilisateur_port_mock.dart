import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';
import 'package:fpdart/fpdart.dart';

class UtilisateurPortMock implements UtilisateurPort {
  UtilisateurPortMock({
    required this.prenom,
    required this.fonctionnalitesDebloquees,
  });

  String prenom;
  List<Fonctionnalites> fonctionnalitesDebloquees;

  @override
  Future<Either<Exception, Utilisateur>> recupereUtilisateur() async =>
      Either.right(
        Utilisateur(
          prenom: prenom,
          fonctionnalitesDebloquees: fonctionnalitesDebloquees,
        ),
      );
}
