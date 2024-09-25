import 'package:equatable/equatable.dart';

sealed class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

final class QuizRecuperationDemandee extends QuizEvent {
  const QuizRecuperationDemandee(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class QuizReponseSelectionnee extends QuizEvent {
  const QuizReponseSelectionnee(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class QuizValidationDemandee extends QuizEvent {
  const QuizValidationDemandee();
}
