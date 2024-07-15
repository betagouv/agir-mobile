// ignore_for_file: avoid-collection-mutating-methods

import 'package:app/features/mieux_vous_connaitre/domain/ports/mieux_vous_connaitre_port.dart';
import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class MieuxVousConnaitrePortMock implements MieuxVousConnaitrePort {
  MieuxVousConnaitrePortMock({required this.questions});

  List<Question> questions;

  @override
  Future<Either<Exception, List<Question>>>
      recupererLesQuestionsDejaRepondue() async => Right(questions);

  @override
  Future<Either<Exception, void>> mettreAJour({
    required final String id,
    required final List<String> reponses,
  }) async {
    final question = questions.firstWhereOrNull((final e) => e.id == id);
    if (question != null) {
      questions
        ..removeWhere((final e) => e.id == id)
        ..add(question.copyWith(reponses: reponses));
    }

    return const Right(null);
  }

  @override
  Future<Either<Exception, Question>> recupererQuestion({
    required final String id,
  }) async {
    final question = questions.firstWhereOrNull((final e) => e.id == id);

    return question == null
        ? Left(Exception('Question not found'))
        : Right(question);
  }
}
