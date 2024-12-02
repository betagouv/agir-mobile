import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/profil/core/infrastructure/profil_api_adapter.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/logement/domain/logement.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';

void main() {
  group('ProfilApiAdapter', () {
    test('recupererProfil', () async {
      final dio = DioMock()
        ..getM(
          Endpoints.profile,
          responseData: jsonDecode('''
{
    "email": "lucas@agir.dev",
    "nom": "",
    "prenom": "Lucas",
    "code_postal": "25000",
    "commune": "BESANCON",
    "revenu_fiscal": null,
    "nombre_de_parts_fiscales": 1,
    "abonnement_ter_loire": false,
    "logement": {
        "nombre_adultes": 2,
        "nombre_enfants": 2,
        "code_postal": "25000",
        "commune": "BESANCON",
        "type": null,
        "superficie": null,
        "proprietaire": null,
        "chauffage": null,
        "plus_de_15_ans": null,
        "dpe": null,
        "commune_label": "Besançon"
    },
    "annee_naissance": 1992
}'''),
        );

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      final result = await adapter.recupererProfil();
      expect(
        result.getRight().getOrElse(() => throw Exception()),
        const Informations(
          email: 'lucas@agir.dev',
          prenom: 'Lucas',
          nom: '',
          anneeDeNaissance: 1992,
          codePostal: '25000',
          commune: 'BESANCON',
          nombreDePartsFiscales: 1,
          revenuFiscal: null,
        ),
      );
    });

    test('mettreAJour', () async {
      final dio = DioMock()..patchM(Endpoints.profile);

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      const prenom = 'Prénom';
      const nom = 'Nom';
      const anneeDeNaissance = 1990;
      const nombreDePartsFiscales = 2.5;
      const revenuFiscal = 16000;
      await adapter.mettreAJour(
        prenom: prenom,
        nom: nom,
        anneeDeNaissance: anneeDeNaissance,
        nombreDePartsFiscales: nombreDePartsFiscales,
        revenuFiscal: revenuFiscal,
      );
      verify(
        () => dio.patch<dynamic>(
          Endpoints.profile,
          data:
              '{"annee_naissance":$anneeDeNaissance,"nom":"$nom","nombre_de_parts_fiscales":$nombreDePartsFiscales,"prenom":"$prenom","revenu_fiscal":$revenuFiscal}',
        ),
      );
    });

    test('recupererLogement', () async {
      final dio = DioMock()
        ..getM(
          Endpoints.logement,
          responseData: jsonDecode('''
{
  "nombre_adultes": 2,
  "nombre_enfants": 1,
  "code_postal": "75001",
  "commune": "PARIS 01",
  "type": "maison",
  "superficie": "superficie_70",
  "proprietaire": true,
  "chauffage": "gaz",
  "plus_de_15_ans": null,
  "dpe": null
}'''),
        );

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      final result = await adapter.recupererLogement();
      expect(
        result.getRight().getOrElse(() => throw Exception()),
        const Logement(
          codePostal: '75001',
          commune: 'PARIS 01',
          nombreAdultes: 2,
          nombreEnfants: 1,
          typeDeLogement: TypeDeLogement.maison,
          estProprietaire: true,
          superficie: Superficie.s70,
          plusDe15Ans: null,
          dpe: null,
        ),
      );
    });

    test('recupererLogement vide', () async {
      final dio = DioMock()
        ..getM(Endpoints.logement, responseData: jsonDecode('{}'));

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      final result = await adapter.recupererLogement();
      expect(
        result.getRight().getOrElse(() => throw Exception()),
        const Logement(
          codePostal: null,
          commune: null,
          nombreAdultes: null,
          nombreEnfants: null,
          typeDeLogement: null,
          estProprietaire: null,
          superficie: null,
          plusDe15Ans: null,
          dpe: null,
        ),
      );
    });

    test('mettreAJourLogement', () async {
      const path = Endpoints.logement;
      final dio = DioMock()..patchM(path);

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      const codePostal = '39100';
      const commune = 'DOLE';
      const nombreAdultes = 2;
      const nombreEnfants = 1;
      const typeDeLogement = TypeDeLogement.maison;
      const estProprietaire = true;
      const superficie = Superficie.s100;
      const plusDe15Ans = true;
      const dpe = Dpe.b;
      await adapter.mettreAJourLogement(
        logement: const Logement(
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

      verify(
        () => dio.patch<dynamic>(
          path,
          data:
              '{"code_postal":"$codePostal","commune":"$commune","dpe":"B","nombre_adultes":$nombreAdultes,"nombre_enfants":$nombreEnfants,"plus_de_15_ans":$plusDe15Ans,"proprietaire":$estProprietaire,"superficie":"superficie_100","type":"maison"}',
        ),
      );
    });

    test('mettreAJourCodePostalEtCommune', () async {
      final dio = DioMock()..patchM(Endpoints.logement);

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      const codePostal = '39100';
      const commune = 'DOLE';
      await adapter.mettreAJourCodePostalEtCommune(
        codePostal: codePostal,
        commune: commune,
      );

      verify(
        () => dio.patch<dynamic>(
          Endpoints.logement,
          data: '{"code_postal":"$codePostal","commune":"$commune"}',
        ),
      );
    });

    test('supprimerLeCompte', () async {
      const path = Endpoints.utilisateur;
      final dio = DioMock()..deleteM(path);

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      await adapter.supprimerLeCompte();

      verify(() => dio.delete<dynamic>(path));
    });

    test('changerMotDePasse', () async {
      final dio = DioMock()..patchM(Endpoints.profile);

      final adapter = ProfilApiAdapter(
        client: DioHttpClient(
          dio: dio,
          authenticationService: authenticationService,
        ),
      );

      const motDePasse = 'M07D3P4553';
      await adapter.changerMotDePasse(motDePasse: motDePasse);

      verify(
        () => dio.patch<dynamic>(
          Endpoints.profile,
          data: '{"mot_de_passe":"$motDePasse"}',
        ),
      );
    });
  });
}
