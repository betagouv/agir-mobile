import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../environmental_performance/summary/environmental_performance_data.dart';
import '../../helpers/dio_mock.dart';
import '../../old/mocks/flutter_secure_storage_fake.dart';
import '../helper/feature_context.dart';
import '../helper/package_info_fake.dart';

/// Usage: initialize context
Future<void> initializeContext(final WidgetTester tester) async {
  FeatureContext.reset();
  FeatureContext.instance.secureStorage = FlutterSecureStorageFake();
  FeatureContext.instance.packageInfo = const PackageInfoFake(version: '1.2.3', buildNumber: '4');
  FeatureContext.instance.dioMock = DioMock();
  setLogout();
  setNotification();
  setFirstName();
  setProfile();
  setDeleteAccount();
  setForgotPassword();
  setCommunes();
  setLogement();
  setPreferences();
  setBilanEmpty();
  setMiniBilan();
  setMissionRecommanded();
  setMissionRecommandedByThematique();
  setAssistances();
  setPoints();
  setChallenges();
  setRecommandations();
  setServices();
  setBicycleSimulator();
}

void setLogout() => FeatureContext.instance.dioMock.postM(Endpoints.logout);

void setNotification() {
  FeatureContext.instance.dioMock.deleteM(Endpoints.notificationToken);
  FeatureContext.instance.dioMock.putM(Endpoints.notificationToken);
}

void setFirstName() => FeatureContext.instance.dioMock.patchM(Endpoints.profile);

