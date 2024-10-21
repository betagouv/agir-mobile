// ignore_for_file: avoid-collection-mutating-methods

import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitrePortMock
    implements MieuxVousConnaitrePort, KnowYourCustomersRepository {
  MieuxVousConnaitrePortMock({required this.questions});

  List<Question> questions;

  @override
  Future<Either<Exception, Unit>> mettreAJour(final Question question) async {
    questions
      ..removeWhere((final e) => e.id.value == question.id.value)
      ..add(question);

    return const Right(unit);
  }

  @override
  Future<Either<Exception, Question>> recupererQuestion({
    required final String id,
  }) async {
    final question = questions.firstWhereOrNull((final e) => e.id.value == id);

    return question == null
        ? Left(Exception('Question not found'))
        : Right(question);
  }

  @override
  Future<Either<Exception, List<Question>>> fetchQuestions() async =>
      Right(List.of(questions));
}
