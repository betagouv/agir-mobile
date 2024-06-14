import 'package:app/features/profil/domain/entities/mes_informations.dart';

abstract interface class ProfilPort {
  Future<MesInformations> recupererProfil();
  Future<void> mettreAJour({
    required final String prenom,
    required final String nom,
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  });
}
