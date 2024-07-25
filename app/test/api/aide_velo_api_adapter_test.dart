import 'package:app/features/aides/infrastructure/adapters/aide_velo_api_adapter.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
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
          response: CustomResponse(''),
        )
        ..patchSuccess(
          path: '/utilisateurs/$utilisateurId/logement',
          response: CustomResponse(''),
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
          ),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        secureStorage: FlutterSecureStorageMock(),
        authentificationStatusManagerWriter: AuthentificationStatutManager(),
      );
      await authentificationTokenStorage.sauvegarderToken(token);

      final adapter = AideVeloApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
          inner: client,
        ),
      );

      final result = await adapter.simuler(
        prix: 1000,
        codePostal: '39100',
        commune: 'BAVERANS',
        nombreDePartsFiscales: 2.5,
        revenuFiscal: 16000,
      );
      verify(
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/$utilisateurId/profile',
            ),
          ),
        ),
      );
      verify(
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/$utilisateurId/logement',
            ),
          ),
        ),
      );
      verify(
        () => client.send(
          any(
            that: const RequestMathcher(
              '/utilisateurs/$utilisateurId/simulerAideVelo',
            ),
          ),
        ),
      );
      expect(
        result.getRight().getOrElse(() => throw Exception()),
        aideVeloParType,
      );
    });
  });
}
