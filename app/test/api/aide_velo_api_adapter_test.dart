import 'package:app/src/fonctionnalites/aides/domain/aide_velo.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_collectivite.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_par_type.dart';
import 'package:app/src/fonctionnalites/aides/infrastructure/adapters/aide_velo_api_adapter.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';
import 'request_mathcher.dart';

const aideVeloParType = AideVeloParType(
  mecaniqueSimple: [],
  electrique: [
    AideVelo(
      libelle: 'Bonus vélo',
      description:
          'Nouveau bonus vélo électrique applicable à partir du 14 février 2024.',
      lien: 'https://www.service-public.fr/particuliers/vosdroits/F36828',
      collectivite: AideVeloCollectivite(kind: 'pays', value: 'France'),
      montant: 300,
      plafond: 300,
      logo:
          'https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp',
    ),
  ],
  cargo: [
    AideVelo(
      libelle: 'Bonus vélo',
      description:
          'Nouveau bonus vélo cargo applicable à partir du 14 février 2024.',
      lien: 'https://www.service-public.fr/particuliers/vosdroits/F36828',
      collectivite: AideVeloCollectivite(kind: 'pays', value: 'France'),
      montant: 400,
      plafond: 400,
      logo:
          'https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp',
    ),
  ],
  cargoElectrique: [
    AideVelo(
      libelle: 'Bonus vélo',
      description:
          'Nouveau bonus vélo cargo électrique applicable à partir du 14 février 2024.',
      lien: 'https://www.service-public.fr/particuliers/vosdroits/F36828',
      collectivite: AideVeloCollectivite(kind: 'pays', value: 'France'),
      montant: 400,
      plafond: 400,
      logo:
          'https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp',
    ),
  ],
  pliant: [
    AideVelo(
      libelle: 'Bonus vélo',
      description:
          'Nouveau bonus vélo pliant applicable à partir du 14 février 2024.',
      lien: 'https://www.service-public.fr/particuliers/vosdroits/F36828',
      collectivite: AideVeloCollectivite(kind: 'pays', value: 'France'),
      montant: 400,
      plafond: 400,
      logo:
          'https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp',
    ),
  ],
  motorisation: [],
);

void main() {
  group('AideVeloApiAdapter', () {
    test('simuler', () async {
      final client = ClientMock()
        ..patchSuccess(
          path: '/utilisateurs/$utilisateurId/profile',
          response: CustomResponse('', 200),
        )
        ..patchSuccess(
          path: '/utilisateurs/$utilisateurId/logement',
          response: CustomResponse('', 200),
        )
        ..postSuccess(
          path: '/utilisateurs/$utilisateurId/simulerAideVelo',
          response: CustomResponse(
            '''
{
    "mécanique simple": [],
    "électrique": [
        {
            "libelle": "Bonus vélo",
            "description": "Nouveau bonus vélo électrique applicable à partir du 14 février 2024.",
            "lien": "https://www.service-public.fr/particuliers/vosdroits/F36828",
            "collectivite": {"kind": "pays", "value": "France"},
            "montant": 300,
            "plafond": 300,
            "logo": "https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp"
        }
    ],
    "cargo": [
        {
            "libelle": "Bonus vélo",
            "description": "Nouveau bonus vélo cargo applicable à partir du 14 février 2024.",
            "lien": "https://www.service-public.fr/particuliers/vosdroits/F36828",
            "collectivite": {"kind": "pays", "value": "France"},
            "montant": 400,
            "plafond": 400,
            "logo": "https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp"
        }
    ],
    "cargo électrique": [
        {
            "libelle": "Bonus vélo",
            "description": "Nouveau bonus vélo cargo électrique applicable à partir du 14 février 2024.",
            "lien": "https://www.service-public.fr/particuliers/vosdroits/F36828",
            "collectivite": {"kind": "pays", "value": "France"},
            "montant": 400,
            "plafond": 400,
            "logo": "https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp"
        }
    ],
    "pliant": [
        {
            "libelle": "Bonus vélo",
            "description": "Nouveau bonus vélo pliant applicable à partir du 14 février 2024.",
            "lien": "https://www.service-public.fr/particuliers/vosdroits/F36828",
            "collectivite": {"kind": "pays", "value": "France"},
            "montant": 400,
            "plafond": 400,
            "logo": "https://res.cloudinary.com/dq023imd8/image/upload/miniatures/logo_etat_francais.webp"
        }
    ],
    "motorisation": []
}
''',
            200,
          ),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        authentificationStatusManager: AuthentificationStatutManager(),
        secureStorage: FlutterSecureStorageMock(),
      );
      await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

      final adapter = AideVeloApiAdapter(
        apiClient: AuthentificationApiClient(
          inner: client,
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
        ),
      );

      final result = await adapter.simuler(
        prix: 1000,
        codePostal: '39100',
        ville: 'BAVERANS',
        nombreDePartsFiscales: 2.5,
        revenuFiscal: 16000,
      );
      verify(
        () => client.send(
          any(that: RequestMathcher('/utilisateurs/$utilisateurId/profile')),
        ),
      );
      verify(
        () => client.send(
          any(that: RequestMathcher('/utilisateurs/$utilisateurId/logement')),
        ),
      );
      verify(
        () => client.send(
          any(
            that: RequestMathcher(
              '/utilisateurs/$utilisateurId/simulerAideVelo',
            ),
          ),
        ),
      );
      expect(result, aideVeloParType);
    });
  });
}
