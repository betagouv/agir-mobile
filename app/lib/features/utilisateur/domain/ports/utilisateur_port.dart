import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';

abstract interface class UtilisateurPort {
  Future<Utilisateur> recupereUtilisateur();
}
