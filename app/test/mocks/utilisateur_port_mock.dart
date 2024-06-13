import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';

class UtilisateurPortMock implements UtilisateurPort {
  UtilisateurPortMock({
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
