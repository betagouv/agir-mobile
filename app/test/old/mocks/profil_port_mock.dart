import 'package:app/features/profil/core/domain/profil_port.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/logement/domain/logement.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:fpdart/fpdart.dart';

class ProfilPortMock implements ProfilPort {
  ProfilPortMock({
    required this.email,
    required this.prenom,
    required this.nom,
    required this.anneeDeNaissance,
    required this.codePostal,
    required this.commune,
    required this.nombreAdultes,
    required this.nombreEnfants,
    required this.typeDeLogement,
    required this.estProprietaire,
    required this.superficie,
    required this.plusDe15Ans,
    required this.dpe,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  String email;
  String? prenom;
  String? nom;
  int? anneeDeNaissance;
  String? codePostal;
  String? commune;
  int? nombreAdultes;
  int? nombreEnfants;
  TypeDeLogement? typeDeLogement;
  bool? estProprietaire;
  Superficie? superficie;
  bool? plusDe15Ans;
  Dpe? dpe;
  double nombreDePartsFiscales;
  int? revenuFiscal;

  @override
  Future<Either<Exception, Informations>> recupererProfil() async => Right(
        Informations(
          email: email,
          prenom: prenom,
          nom: nom,
          anneeDeNaissance: anneeDeNaissance,
          codePostal: codePostal,
          commune: commune,
          nombreDePartsFiscales: nombreDePartsFiscales,
          revenuFiscal: revenuFiscal,
        ),
      );

  @override
  Future<Either<Exception, void>> mettreAJour({
    required final String? prenom,
    required final String? nom,
    required final int? anneeDeNaissance,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    this.prenom = prenom;
    this.nom = nom;
    this.anneeDeNaissance = anneeDeNaissance;
    this.nombreDePartsFiscales = nombreDePartsFiscales;
    this.revenuFiscal = revenuFiscal;

    return const Right(null);
  }

  @override
  Future<Either<Exception, Logement>> recupererLogement() async => Right(
        Logement(
          codePostal: codePostal,
          commune: commune,
          nombreAdultes: nombreAdultes,
          nombreEnfants: nombreEnfants,
          typeDeLogement: typeDeLogement,
          estProprietaire: estProprietaire,
          superficie: superficie,
          plusDe15Ans: plusDe15Ans,
          dpe: dpe,
        ),
      );

  @override
  Future<Either<Exception, void>> mettreAJourLogement({
    required final Logement logement,
  }) async {
    codePostal = logement.codePostal;
    commune = logement.commune;
    nombreAdultes = logement.nombreAdultes;
    nombreEnfants = logement.nombreEnfants;
    typeDeLogement = logement.typeDeLogement;
    estProprietaire = logement.estProprietaire;
    superficie = logement.superficie;
    plusDe15Ans = logement.plusDe15Ans;
    dpe = logement.dpe;

    return const Right(null);
  }

  @override
  Future<Either<Exception, void>> supprimerLeCompte() async =>
      const Right(null);

  @override
  Future<Either<Exception, void>> changerMotDePasse({
    required final String motDePasse,
  }) async =>
      const Right(null);

  @override
  Future<Either<Exception, void>> mettreAJourCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  }) async {
    this.codePostal = codePostal;
    this.commune = commune;

    return const Right(null);
  }
}
