import 'package:app/features/quiz/domain/quiz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
final class QuizState extends Equatable {
  const QuizState({
    required this.quiz,
    required this.reponse,
    required this.estExacte,
  });

  const QuizState.empty()
      : this(
          quiz: const Quiz(
            id: '',
            thematique: '',
            question: '',
            reponses: [],
            points: 0,
            explicationOk: '',
            explicationKo: '',
            article: null,
          ),
          reponse: const None(),
          estExacte: const None(),
        );

  final Quiz quiz;
  final Option<String> reponse;
  bool get estSelectionnee => reponse.isSome();
  final Option<bool> estExacte;

  String get explication => estExacte.fold(
        () => '',
        (final estExacte) =>
            (estExacte ? quiz.explicationOk : quiz.explicationKo) ??
            quiz.article ??
            '',
      );

  QuizState copyWith({
    final Quiz? quiz,
    final Option<String>? reponse,
    final Option<bool>? estExacte,
  }) =>
      QuizState(
        quiz: quiz ?? this.quiz,
        reponse: reponse ?? this.reponse,
        estExacte: estExacte ?? this.estExacte,
      );

  @override
  List<Object?> get props => [quiz, reponse, estExacte];
}
