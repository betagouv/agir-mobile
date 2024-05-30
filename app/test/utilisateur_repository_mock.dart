import 'package:app/src/fonctionnalites/utilisateur/domain/ports/utilisateur_repository.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';

class UtilisateurRepositoryMock implements UtilisateurRepository {
  UtilisateurRepositoryMock({
    required this.prenom,
    required this.fonctionnalitesDebloquees,
  });

  String prenom;
  List<Fonctionnalites> fonctionnalitesDebloquees;

  @override
  Future<Utilisateur> recupereUtilisateur() async => Utilisateur(
        prenom: prenom,
        fonctionnalitesDebloquees: fonctionnalitesDebloquees,
      );
}
