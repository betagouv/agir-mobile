import 'package:faker/faker.dart';

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
    'titre': faker.lorem.sentence(),
  };
}

Map<String, dynamic> aideFaker() {
  final faker = Faker();

  return {
    'contenu': faker.lorem.sentence(),
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
    'description': faker.lorem.sentence(),
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
