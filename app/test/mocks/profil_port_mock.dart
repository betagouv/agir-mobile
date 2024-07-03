import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/informations/domain/entities/mes_informations.dart';
import 'package:app/features/profil/logement/domain/entities/logement.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';

class ProfilPortMock implements ProfilPort {
  ProfilPortMock({
    required this.prenom,
    required this.nom,
    required this.email,
    required this.codePostal,
    required this.commune,
    required this.nombreAdultes,
    required this.nombreEnfants,
    required this.typeDeLogement,
    required this.estProprietaire,
    required this.superficie,
    required this.chauffage,
    required this.plusDe15Ans,
    required this.dpe,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  String prenom;
  String nom;
  String email;
  String? codePostal;
  String? commune;
  int? nombreAdultes;
  int? nombreEnfants;
  TypeDeLogement? typeDeLogement;
  bool? estProprietaire;
  Superficie? superficie;
  Chauffage? chauffage;
  bool? plusDe15Ans;
  Dpe? dpe;
  double nombreDePartsFiscales;
  int? revenuFiscal;
  bool supprimerLeCompteAppele = false;
  bool changerLeMotDePasseAppele = false;

  @override
  Future<Informations> recupererProfil() async => Informations(
        prenom: prenom,
        nom: nom,
        email: email,
        codePostal: codePostal,
        commune: commune,
        nombreDePartsFiscales: nombreDePartsFiscales,
        revenuFiscal: revenuFiscal,
      );

  @override
  Future<void> mettreAJour({
    required final String prenom,
    required final String nom,
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    this.prenom = prenom;
    this.nom = nom;
    this.email = email;
    this.nombreDePartsFiscales = nombreDePartsFiscales;
    this.revenuFiscal = revenuFiscal;
  }

  @override
  Future<Logement> recupererLogement() async => Logement(
        codePostal: codePostal,
        commune: commune,
        nombreAdultes: nombreAdultes,
        nombreEnfants: nombreEnfants,
        typeDeLogement: typeDeLogement,
        estProprietaire: estProprietaire,
        superficie: superficie,
        chauffage: chauffage,
        plusDe15Ans: plusDe15Ans,
        dpe: dpe,
      );

  @override
  Future<void> mettreAJourLogement({required final Logement logement}) async {
    codePostal = logement.codePostal;
    commune = logement.commune;
    nombreAdultes = logement.nombreAdultes;
    nombreEnfants = logement.nombreEnfants;
    typeDeLogement = logement.typeDeLogement;
    estProprietaire = logement.estProprietaire;
    superficie = logement.superficie;
    chauffage = logement.chauffage;
    plusDe15Ans = logement.plusDe15Ans;
    dpe = logement.dpe;
  }

  @override
  Future<void> supprimerLeCompte() async {
    supprimerLeCompteAppele = true;
  }

  @override
  Future<void> changerMotDePasse({required final String motDePasse}) async {
    changerLeMotDePasseAppele = true;
  }
}
