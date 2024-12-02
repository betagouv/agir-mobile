import 'dart:convert';

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/mieux_vous_connaitre_api_adapter.dart';
import 'package:app/features/mieux_vous_connaitre/core/infrastructure/question_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/authentication_service_setup.dart';
import '../../helpers/dio_mock.dart';
import '../../helpers/faker.dart';

void main() {
  late MieuxVousConnaitreApiAdapter adapter;
  late DioMock dioMock;

  setUp(() {
    dioMock = DioMock();
    adapter = MieuxVousConnaitreApiAdapter(
      client: DioHttpClient(
        dio: dioMock,
        authenticationService: authenticationService,
      ),
      messageBus: MessageBus(),
    );
  });

  group('MieuxVousConnaitreApiAdapter', () {
    test('recupererQuestion returns the correct question', () async {
      final expectedQuestion = generateChoixUniqueQuestion(true);
      final id = expectedQuestion['id'] as String;

      dioMock.getM(
        Endpoints.questionKyc(id),
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
      dioMock.putM(Endpoints.questionKyc(id));

      final question =
          QuestionMapper.fromJson(expectedQuestion)! as ChoixUniqueQuestion;
      await adapter.mettreAJour(question);

      verify(
        () => dioMock.put<dynamic>(
          Endpoints.questionKyc(id),
          data: jsonEncode({'reponse': question.responses.value}),
        ),
      );
    });
  });
}
