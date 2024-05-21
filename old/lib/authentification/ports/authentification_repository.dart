
import '../authenticateUser_usecase.dart';

abstract class AuthentificationRepository {
  Future<Utilisateur> doAuthentification(String userName);
}