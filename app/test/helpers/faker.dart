import 'package:app/features/univers/core/domain/service_item.dart';
import 'package:faker/faker.dart';

ServiceItem serviceItemFaker() => ServiceItem(
      titre: _fakerSentenceBetter(),
      sousTitre: _fakerSentenceBetter(),
      externalUrl: faker.internet.httpsUrl(),
    );

Map<String, dynamic> generateChoixUniqueQuestion(final bool withResponse) => {
      'categorie': 'mission',
      'id': 'KYC_${faker.lorem.word()}',
      'is_NGC': faker.randomGenerator.boolean(),
      'points': faker.randomGenerator.integer(10),
      'question': _fakerSentenceBetter(),
      'reponse': withResponse ? [faker.lorem.word()] : <String>[],
      'reponses_possibles': [
        faker.lorem.word(),
        faker.lorem.word(),
        faker.lorem.word(),
      ],
      'thematique': generateThematique,
      'type': 'choix_unique',
    };

// Map<String, dynamic> generateChoixMultipleQuestion() => {
//       'categorie': 'mission',
//       'id': 'KYC_${faker.lorem.word()}',
//       'is_NGC': faker.randomGenerator.boolean(),
//       'points': faker.randomGenerator.integer(10),
//       'question': _fakerSentenceBetter(),
//       'reponse': [faker.lorem.word(), faker.lorem.word()],
//       'reponses_possibles': [
//         faker.lorem.word(),
//         faker.lorem.word(),
//         faker.lorem.word(),
//       ],
//       'thematique': generateThematique,
//       'type': 'choix_multiple',
//     };

// Map<String, dynamic> generateLibreQuestion() => {
//       'categorie': 'mission',
//       'id': 'KYC_${faker.lorem.word()}',
//       'is_NGC': faker.randomGenerator.boolean(),
//       'points': faker.randomGenerator.integer(10),
//       'question': _fakerSentenceBetter(),
//       'reponse': [_fakerSentenceBetter()],
//       'reponses_possibles': <String>[],
//       'thematique': generateThematique,
//       'type': 'libre',
//     };

// Map<String, dynamic> generateMosaicBooleanQuestion() => {
//       'categorie': 'mission',
//       'id': 'MOSAIC_${faker.lorem.word().toUpperCase()}',
//       'is_answered': true,
//       'points': faker.randomGenerator.integer(20),
//       'reponses': List.generate(
//         4,
//         (final index) => {
//           'boolean_value': faker.randomGenerator.boolean(),
//           'code': 'KYC_${faker.lorem.word()}',
//           'image_url': faker.image.loremPicsum(),
//           'label': faker.lorem.word(),
//         },
//       ),
//       'titre': _fakerSentenceBetter(),
//       'type': 'mosaic_boolean',
//     };

Map<String, dynamic> actionItemFaker() {
  final faker = Faker();

  return {
    'id': faker.guid.guid(),
    'status': [
      'todo',
      'en_cours',
      'pas_envie',
      'deja_fait',
      'abondon',
      'fait',
    ].elementAt(faker.randomGenerator.integer(5)),
    'titre': _fakerSentenceBetter(),
  };
}

Map<String, dynamic> actionFaker({
  final String? id,
  final String? status,
  final String? reason,
}) {
  final faker = Faker();

  final thematique = [
    '🥦 Alimentation',
    '☀️ Climat et Environnement',
    '🛒 Consommation durable',
    '🗑️ Déchets',
    '🏡 Logement',
    '⚽ Loisirs (vacances, sport,...)',
    '🚗 Transports',
  ];

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
    'thematique_label':
        thematique.elementAt(faker.randomGenerator.integer(thematique.length)),
    'titre': _fakerSentenceBetter(),
  };
}

Map<String, dynamic> aideFaker() {
  final faker = Faker();

  return {
    'contenu': _fakerSentenceBetter(),
    'montant_max': faker.randomGenerator.boolean()
        ? faker.randomGenerator.integer(10000)
        : null,
    'thematiques_label': List.generate(
      faker.randomGenerator.integer(3),
      (final _) => faker.lorem.word(),
    ),
    'titre': faker.company.name(),
    'url_simulateur':
        faker.randomGenerator.boolean() ? faker.internet.uri('https') : null,
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
    'plafond': faker.randomGenerator.integer(1000),
  };
}

