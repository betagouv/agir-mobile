import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class QuestionThemesEvent extends Equatable {
  const QuestionThemesEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class QuestionThemesRecuperationDemandee extends QuestionThemesEvent {
  const QuestionThemesRecuperationDemandee();
}

@immutable
final class QuestionThemesOntChange extends QuestionThemesEvent {
  const QuestionThemesOntChange(this.valeur);

  final List<String> valeur;

  @override
  List<Object> get props => [valeur];
}

@immutable
final class QuestionThemesMiseAJourDemandee extends QuestionThemesEvent {
  const QuestionThemesMiseAJourDemandee();
}