void setProfile() {
  FeatureContext.instance.dioMock.getM(
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
  FeatureContext.instance.dioMock.patchM(Endpoints.profile);
}

void setLogement() => FeatureContext.instance.dioMock.patchM(Endpoints.logement);

void setBilanEmpty() => FeatureContext.instance.dioMock.getM(Endpoints.bilan, responseData: environmentalPerformanceEmptyData);

void setMiniBilan() =>
    FeatureContext.instance.dioMock.getM(Endpoints.questions('ENCHAINEMENT_KYC_mini_bilan_carbone'), responseData: miniBilan);

void setMissionRecommanded() => FeatureContext.instance.dioMock.getM(Endpoints.missionsRecommandees, responseData: <dynamic>[]);

void setMissionRecommandedByThematique() =>
    FeatureContext.instance.dioMock.getM(Endpoints.missionsRecommandeesParThematique('alimentation'), responseData: <dynamic>[]);

void setAssistances() => FeatureContext.instance.dioMock.getM(
  Endpoints.aids,
  responseData: {
    'couverture_aides_ok': false,
    'liste_aides': [
      {
        'id': 'renover_son_logement',
        'titre': 'Rénover son logement',
        'thematiques': ['logement'],
        'contenu': '',
        'est_gratuit': false,
      },
      {
        'titre': 'Acheter un vélo',
        'contenu':
            "<p>Vous souhaitez acheter un vélo neuf ou d'occasion, qu'il soit électrique ou classique ? Cette aide est faite pour vous !</p><p></p><h3><strong>Votre éligibilité</strong></h3><p><strong>1 aide nationale disponible</strong> pour les <strong>majeurs, domiciliés en France</strong></p><p><strong>Plusieurs aides sous conditions</strong></p><p></p><h3><strong>Types de vélo</strong></h3><ul><li><p>Mécanique / Électrique</p></li><li><p>Classique / Pliant / Cargo</p></li></ul><p></p><h3><strong>En quoi cela a de l'impact ?</strong></h3><p>Le vélo est un des moyens de transport les moins carbonés.</p><p>Il peut remplacer la voiture dans de nombreux cas et c'est bon pour la santé !</p>",
        'url_simulateur': '/aides/velo',
        'thematiques': ['transport'],
        'montant_max': 1500,
        'est_gratuit': false,
      },
      {
        'id': 'composter_ses_dechets',
        'titre': 'Composter ses déchets',
        'thematiques': ['alimentation'],
        'contenu': '',
        'est_gratuit': true,
      },
    ],
  },
);

void setPoints() => FeatureContext.instance.dioMock.getM(Endpoints.gamification, responseData: {'points': 650});

void setPreferences() =>
    FeatureContext.instance.dioMock
      ..getM(
        Endpoints.questionKyc('KYC_preference'),
        responseData: {
          'code': 'KYC_preference',
          'question': 'Sur quels thèmes recherchez-vous en priorité des aides et conseils ?',
          'reponse_multiple': [
            {'code': 'alimentation', 'label': 'La cuisine et l’alimentation', 'selected': false},
            {'code': 'transport', 'label': 'Mes déplacements', 'selected': false},
            {'code': 'logement', 'label': 'Mon logement', 'selected': false},
            {'code': 'consommation', 'label': 'Ma consommation', 'selected': false},
            {'code': 'ne_sais_pas', 'label': 'Je ne sais pas encore', 'selected': false},
          ],
          'is_answered': true,
          'categorie': 'recommandation',
          'points': 0,
          'type': 'choix_multiple',
          'is_NGC': false,
          'thematique': 'climat',
        },
      )
      ..putM(Endpoints.questionKyc('KYC_preference'));

void setDeleteAccount() => FeatureContext.instance.dioMock.deleteM(Endpoints.utilisateur);

void setForgotPassword() =>
    FeatureContext.instance.dioMock
      ..postM(Endpoints.oubliMotDePasse)
      ..postM(Endpoints.modifierMotDePasse);

void setCommunes() => FeatureContext.instance.dioMock.getM(
  Endpoints.communes('39100'),
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

void setChallenges() =>
    FeatureContext.instance.dioMock
      ..getM('/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours', responseData: <dynamic>[])
      ..getM('/utilisateurs/%7BuserId%7D/defis_v2?status=en_cours&thematique=alimentation', responseData: <dynamic>[]);

void setRecommandations() =>
    FeatureContext.instance.dioMock..getM(Endpoints.recommandationsParThematique('alimentation'), responseData: <dynamic>[]);

void setServices() =>
    FeatureContext.instance.dioMock
      ..getM(
        Endpoints.servicesParThematique('alimentation'),
        responseData: jsonDecode('''
[
 {
      "id_service": "fruits_legumes",
      "titre": "Fruits et légumes de saison",
      "sous_titre": "janvier",
      "external_url": "https://impactco2.fr/outils/fruitsetlegumes",
      "icon_url": "https://agir-front-dev.osc-fr1.scalingo.io/cerise.webp",
      "thematique": "alimentation",
      "is_available_inhouse": true
  }
]'''),
      )
      ..getM(
        Endpoints.seasonalFruitsAndVegetablesCategories,
        responseData: jsonDecode(
          '''
[{"code":"janvier","label":"janvier","is_default":true},{"code":"fevrier","label":"février","is_default":false},{"code":"mars","label":"mars","is_default":false},{"code":"avril","label":"avril","is_default":false},{"code":"mai","label":"mai","is_default":false},{"code":"juin","label":"juin","is_default":false},{"code":"juillet","label":"juillet","is_default":false},{"code":"aout","label":"août","is_default":false},{"code":"septembre","label":"septembre","is_default":false},{"code":"octobre","label":"octobre","is_default":false},{"code":"novembre","label":"novembre","is_default":false},{"code":"decembre","label":"décembre","is_default":false}]''',
        ),
      )
      ..postM(
        Endpoints.seasonalFruitsAndVegetablesSearch,
        requestData: {'categorie': 'janvier'},
        responseData: jsonDecode('''
{
  "encore_plus_resultats_dispo": true,
  "resultats": [
    {
      "id": "poire",
      "titre": "Poire",
      "impact_carbone_kg": 0.387319,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/poire.svg",
      "emoji": "🍐",
      "type_fruit_legume": "fruit"

    },
    {
      "id": "carotte",
      "titre": "Carotte",
      "impact_carbone_kg": 0.3960665,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/carotte.svg",
      "emoji": "🥕",
      "type_fruit_legume": "legume"

    },
    {
      "id": "navet",
      "titre": "Navet",
      "impact_carbone_kg": 0.3961,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/navet.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"

    },
    {
      "id": "betterave",
      "titre": "Betterave",
      "impact_carbone_kg": 0.40736649999999996,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/betterave.svg",
      "emoji": "🍠",
      "type_fruit_legume": "legume"

    },
    {
      "id": "pomme",
      "titre": "Pomme",
      "impact_carbone_kg": 0.40819489999999997,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/pomme.svg",
      "emoji": "🍏",
      "type_fruit_legume": "fruit"

    },
    {
      "id": "oignon",
      "titre": "Oignon",
      "impact_carbone_kg": 0.4204685,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/oignon.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"

    },
    {
      "id": "epinard",
      "titre": "Épinard",
      "impact_carbone_kg": 0.42256999999999995,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/epinard.svg",
      "emoji": null,
      "type_fruit_legume": "legume"

    },
    {
      "id": "mandarine",
      "titre": "Mandarine",
      "impact_carbone_kg": 0.4684038,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/mandarine.svg",
      "emoji": "🍊",
      "type_fruit_legume": "fruit"

    },
    {
      "id": "topinambour",
      "titre": "Topinambour",
      "impact_carbone_kg": 0.49126650000000005,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/topinambour.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"

    },
    {
      "id": "panais",
      "titre": "Panais",
      "impact_carbone_kg": 0.4942756,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/panais.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"

    },
    {
      "id": "salsifis",
      "titre": "Salsifis",
      "impact_carbone_kg": 0.4942756,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/salsifis.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"

    },
    {
      "id": "grenade",
      "titre": "Grenade",
      "impact_carbone_kg": 0.4985215,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/grenade.svg",
      "emoji": "🌱",
      "type_fruit_legume": "fruit"

    },
    {
      "id": "carambole",
      "titre": "Carambole",
      "impact_carbone_kg": 0.5535079999999999,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/carambole.svg",
      "emoji": "🌱",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "choudebruxelles",
      "titre": "Chou de Bruxelles",
      "impact_carbone_kg": 0.562147,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/choudebruxelles.svg",
      "emoji": "🥬",
      "type_fruit_legume": "legume"
    },
    {
      "id": "poireau",
      "titre": "Poireau",
      "impact_carbone_kg": 0.6113778000000001,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/poireau.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"
    },
    {
      "id": "courge",
      "titre": "Courge",
      "impact_carbone_kg": 0.6382,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/courge.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"
    },
    {
      "id": "potiron",
      "titre": "Potiron",
      "impact_carbone_kg": 0.6382329999999999,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/potiron.svg",
      "emoji": "🎃",
      "type_fruit_legume": "legume"
    },
    {
      "id": "orange",
      "titre": "Orange",
      "impact_carbone_kg": 0.6776838000000001,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/orange.svg",
      "emoji": "🍊",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "celeri",
      "titre": "Céleri",
      "impact_carbone_kg": 0.7157324,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/celeri.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"
    },
    {
      "id": "choufleur",
      "titre": "Chou-fleur",
      "impact_carbone_kg": 0.720705,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/choufleur.svg",
      "emoji": "🥦",
      "type_fruit_legume": "legume"
    },
    {
      "id": "citron",
      "titre": "Citron",
      "impact_carbone_kg": 0.7635958,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/citron.svg",
      "emoji": "🍋",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "chou",
      "titre": "Chou",
      "impact_carbone_kg": 0.8476329999999999,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/chou.svg",
      "emoji": "🥬",
      "type_fruit_legume": "legume"
    },
    {
      "id": "endive",
      "titre": "Endive",
      "impact_carbone_kg": 0.861009,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/endive.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"
    },
    {
      "id": "cresson",
      "titre": "Cresson",
      "impact_carbone_kg": 0.868145,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/cresson.svg",
      "emoji": "🌱",
      "type_fruit_legume": "legume"
    },
    {
      "id": "mache",
      "titre": "Mâche",
      "impact_carbone_kg": 0.868145,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/mache.svg",
      "emoji": "🥗",
      "type_fruit_legume": "legume"
    },
    {
      "id": "banane",
      "titre": "Banane",
      "impact_carbone_kg": 0.908523,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/banane.svg",
      "emoji": "🍌",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "fruitdelapassion",
      "titre": "Fruit de la passion",
      "impact_carbone_kg": 0.937608,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/fruitdelapassion.svg",
      "emoji": "🌱",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "kaki",
      "titre": "Kaki",
      "impact_carbone_kg": 0.9495215,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/kaki.svg",
      "emoji": "🌱",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "kiwi",
      "titre": "Kiwi",
      "impact_carbone_kg": 1.0015,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/kiwi.svg",
      "emoji": "🥝",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "clementine",
      "titre": "Clémentine",
      "impact_carbone_kg": 1.3019120000000002,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/clementine.svg",
      "emoji": "🍊",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "ananas",
      "titre": "Ananas",
      "impact_carbone_kg": 1.3614345,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/ananas.svg",
      "emoji": "🍍",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "avocat",
      "titre": "Avocat",
      "impact_carbone_kg": 1.5525229999999999,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/avocat.svg",
      "emoji": "🥑",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "noixdecoco",
      "titre": "Noix de coco",
      "impact_carbone_kg": 2.4109410000000002,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/noixdecoco.svg",
      "emoji": "🥥",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "datte",
      "titre": "Datte",
      "impact_carbone_kg": 2.8927609999999997,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/datte.svg",
      "emoji": "🌱",
      "type_fruit_legume": "fruit"
    },
    {
      "id": "champignonmorille",
      "titre": "Champignon (morille crue)",
      "impact_carbone_kg": 6.175009000000001,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/null",
      "emoji": null,
      "type_fruit_legume": "legume"
    },
    {
      "id": "mangue",
      "titre": "Mangue",
      "impact_carbone_kg": 11.655508000000001,
      "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/mangue.svg",
      "emoji": "🥭",
      "type_fruit_legume": "fruit"
    }
  ]
}'''),
      )
      ..postM(
        Endpoints.seasonalFruitsAndVegetablesSearch,
        requestData: {'categorie': 'juin'},
        responseData: jsonDecode('''
{
    "encore_plus_resultats_dispo": true,
    "resultats": [
        {
            "id": "radis",
            "titre": "Radis",
            "impact_carbone_kg": 0.3847324,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/radis.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "haricotvert",
            "titre": "Haricot vert (cru)",
            "impact_carbone_kg": 0.44645700000000005,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/haricotvert.svg",
            "emoji": "🫘",
            "type_fruit_legume": "legume"
        },
        {
            "id": "aubergine",
            "titre": "Aubergine",
            "impact_carbone_kg": 0.47203700000000004,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/aubergine.svg",
            "emoji": "🍆",
            "type_fruit_legume": "legume"
        },
        {
            "id": "courgette",
            "titre": "Courgette",
            "impact_carbone_kg": 0.49850700000000003,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/courgette.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "fraise",
            "titre": "Fraise",
            "impact_carbone_kg": 0.51107,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/fraise.svg",
            "emoji": "🍓",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "concombre",
            "titre": "Concombre",
            "impact_carbone_kg": 0.5122949,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/concombre.svg",
            "emoji": "🥒",
            "type_fruit_legume": "legume"
        },
        {
            "id": "blette",
            "titre": "Blette",
            "impact_carbone_kg": 0.5811,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/blette.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "peche",
            "titre": "Pêche",
            "impact_carbone_kg": 0.5905215,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/peche.svg",
            "emoji": "🍑",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "tomate",
            "titre": "Tomate",
            "impact_carbone_kg": 0.6256,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/tomate.svg",
            "emoji": "🍅",
            "type_fruit_legume": "fruit_et_legume"
        },
        {
            "id": "pasteque",
            "titre": "Pastèque",
            "impact_carbone_kg": 0.6805,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/pasteque.svg",
            "emoji": "🍉",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "rhubarbe",
            "titre": "Rhubarbe",
            "impact_carbone_kg": 0.7015215,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/rhubarbe.svg",
            "emoji": "🌱",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "petitpois",
            "titre": "Petit pois",
            "impact_carbone_kg": 0.701761,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/petitpois.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "poivron",
            "titre": "Poivron",
            "impact_carbone_kg": 0.7154,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/poivron.svg",
            "emoji": "🌶️",
            "type_fruit_legume": "legume"
        },
        {
            "id": "cresson",
            "titre": "Cresson",
            "impact_carbone_kg": 0.868145,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/cresson.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "laitue",
            "titre": "Laitue",
            "impact_carbone_kg": 0.868145,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/laitue.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "banane",
            "titre": "Banane",
            "impact_carbone_kg": 0.908523,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/banane.svg",
            "emoji": "🍌",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "pamplemousse",
            "titre": "Pamplemousse",
            "impact_carbone_kg": 0.9255958,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/pamplemousse.svg",
            "emoji": "🍊",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "fruitdelapassion",
            "titre": "Fruit de la passion",
            "impact_carbone_kg": 0.937608,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/fruitdelapassion.svg",
            "emoji": "🌱",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "melon",
            "titre": "Melon",
            "impact_carbone_kg": 0.978343,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/melon.svg",
            "emoji": "🍈",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "fenouil",
            "titre": "Fenouil",
            "impact_carbone_kg": 1.018233,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/fenouil.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "ananas",
            "titre": "Ananas",
            "impact_carbone_kg": 1.3614345,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/ananas.svg",
            "emoji": "🍍",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "abricot",
            "titre": "Abricot",
            "impact_carbone_kg": 1.451508,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/abricot.svg",
            "emoji": "🍑",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "framboise",
            "titre": "Framboise",
            "impact_carbone_kg": 1.5430878,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/framboise.svg",
            "emoji": "🌱",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "avocat",
            "titre": "Avocat",
            "impact_carbone_kg": 1.5525229999999999,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/avocat.svg",
            "emoji": "🥑",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "asperge",
            "titre": "Asperge",
            "impact_carbone_kg": 1.638878,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/asperge.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "cerise",
            "titre": "Cerise",
            "impact_carbone_kg": 1.7445080000000002,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/cerise.svg",
            "emoji": "🍒",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "groseille",
            "titre": "Groseille",
            "impact_carbone_kg": 1.8945215,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/groseille.svg",
            "emoji": "🌱",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "cassis",
            "titre": "Cassis",
            "impact_carbone_kg": 1.903508,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/cassis.svg",
            "emoji": "🌱",
            "type_fruit_legume": "fruit"
        },
        {
            "id": "artichaut",
            "titre": "Artichaut",
            "impact_carbone_kg": 2.556166,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/artichaut.svg",
            "emoji": "🌱",
            "type_fruit_legume": "legume"
        },
        {
            "id": "champignonmorille",
            "titre": "Champignon (morille crue)",
            "impact_carbone_kg": 6.175009000000001,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/champignonmorille.svg",
            "emoji": "🍄",
            "type_fruit_legume": "legume"
        },
        {
            "id": "mangue",
            "titre": "Mangue",
            "impact_carbone_kg": 11.655508000000001,
            "image_url": "https://agir-front-dev.osc-fr1.scalingo.io/impact_co2_img_fruits_legumes/mangue.svg",
            "emoji": "🥭",
            "type_fruit_legume": "fruit"
        }
    ]
}'''),
      );

void setBicycleSimulator() => FeatureContext.instance.dioMock.postM(
  Endpoints.simulerAideVelo,
  responseData: jsonDecode('''
{
    "mécanique simple": [],
    "électrique": [],
    "cargo": [],
    "cargo électrique": [],
    "pliant": [],
    "pliant électrique": [],
    "motorisation": [],
    "adapté": []
}'''),
);
