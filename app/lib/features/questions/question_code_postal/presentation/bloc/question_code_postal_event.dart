import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionCodePostalEvent extends Equatable {
  const QuestionCodePostalEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionCodePostalPrenomDemande extends QuestionCodePostalEvent {
  const QuestionCodePostalPrenomDemande();
}

@immutable
final class QuestionCodePostalAChange extends QuestionCodePostalEvent {
  const QuestionCodePostalAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class QuestionCommuneAChange extends QuestionCodePostalEvent {
  const QuestionCommuneAChange(this.valeur);

  final String valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class QuestionCodePostalMiseAJourDemandee extends QuestionCodePostalEvent {
  const QuestionCodePostalMiseAJourDemandee();
}
