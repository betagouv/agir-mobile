import 'package:app/features/authentification/domain/entities/authentification_statut_manager.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/authentification/infrastructure/adapters/authentification_token_storage.dart';
import 'package:app/features/univers/domain/value_objects/service_item.dart';
import 'package:app/features/univers/infrastructure/adapters/univers_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../old/api/client_mock.dart';
import '../old/api/constants.dart';
import '../old/api/custom_response.dart';
import '../old/api/flutter_secure_storage_mock.dart';

void main() {
  test('getServices', () async {
    const universType = 'alimentation';
    final client = ClientMock()
      ..patchSuccess(
        path: '/utilisateurs/$utilisateurId/recherche_services/$universType',
        response: OkResponse(
          value: '''
[
    {
        "id_service": "fruits_legumes",
        "titre": "Fruits et légumes de saison",
        "sous_titre": "septembre",
        "external_url": "https://impactco2.fr/outils/fruitsetlegumes",
        "icon_url": "https://agir-front-dev.osc-fr1.scalingo.io/cerise.png",
        "univers": "alimentation",
        "is_available_inhouse": true
    },
    {
        "id_service": "compost_local",
        "titre": "Où composter proche de chez moi ?",
        "sous_titre": "Réseau Compost Citoyen",
        "external_url": "https://reseaucompost.org/annuaire/geocompost-la-carte",
        "icon_url": "https://reseaucompost.org/themes/custom/rcc/logo.svg",
        "univers": "alimentation",
        "is_available_inhouse": false
    }
]''',
        ),
      );

    final authentificationTokenStorage = AuthentificationTokenStorage(
      secureStorage: FlutterSecureStorageMock(),
      authentificationStatusManagerWriter: AuthentificationStatutManager(),
    );
    await authentificationTokenStorage.sauvegarderToken(token);
    final apiClient = AuthentificationApiClient(
      apiUrl: apiUrl,
      authentificationTokenStorage: authentificationTokenStorage,
      inner: client,
    );

    final adapter = UniversApiAdapter(apiClient: apiClient);

    final services = await adapter.getServices(universType);

    expect(services.getRight().getOrElse(() => throw Exception()), [
      const ServiceItem(
        titre: 'Fruits et légumes de saison',
        sousTitre: 'septembre',
        externalUrl: 'https://impactco2.fr/outils/fruitsetlegumes',
      ),
      const ServiceItem(
        titre: 'Où composter proche de chez moi ?',
        sousTitre: 'Réseau Compost Citoyen',
        externalUrl: 'https://reseaucompost.org/annuaire/geocompost-la-carte',
      ),
    ]);
  });
}
