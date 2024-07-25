import 'package:equatable/equatable.dart';

sealed class QuestionPrenomEvent extends Equatable {
  const QuestionPrenomEvent();

  @override
  List<Object> get props => [];
}

class QuestionPrenomAChange extends QuestionPrenomEvent {
  const QuestionPrenomAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class QuestionPrenomMiseAJourDemandee extends QuestionPrenomEvent {
  const QuestionPrenomMiseAJourDemandee();
}
