import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UtilisateurPort {
  Future<Either<Exception, Utilisateur>> recupereUtilisateur();
}
