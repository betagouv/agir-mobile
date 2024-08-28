import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:equatable/equatable.dart';

final class QuestionThemesState extends Equatable {
  const QuestionThemesState({required this.question, required this.valeur});

  final Question question;
  final List<String> valeur;

  QuestionThemesState copyWith({
    final Question? question,
    final List<String>? valeur,
  }) =>
      QuestionThemesState(
        question: question ?? this.question,
        valeur: valeur ?? this.valeur,
      );

  @override
  List<Object> get props => [question, valeur];
}
