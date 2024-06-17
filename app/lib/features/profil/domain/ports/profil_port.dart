import 'package:app/features/profil/mes_informations/domain/entities/mes_informations.dart';
import 'package:app/features/profil/mon_logement/domain/entities/logement.dart';

abstract interface class ProfilPort {
  Future<MesInformations> recupererProfil();
  Future<void> mettreAJour({
    required final String prenom,
    required final String nom,
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  });

  Future<Logement> recupererLogement();

  Future<void> mettreAJourLogement({required final Logement logement});
}