Map<String, dynamic> aideVeloParTypeFaker() => {
      'cargo': List.generate(2, (final _) => aideVeloFaker()),
      'cargo électrique': List.generate(2, (final _) => aideVeloFaker()),
      'motorisation': <Map<String, dynamic>>[],
      'mécanique simple': <Map<String, dynamic>>[],
      'pliant': List.generate(2, (final _) => aideVeloFaker()),
      'électrique': List.generate(2, (final _) => aideVeloFaker()),
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

Map<String, dynamic> questionFaker() => faker.randomGenerator.element([
      choixUniqueQuestionFaker(faker.randomGenerator.boolean()),
      choixMultipleQuestionFaker(),
      libreQuestionFaker(),
      mosaicBooleanQuestionFaker(),
      entierQuestionFaker(),
    ]);

Map<String, dynamic> choixUniqueQuestionFaker(final bool withResponse) => {
      'categorie': 'mission',
      'id': 'KYC_${faker.lorem.word()}',
      'is_NGC': faker.randomGenerator.boolean(),
      'points': faker.randomGenerator.integer(10),
      'question': _fakerSentenceBetter(),
      'reponse':
          withResponse ? [faker.lorem.word() + faker.lorem.word()] : <String>[],
      'reponses_possibles': [
        faker.lorem.word(),
        faker.lorem.word(),
        faker.lorem.word(),
      ],
      'thematique': generateThematique,
      'type': 'choix_unique',
    };

Map<String, dynamic> choixMultipleQuestionFaker() => {
      'categorie': 'mission',
      'id': 'KYC_${faker.lorem.word()}',
      'is_NGC': faker.randomGenerator.boolean(),
      'points': faker.randomGenerator.integer(10),
      'question': _fakerSentenceBetter(),
      'reponse': [
        faker.lorem.word() + faker.lorem.word(),
        faker.lorem.word() + faker.lorem.word(),
      ],
      'reponses_possibles': [
        faker.lorem.word(),
        faker.lorem.word(),
        faker.lorem.word(),
      ],
      'thematique': generateThematique,
      'type': 'choix_multiple',
    };

Map<String, dynamic> libreQuestionFaker() => {
      'categorie': 'mission',
      'id': 'KYC_${faker.lorem.word()}',
      'is_NGC': faker.randomGenerator.boolean(),
      'points': faker.randomGenerator.integer(10),
      'question': _fakerSentenceBetter(),
      'reponse': [_fakerSentenceBetter()],
      'reponses_possibles': <String>[],
      'thematique': generateThematique,
      'type': 'libre',
    };

Map<String, dynamic> mosaicBooleanQuestionFaker() => {
      'categorie': 'mission',
      'id': 'MOSAIC_${faker.lorem.word().toUpperCase()}',
      'is_answered': true,
      'points': faker.randomGenerator.integer(20),
      'reponses': List.generate(
        faker.randomGenerator.integer(10),
        (final index) => {
          'boolean_value': faker.randomGenerator.boolean(),
          'code': 'KYC_${faker.lorem.word()}',
          'image_url': faker.image.loremPicsum(),
          'label': faker.lorem.word(),
        },
      ),
      'titre': _fakerSentenceBetter(),
      'type': 'mosaic_boolean',
    };

Map<String, dynamic> entierQuestionFaker() => {
      'categorie': 'mission',
      'id': 'KYC_${faker.lorem.word()}',
      'is_NGC': faker.randomGenerator.boolean(),
      'points': faker.randomGenerator.integer(10),
      'question': _fakerSentenceBetter(),
      'reponse': [faker.randomGenerator.integer(1000).toString()],
      'reponses_possibles': <String>[],
      'thematique': generateThematique,
      'type': 'entier',
    };

String _fakerSentenceBetter() =>
    '${faker.lorem.sentence()} ${faker.lorem.word()}';
