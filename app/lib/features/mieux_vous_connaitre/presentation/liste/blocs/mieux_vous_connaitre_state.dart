import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

enum MieuxVousConnaitreStatut { initial, chargement, succes }

final class MieuxVousConnaitreState extends Equatable {
  const MieuxVousConnaitreState({
    required this.questions,
    required this.questionsParCategorie,
    required this.thematiqueSelectionnee,
    required this.statut,
  });

  const MieuxVousConnaitreState.empty()
      : this(
          questions: const [],
          questionsParCategorie: const [],
          thematiqueSelectionnee: const None(),
          statut: MieuxVousConnaitreStatut.initial,
        );

  final List<Question> questions;
  final List<Question> questionsParCategorie;
  final Option<Thematique?> thematiqueSelectionnee;
  final MieuxVousConnaitreStatut statut;

  MieuxVousConnaitreState copyWith({
    final List<Question>? questions,
    final List<Question>? questionsParCategorie,
    final Option<Thematique?>? thematiqueSelectionnee,
    final MieuxVousConnaitreStatut? statut,
  }) =>
      MieuxVousConnaitreState(
        questions: questions ?? this.questions,
        questionsParCategorie:
            questionsParCategorie ?? this.questionsParCategorie,
        thematiqueSelectionnee:
            thematiqueSelectionnee ?? this.thematiqueSelectionnee,
        statut: statut ?? this.statut,
      );

  @override
  List<Object> get props =>
      [questions, questionsParCategorie, thematiqueSelectionnee, statut];
}
