import 'package:app/features/profil/informations/domain/entities/mes_informations.dart';
import 'package:app/features/profil/logement/domain/entities/logement.dart';

abstract interface class ProfilPort {
  Future<Informations> recupererProfil();
  Future<void> mettreAJour({
    required final String prenom,
    required final String nom,
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  });

  Future<Logement> recupererLogement();

  Future<void> mettreAJourLogement({required final Logement logement});

  Future<void> supprimerLeCompte();

  Future<void> changerMotDePasse({required final String motDePasse});
}
