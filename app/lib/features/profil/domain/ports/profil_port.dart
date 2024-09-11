import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/logement/domain/entities/logement.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfilPort {
  Future<Either<Exception, Informations>> recupererProfil();

  Future<Either<Exception, void>> mettreAJourCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  });

  Future<Either<Exception, void>> mettreAJour({
    required final String? prenom,
    required final String? nom,
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  });

  Future<Either<Exception, Logement>> recupererLogement();

  Future<Either<Exception, void>> mettreAJourLogement({
    required final Logement logement,
  });

  Future<Either<Exception, void>> supprimerLeCompte();

  Future<Either<Exception, void>> changerMotDePasse({
    required final String motDePasse,
  });
}
