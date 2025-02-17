import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class QuestionThemesState extends Equatable {
  const QuestionThemesState({this.question, required this.valeur});

  final QuestionMultipleChoice? question;
  final List<String> valeur;

  QuestionThemesState copyWith({final QuestionMultipleChoice? question, final List<String>? valeur}) =>
      QuestionThemesState(question: question ?? this.question, valeur: valeur ?? this.valeur);

  @override
  List<Object?> get props => [question, valeur];
}
