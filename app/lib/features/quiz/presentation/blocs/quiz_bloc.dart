import 'dart:async';

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
  })  : _quizPort = quizPort,
        _gamificationPort = gamificationPort,
        super(const QuizState.empty()) {
    on<QuizRecuperationDemandee>(_onRecuperationDemandee);
    on<QuizReponseSelectionnee>(_onReponseSelectionnee);
    on<QuizValidationDemandee>(_onValidationDemandee);
  }

  final QuizPort _quizPort;
  final GamificationPort _gamificationPort;

  Future<void> _onRecuperationDemandee(
    final QuizRecuperationDemandee event,
    final Emitter<QuizState> emit,
  ) async {
    final result = await _quizPort.recupererQuiz(event.id);
    if (result.isRight()) {
      final quiz = result.getRight().getOrElse(() => throw Exception());
      emit(state.copyWith(quiz: quiz));
    }
  }

  void _onReponseSelectionnee(
    final QuizReponseSelectionnee event,
    final Emitter<QuizState> emit,
  ) =>
      emit(state.copyWith(reponse: Some(event.valeur)));

  Future<void> _onValidationDemandee(
    final QuizValidationDemandee event,
    final Emitter<QuizState> emit,
  ) async {
    final estExacte = state.quiz.reponses.any(
      (final e) => e.reponse == state.reponse.getOrElse(() => '') && e.exact,
    );
    await _quizPort.terminerQuiz(id: state.quiz.id, estExacte: estExacte);
    await _gamificationPort.mettreAJourLesPoints();
    emit(state.copyWith(estExacte: Some(estExacte)));
  }
}
