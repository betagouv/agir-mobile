import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/profil/core/infrastructure/profil_api_adapter.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/logement/domain/logement.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/authentication_service_fake.dart';
import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'request_mathcher.dart';

void main() {
  group('ProfilApiAdapter', () {
    test('recupererProfil', () async {
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId/profile',
          response: CustomResponse('''
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
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
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
      final client = ClientMock()
        ..patchSuccess(
          path: '/utilisateurs/$utilisateurId/profile',
          response: OkResponse(),
        );

      final adapter = ProfilApiAdapter(
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
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
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/$utilisateurId/profile',
              body:
                  '{"annee_naissance":$anneeDeNaissance,"nom":"$nom","nombre_de_parts_fiscales":$nombreDePartsFiscales,"prenom":"$prenom","revenu_fiscal":$revenuFiscal}',
            ),
          ),
        ),
      );
    });

    test('recupererLogement', () async {
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId/logement',
          response: CustomResponse('''
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
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
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
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId/logement',
          response: CustomResponse('''
{
}'''),
        );

      final adapter = ProfilApiAdapter(
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
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
      const path = '/utilisateurs/$utilisateurId/logement';
      final client = ClientMock()
        ..patchSuccess(path: path, response: OkResponse());

      final adapter = ProfilApiAdapter(
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
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
        () => client.send(
          any(
            that: const RequestMathcher(
              path,
              body:
                  '{"code_postal":"$codePostal","commune":"$commune","dpe":"B","nombre_adultes":$nombreAdultes,"nombre_enfants":$nombreEnfants,"plus_de_15_ans":$plusDe15Ans,"proprietaire":$estProprietaire,"superficie":"superficie_100","type":"maison"}',
            ),
          ),
        ),
      );
    });

    test('mettreAJourCodePostalEtCommune', () async {
      final client = ClientMock()
        ..patchSuccess(
          path: '/utilisateurs/$utilisateurId/logement',
          response: OkResponse(),
        );

      final adapter = ProfilApiAdapter(
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
        ),
      );

      const codePostal = '39100';
      const commune = 'DOLE';
      await adapter.mettreAJourCodePostalEtCommune(
        codePostal: codePostal,
        commune: commune,
      );

      verify(
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/$utilisateurId/logement',
              body: '{"code_postal":"$codePostal","commune":"$commune"}',
            ),
          ),
        ),
      );
    });

    test('supprimerLeCompte', () async {
      const path = '/utilisateurs/$utilisateurId';
      final client = ClientMock()
        ..deleteSuccess(path: path, response: OkResponse());

      final adapter = ProfilApiAdapter(
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
        ),
      );

      await adapter.supprimerLeCompte();

      verify(() => client.send(any(that: const RequestMathcher(path))));
    });

    test('changerMotDePasse', () async {
      final client = ClientMock()
        ..patchSuccess(
          path: '/utilisateurs/$utilisateurId/profile',
          response: OkResponse(),
        );

      final adapter = ProfilApiAdapter(
        client: AuthentificationApiClient(
          apiUrl: apiUrl,
          authenticationService: const AuthenticationServiceFake(),
          inner: client,
        ),
      );

      const motDePasse = 'M07D3P4553';
      await adapter.changerMotDePasse(motDePasse: motDePasse);

      verify(
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/$utilisateurId/profile',
              body: '{"mot_de_passe":"$motDePasse"}',
            ),
          ),
        ),
      );
    });
  });
}
