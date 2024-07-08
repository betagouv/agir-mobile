import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthentificationPort {
  Future<Either<Exception, void>> connectionDemandee(
    final InformationDeConnexion informationDeConnexion,
  );
  Future<Either<Exception, void>> deconnectionDemandee();
}
