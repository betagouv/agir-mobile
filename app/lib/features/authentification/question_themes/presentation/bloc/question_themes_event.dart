import 'package:equatable/equatable.dart';

sealed class QuestionThemesEvent extends Equatable {
  const QuestionThemesEvent();

  @override
  List<Object> get props => [];
}

final class QuestionThemesRecuperationDemandee extends QuestionThemesEvent {
  const QuestionThemesRecuperationDemandee();
}

final class QuestionThemesOntChange extends QuestionThemesEvent {
  const QuestionThemesOntChange(this.valeur);

  final List<String> valeur;

  @override
  List<Object> get props => [valeur];
}

final class QuestionThemesMiseAJourDemandee extends QuestionThemesEvent {
  const QuestionThemesMiseAJourDemandee();
}
