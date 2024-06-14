import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:app/features/profil/domain/entities/mes_informations.dart';
import 'package:app/features/profil/infrastructure/adapters/profil_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';
import 'request_mathcher.dart';

void main() {
  group('ProfilApiAdapter', () {
    test('recupererProfil', () async {
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId/profile',
          response: CustomResponse('''
{
    "email": "ww@w.com",
    "nom": "WWW",
    "prenom": "Wojtek",
    "code_postal": "75001",
    "commune": "PARIS 01",
    "revenu_fiscal": 16000,
    "nombre_de_parts_fiscales": 2.5,
    "abonnement_ter_loire": false,
    "onboarding_result": {
        "logement"    : 3,
        "transports"  : 4,
        "alimentation": 1,
        "consommation": 2
    },
    "logement": {
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
    }
}'''),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        secureStorage: FlutterSecureStorageMock(),
        authentificationStatusManager: AuthentificationStatutManager(),
      );
      await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

      final adapter = ProfilApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
          inner: client,
        ),
      );

      final result = await adapter.recupererProfil();
      expect(
        result,
        const MesInformations(
          prenom: 'Wojtek',
          nom: 'WWW',
          email: 'ww@w.com',
          codePostal: '75001',
          ville: 'PARIS 01',
          nombreDePartsFiscales: 2.5,
          revenuFiscal: 16000,
        ),
      );
    });
    test('mettreAJour', () async {
      final client = ClientMock()
        ..patchSuccess(
          path: '/utilisateurs/$utilisateurId/profile',
          response: CustomResponse(''),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        secureStorage: FlutterSecureStorageMock(),
        authentificationStatusManager: AuthentificationStatutManager(),
      );
      await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

      final adapter = ProfilApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
          inner: client,
        ),
      );

      const prenom = 'Prénom';
      const nom = 'Nom';
      const email = 'nouveau@mail.com';
      const nombreDePartsFiscales = 2.5;
      const revenuFiscal = 16000;
      await adapter.mettreAJour(
        prenom: prenom,
        nom: nom,
        email: email,
        nombreDePartsFiscales: nombreDePartsFiscales,
        revenuFiscal: revenuFiscal,
      );

      verify(
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/$utilisateurId/profile',
              body:
                  '{"email":"$email","nom":"$nom","nombre_de_parts_fiscales":$nombreDePartsFiscales,"prenom":"$prenom","revenu_fiscal":$revenuFiscal}',
            ),
          ),
        ),
      );
    });
  });
}
