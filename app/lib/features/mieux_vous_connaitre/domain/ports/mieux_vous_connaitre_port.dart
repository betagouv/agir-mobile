import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class MieuxVousConnaitrePort {
  Future<Either<Exception, List<Question>>> recupererLesQuestionsDejaRepondue();

  Future<Either<Exception, Question>> recupererQuestion({
    required final String id,
  });

  Future<Either<Exception, void>> mettreAJour({
    required final String id,
    required final List<String> reponses,
  });
}
