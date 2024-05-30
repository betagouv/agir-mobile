import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/infrastructure/adapters/aides_api_adapter.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut_manager.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/src/fonctionnalites/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  group('AidesApiAdapter', () {
    test('recupereLesAides', () async {
      // Arrange
      const aide1 = 'Rénover son logement';
      const aide2 = 'Acheter un vélo';
      const aide3 = 'Composter ses déchets';
      const thematique1 = '🏡 Logement';
      const thematique2 = '🚗 Transports';
      const thematique3 = '🗑️ Déchets';
      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId/aides',
          response: CustomResponse(
            '''
[
    {
        "content_id": "9",
        "titre": "$aide1",
        "contenu": "contenu1",
        "url_simulateur": null,
        "is_simulateur": false,
        "codes_postaux": [],
        "thematiques": ["logement"],
        "thematiques_label": ["$thematique1"],
        "montant_max": null,
        "besoin_desc": "Rénover son logement",
        "besoin": "reno_logement"
    },
    {
        "content_id": "3",
        "titre": "$aide2",
        "contenu": "contenu2",
        "url_simulateur": "/vos-aides/velo",
        "is_simulateur": true,
        "codes_postaux": [],
        "thematiques": ["transport"],
        "thematiques_label": ["$thematique2"],
        "montant_max": 1500,
        "besoin_desc": "Acheter un vélo",
        "besoin": "acheter_velo"
    },
    {
        "content_id": "25",
        "titre": "$aide3",
        "contenu": "contenu3",
        "url_simulateur": null,
        "is_simulateur": false,
        "codes_postaux": [
            "21000" , " 21700", " 21560", " 21110", " 21300", " 21800",
            " 21160", " 21121", " 21600", " 21160", " 21370", " 21850", " 21240"
        ],
        "thematiques": ["dechet"],
        "thematiques_label": ["$thematique3"],
        "montant_max": null,
        "besoin_desc": "Composter ses déchets",
        "besoin": "composter"
    }
]''',
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

      final adapter = AidesApiAdapter(
        apiClient: AuthentificationApiClient(
          inner: client,
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
        ),
      );

      // Act
      final aides = await adapter.recupereLesAides();

      // Assert
      expect(aides, [
        const Aide(titre: aide1, thematique: thematique1),
        const Aide(titre: aide2, thematique: thematique2),
        const Aide(titre: aide3, thematique: thematique3),
      ]);
    });
  });
}
