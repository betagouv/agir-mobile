import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MieuxVousConnaitrePort {
  Future<Either<Exception, Question>> recupererQuestion({
    required final String id,
  });

  Future<Either<Exception, Unit>> mettreAJour(final Question question);
}
