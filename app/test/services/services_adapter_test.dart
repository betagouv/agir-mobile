import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/infrastructure/theme_api_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../helpers/dio_mock.dart';
import '../old/mocks/authentication_service_fake.dart';

void main() {
  test('getServices', () async {
    const themeType = 'alimentation';
    final dio = DioMock()
      ..getM(
        Endpoints.servicesParThematique(themeType),
        responseData: jsonDecode(
          '''
[
    {
        "id_service": "fruits_legumes",
        "titre": "Fruits et légumes de saison",
        "sous_titre": "septembre",
        "external_url": "https://impactco2.fr/outils/fruitsetlegumes",
        "icon_url": "https://jagis-front-dev.osc-fr1.scalingo.io/cerise.png",
        "thematique": "alimentation",
        "is_available_inhouse": true
    },
    {
        "id_service": "compost_local",
        "titre": "Où composter proche de chez moi ?",
        "sous_titre": "Réseau Compost Citoyen",
        "external_url": "https://reseaucompost.org/annuaire/geocompost-la-carte",
        "icon_url": "https://reseaucompost.org/themes/custom/rcc/logo.svg",
        "thematique": "alimentation",
        "is_available_inhouse": false
    }
]''',
        ),
      );

    final adapter = ThemeApiAdapter(
      client: DioHttpClient(
        dio: dio,
        authenticationService: const AuthenticationServiceFake(),
      ),
    );

    final services = await adapter.getServices(themeType);

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
