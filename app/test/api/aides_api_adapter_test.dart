import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/infrastructure/adapters/aides_api_adapter.dart';
import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/api/authentification_token_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'client_mock.dart';
import 'constants.dart';
import 'custom_response.dart';
import 'flutter_secure_storage_mock.dart';

void main() {
  group('AidesApiAdapter', () {
    test('recupereLesAides', () async {
      // Arrange.
      const thematique1 = '🏡 Logement';
      const aide1 = 'Rénover son logement';
      const contenu1 = '<p>contenu1</p>';

      const thematique2 = '🚗 Transports';
      const aide2 = 'Acheter un vélo';
      const montantMax = 1500;
      const contenu2 = 'contenu2';
      const urlSimulateur2 = '/vos-aides/velo';

      const thematique3 = '🗑️ Déchets';
      const aide3 = 'Composter ses déchets';
      const contenu3 = 'contenu3';

      final client = ClientMock()
        ..getSuccess(
          path: '/utilisateurs/$utilisateurId/aides',
          response: CustomResponse(
            '''
[
    {
        "content_id": "9",
        "titre": "$aide1",
        "contenu": "$contenu1",
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
        "contenu": "$contenu2",
        "url_simulateur": "$urlSimulateur2",
        "is_simulateur": true,
        "codes_postaux": [],
        "thematiques": ["transport"],
        "thematiques_label": ["$thematique2"],
        "montant_max": $montantMax,
        "besoin_desc": "Acheter un vélo",
        "besoin": "acheter_velo"
    },
    {
        "content_id": "25",
        "titre": "$aide3",
        "contenu": "$contenu3",
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
          ),
        );

      final authentificationTokenStorage = AuthentificationTokenStorage(
        secureStorage: FlutterSecureStorageMock(),
        authentificationStatusManager: AuthentificationStatutManager(),
      );
      await authentificationTokenStorage.sauvegarderTokenEtUtilisateurId(
        token,
        utilisateurId,
      );

      final adapter = AidesApiAdapter(
        apiClient: AuthentificationApiClient(
          apiUrl: apiUrl,
          authentificationTokenStorage: authentificationTokenStorage,
          inner: client,
        ),
      );

      // Act.
      final aides = await adapter.recupereLesAides();

      // Assert.
      expect(aides, [
        const Aide(titre: aide1, thematique: thematique1, contenu: contenu1),
        const Aide(
          titre: aide2,
          thematique: thematique2,
          contenu: contenu2,
          montantMax: montantMax,
          urlSimulateur: urlSimulateur2,
        ),
        const Aide(titre: aide3, thematique: thematique3, contenu: contenu3),
      ]);
    });
  });
}
