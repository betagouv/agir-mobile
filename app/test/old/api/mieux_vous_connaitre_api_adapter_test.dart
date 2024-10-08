import 'dart:convert';

import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/infrastructure/authentication_repository.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/question_mapper.dart';
import 'package:clock/clock.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dio_mock.dart';
import 'flutter_secure_storage_fake.dart';

void main() {
  final generateThematique = faker.randomGenerator.element([
    'alimentation',
    'transport',
    'logement',
    'consommation',
    'climat',
    'dechet',
    'loisir',
  ]);

  Map<String, dynamic> generateChoixUniqueQuestion(final bool withResponse) => {
        'categorie': 'mission',
        'id': 'KYC_${faker.lorem.word()}',
        'is_NGC': faker.randomGenerator.boolean(),
        'points': faker.randomGenerator.integer(10),
        'question': faker.lorem.sentence(),
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
  //       'question': faker.lorem.sentence(),
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
  //       'question': faker.lorem.sentence(),
  //       'reponse': [faker.lorem.sentence()],
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
  //       'titre': faker.lorem.sentence(),
  //       'type': 'mosaic_boolean',
  //     };

  late MieuxVousConnaitreApiAdapter adapter;
  late DioMock dioMock;

  setUp(() {
    dioMock = DioMock();
    adapter = MieuxVousConnaitreApiAdapter(
      client: DioHttpClient(
        dio: dioMock,
        authentificationService: AuthenticationService(
          authenticationRepository:
              AuthenticationRepository(FlutterSecureStorageFake()),
          clock: Clock.fixed(DateTime(1992)),
        ),
      ),
    );
  });

  group('MieuxVousConnaitreApiAdapter', () {
    test('recupererQuestion returns the correct question', () async {
      final expectedQuestion = generateChoixUniqueQuestion(true);
      final id = expectedQuestion['id'] as String;

      dioMock.getM(
        '/utilisateurs/{userId}/questionsKYC/$id',
        responseData: expectedQuestion,
      );

      final result = await adapter.recupererQuestion(id: id);

      expect(result.isRight(), isTrue);
      final question = result.getRight().getOrElse(() => throw Exception());
      expect(question, equals(QuestionMapper.fromJson(expectedQuestion)));
    });

    test('mettreAJour sends correct data', () async {
      final expectedQuestion = generateChoixUniqueQuestion(true);
      final id = expectedQuestion['id'] as String;
      dioMock.putM('/utilisateurs/{userId}/questionsKYC/$id');

      final question =
          QuestionMapper.fromJson(expectedQuestion)! as ChoixUniqueQuestion;
      await adapter.mettreAJour(question);

      verify(
        () => dioMock.put<dynamic>(
          '/utilisateurs/{userId}/questionsKYC/$id',
          data: jsonEncode({'reponse': question.responses.value}),
        ),
      );
    });
  });
}
