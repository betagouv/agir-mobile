import 'package:faker/faker.dart';

Map<String, dynamic> actionItemFaker() {
  final faker = Faker();

  return {
    'id': faker.guid.guid(),
    'thematique': generateThematique,
    'titre': _fakerSentenceBetter(),
    'status': faker.randomGenerator
        .element(['en_cours', 'pas_envie', 'deja_fait', 'abondon', 'fait']),
  };
}

Map<String, dynamic> actionFaker({
  final String? id,
  final String? status,
  final String? reason,
}) {
  final faker = Faker();

  final statusList = [
    'todo',
    'en_cours',
    'pas_envie',
    'deja_fait',
    'abondon',
    'fait',
  ];

  return {
    'astuces': '<p>${_fakerSentenceBetter()}</p>',
    'id': id ?? faker.guid.guid(),
    'motif': reason,
    'pourquoi': '<p>${_fakerSentenceBetter()}</p>',
    'status': status ??
        statusList.elementAt(faker.randomGenerator.integer(statusList.length)),
    'thematique': generateThematique,
    'titre': _fakerSentenceBetter(),
  };
}

Map<String, dynamic> aideVeloFaker() {
  final faker = Faker();

  return {
    'description': _fakerSentenceBetter(),
    'libelle': faker.company.name(),
    'lien': faker.internet.uri('https'),
    'logo': faker.image.loremPicsum(),
    'montant': faker.randomGenerator.integer(1000),
  };
}

Map<String, dynamic> aideVeloParTypeFaker() => {
      'mécanique simple': <Map<String, dynamic>>[],
      'électrique': List.generate(2, (final _) => aideVeloFaker()),
      'cargo': List.generate(2, (final _) => aideVeloFaker()),
      'cargo électrique': List.generate(2, (final _) => aideVeloFaker()),
      'pliant': List.generate(2, (final _) => aideVeloFaker()),
      'pliant électrique': List.generate(2, (final _) => aideVeloFaker()),
      'motorisation': <Map<String, dynamic>>[],
      'adapté': List.generate(2, (final _) => aideVeloFaker()),
    };

final generateThematique = faker.randomGenerator.element([
  'alimentation',
  'transport',
  'logement',
  'consommation',
  'climat',
  'dechet',
  'loisir',
]);

String _fakerSentenceBetter() =>
    '${faker.lorem.sentence()} ${faker.lorem.word()}';

List<Map<String, dynamic>> fakerQuestions() => [
      {
        'code': 'KYC_preference',
        'question':
            'Sur quels thèmes recherchez-vous en priorité des aides et conseils ?',
        'reponse_multiple': [
          {
            'code': 'alimentation',
            'label': 'La cuisine et l’alimentation',
            'selected': false,
          },
          {'code': 'transport', 'label': 'Mes déplacements', 'selected': false},
          {'code': 'logement', 'label': 'Mon logement', 'selected': false},
          {
            'code': 'consommation',
            'label': 'Ma consommation',
            'selected': false,
          },
          {
            'code': 'ne_sais_pas',
            'label': 'Je ne sais pas encore',
            'selected': false,
          },
        ],
        'is_answered': true,
        'categorie': 'recommandation',
        'points': 0,
        'type': 'choix_multiple',
        'is_NGC': false,
        'thematique': 'climat',
      },
      {
        'code': 'KYC_type_logement',
        'question': 'Dans quel type de logement vivez-vous ?',
        'reponse_multiple': [
          {'code': 'type_maison', 'label': 'Maison', 'selected': false},
          {
            'code': 'type_appartement',
            'label': 'Appartement',
            'selected': false,
          },
        ],
        'is_answered': false,
        'categorie': 'recommandation',
        'points': 5,
        'type': 'choix_unique',
        'is_NGC': true,
        'thematique': 'logement',
      },
      {
        'code': 'KYC_menage',
        'question': 'Combien êtes-vous dans votre logement (vous inclus) ?',
        'reponse_unique': {'value': '3'},
        'is_answered': true,
        'categorie': 'mission',
        'points': 5,
        'type': 'entier',
        'is_NGC': true,
        'thematique': 'logement',
      },
      {
        'code': 'KYC_compost_idee',
        'question':
            'Quelles sont vos idées reçues ou freins concernant le compost ?',
        'reponse_unique': {'value': 'Aucun'},
        'is_answered': true,
        'categorie': 'mission',
        'points': 5,
        'type': 'libre',
        'is_NGC': false,
        'thematique': 'alimentation',
      },
      {
        'code': 'MOSAIC_APPAREIL_NUM',
        'question': 'Quels appareils numériques possédez-vous ?',
        'reponse_multiple': [
          {
            'code': 'KYC_appareil_telephone',
            'label': 'Téléphone',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_television',
            'label': 'Télévision',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_ordi_portable',
            'label': 'Ordinateur portable',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_ordi_fixe',
            'label': 'Ordinateur fixe',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_tablette',
            'label': 'Tablette',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_enceinte_bluetooth',
            'label': 'Enceinte bluetooth',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_console_salon',
            'label': 'Console salon',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_console_portable',
            'label': 'Console portable',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
          {
            'code': 'KYC_appareil_imprimante_nbr',
            'label': 'Imprimante',
            'emoji': null,
            'image_url':
                'https://res.cloudinary.com/dq023imd8/image/upload/v1728749522/482602_8af4f622d9.png',
            'selected': false,
          },
        ],
        'is_answered': false,
        'categorie': 'mission',
        'points': 5,
        'type': 'mosaic_boolean',
        'is_NGC': false,
        'thematique': 'consommation',
      },
    ];
