import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:equatable/equatable.dart';

final class QuestionThemesState extends Equatable {
  const QuestionThemesState({this.question, required this.valeur});

  final ChoixMultipleQuestion? question;
  final List<String> valeur;

  QuestionThemesState copyWith({
    final ChoixMultipleQuestion? question,
    final List<String>? valeur,
  }) =>
      QuestionThemesState(
        question: question ?? this.question,
        valeur: valeur ?? this.valeur,
      );

  @override
  List<Object?> get props => [question, valeur];
}
