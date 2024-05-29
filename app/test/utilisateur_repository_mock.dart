import 'package:app/src/fonctionnalites/utilisateur/domain/ports/utilisateur_repository.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';

class UtilisateurRepositoryMock implements UtilisateurRepository {
  UtilisateurRepositoryMock(this.prenom);

  String prenom;

  @override
  Future<Utilisateur> recupereUtilisateur() async =>
      Utilisateur(prenom: prenom);
}
