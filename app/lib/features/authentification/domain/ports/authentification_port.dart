import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';

abstract interface class AuthentificationPort {
  Future<void> connectionDemandee(
    final InformationDeConnexion informationDeConnexion,
  );
  Future<void> deconnectionDemandee();
}
