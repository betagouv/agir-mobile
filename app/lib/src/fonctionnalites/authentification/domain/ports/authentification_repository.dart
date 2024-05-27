import 'package:app/src/fonctionnalites/authentification/domain/information_de_connexion.dart';

abstract interface class AuthentificationRepository {
  Future<void> connectionDemandee(
    final InformationDeConnexion informationDeConnexion,
  );
  Future<void> deconnectionDemandee();
}
