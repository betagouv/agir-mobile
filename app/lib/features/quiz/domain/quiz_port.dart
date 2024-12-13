import 'package:app/features/quiz/domain/quiz.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class QuizPort {
  Future<Either<Exception, Quiz>> recupererQuiz(final String id);

  Future<Either<Exception, void>> terminerQuiz({
    required final String id,
    required final bool estExacte,
  });
}
