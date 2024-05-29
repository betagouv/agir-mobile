import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';

abstract interface class UtilisateurRepository {
  Future<Utilisateur> recupereUtilisateur();
}
