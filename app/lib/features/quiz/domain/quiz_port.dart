import 'package:app/features/quiz/domain/quiz.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class QuizPort {
  Future<Either<Exception, Quiz>> recupererQuiz(final String id);

  Future<Either<Exception, void>> terminerQuiz({
    required final int id,
    required final bool estExacte,
  });
}
