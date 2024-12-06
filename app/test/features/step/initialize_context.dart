import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../environmental_performance/summary/environmental_performance_data.dart';
import '../../helpers/dio_mock.dart';
import '../helper/feature_context.dart';

/// Usage: initialize context
Future<void> initializeContext(final WidgetTester tester) async {
  FeatureContext.reset();
  FeatureContext.instance.dioMock = DioMock();
  setFirstName();
  setProfile();
  setCommunes();
  setBilanEmpty();
  setMiniBilan();
  setMissionRecommanded();
  setAssistances();
  setPoints();
}

void setCommunes() => FeatureContext.instance.dioMock.getM(
      Uri(path: Endpoints.communes, queryParameters: {'code_postal': '39100'})
          .toString(),
      responseData: jsonDecode('''
[
  "AUTHUME",
  "BAVERANS",
  "BREVANS",
  "CHAMPVANS",
  "CHOISEY",
  "CRISSEY",
  "DOLE",
  "FOUCHERANS",
  "GEVRY",
  "JOUHE",
  "MONNIERES",
  "PARCEY",
  "SAMPANS",
  "VILLETTE LES DOLE"
]'''),
    );

void setFirstName() => FeatureContext.instance.dioMock.patchM(
      Endpoints.profile,
    );

void setProfile() => FeatureContext.instance.dioMock.getM(
      Endpoints.profile,
      responseData: jsonDecode('''
{
    "email": "joe@doe.fr",
    "nom": null,
    "prenom": null,
    "code_postal": null,
    "commune": null,
    "revenu_fiscal": null,
    "nombre_de_parts_fiscales": 1,
    "annee_naissance": null
}'''),
    );

void setBilanEmpty() => FeatureContext.instance.dioMock
    .getM(Endpoints.bilan, responseData: environmentalPerformanceEmptyData);

void setMiniBilan() => FeatureContext.instance.dioMock.getM(
      Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'),
      responseData: miniBilan,
    );

void setMissionRecommanded() => FeatureContext.instance.dioMock
    .getM(Endpoints.missionsRecommandees, responseData: <dynamic>[]);

void setAssistances() => FeatureContext.instance.dioMock.getM(
      Endpoints.assistances,
      responseData: {
        'couverture_aides_ok': false,
        'liste_aides': <dynamic>[],
      },
    );

void setPoints() => FeatureContext.instance.dioMock.getM(
      Endpoints.gamification,
      responseData: {'points': 0},
    );
