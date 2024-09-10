import 'package:app/features/gamification/domain/ports/gamification_port.dart';
import 'package:app/features/quiz/domain/ports/quiz_port.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_event.dart';
import 'package:app/features/quiz/presentation/blocs/quiz_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required final QuizPort quizPort,
    required final GamificationPort gamificationPort,
  }) : super(const QuizState.empty()) {
    on<QuizRecuperationDemandee>((final event, final emit) async {
      final result = await quizPort.recupererQuiz(event.id);
      if (result.isRight()) {
        final quiz = result.getRight().getOrElse(() => throw Exception());
        emit(state.copyWith(quiz: quiz));
      }
    });
    on<QuizReponseSelectionnee>(
      (final event, final emit) =>
          emit(state.copyWith(reponse: Some(event.valeur))),
    );
    on<QuizValidationDemandee>((final event, final emit) async {
      final estExacte = state.quiz.reponses.any(
        (final e) => e.reponse == state.reponse.getOrElse(() => '') && e.exact,
      );
      await quizPort.terminerQuiz(id: state.quiz.id, estExacte: estExacte);
      await gamificationPort.mettreAJourLesPoints();
      emit(state.copyWith(estExacte: Some(estExacte)));
    });
  }
}
