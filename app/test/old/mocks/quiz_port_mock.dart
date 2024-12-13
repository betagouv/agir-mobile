import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/quiz/domain/quiz_port.dart';
import 'package:fpdart/src/either.dart';

class QuizPortMock implements QuizPort {
  QuizPortMock(this.quiz);

  Quiz quiz;
  bool isTerminerQuizCalled = false;
  bool? isExact;

  @override
  Future<Either<Exception, Quiz>> recupererQuiz(final String id) async =>
      Right(quiz);

  @override
  Future<Either<Exception, void>> terminerQuiz({
    required final String id,
    required final bool estExacte,
  }) async {
    isExact = estExacte;
    isTerminerQuizCalled = true;

    return const Right(null);
  }
}
