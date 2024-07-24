import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthentificationPort {
  Future<Either<Exception, void>> creationDeCompteDemandee(
    final InformationDeConnexion informationDeConnexion,
  );
  Future<Either<Exception, void>> connectionDemandee(
    final InformationDeConnexion informationDeConnexion,
  );
  Future<Either<Exception, void>> renvoyerCodeDemandee(final String email);
  Future<Either<Exception, void>> validationDemandee(
    final InformationDeCode informationDeConnexion,
  );
  Future<Either<Exception, void>> deconnectionDemandee();
}
