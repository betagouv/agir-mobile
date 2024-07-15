import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:equatable/equatable.dart';

final class MieuxVousConnaitreEditState extends Equatable {
  const MieuxVousConnaitreEditState({
    required this.question,
    required this.valeur,
    required this.estMiseAJour,
  });

  const MieuxVousConnaitreEditState.empty()
      : this(
          question: const Question.empty(),
          valeur: const [],
          estMiseAJour: false,
        );

  final Question question;
  final List<String> valeur;
  final bool estMiseAJour;

  MieuxVousConnaitreEditState copyWith({
    final Question? question,
    final List<String>? valeur,
    final bool? estMiseAJour,
  }) =>
      MieuxVousConnaitreEditState(
        question: question ?? this.question,
        valeur: valeur ?? this.valeur,
        estMiseAJour: estMiseAJour ?? this.estMiseAJour,
      );

  @override
  List<Object?> get props => [question, valeur, estMiseAJour];
}
