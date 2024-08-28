import 'package:equatable/equatable.dart';

sealed class QuestionCodePostalEvent extends Equatable {
  const QuestionCodePostalEvent();

  @override
  List<Object> get props => [];
}

class QuestionCodePostalPrenomDemande extends QuestionCodePostalEvent {
  const QuestionCodePostalPrenomDemande();
}

final class QuestionCodePostalAChange extends QuestionCodePostalEvent {
  const QuestionCodePostalAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class QuestionCommuneAChange extends QuestionCodePostalEvent {
  const QuestionCommuneAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

final class QuestionCodePostalMiseAJourDemandee
    extends QuestionCodePostalEvent {
  const QuestionCodePostalMiseAJourDemandee();
}
