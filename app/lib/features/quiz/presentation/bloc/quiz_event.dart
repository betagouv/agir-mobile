import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuizRecuperationDemandee extends QuizEvent {
  const QuizRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

@immutable
final class QuizReponseSelectionnee extends QuizEvent {
  const QuizReponseSelectionnee(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class QuizValidationDemandee extends QuizEvent {
  const QuizValidationDemandee();
}
