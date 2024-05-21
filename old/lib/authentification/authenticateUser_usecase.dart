import 'package:agir/authentification/ports/authentification_repository.dart';

class Utilisateur {
  final String nom;
  final String id;

  Utilisateur(this.nom, this.id);
}
class AuthenticateUseCase {
  final AuthentificationRepository _authentificationRepository;

  AuthenticateUseCase(this._authentificationRepository);

  Future<Utilisateur> execute(String userName) async {
     return await _authentificationRepository.doAuthentification(userName);
  }
}