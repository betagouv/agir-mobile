import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MieuxVousConnaitrePort {
  Future<Either<Exception, Question>> recupererQuestion({
    required final String id,
  });

  Future<Either<Exception, Unit>> mettreAJour(final Question question);
}
