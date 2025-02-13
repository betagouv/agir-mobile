import 'package:equatable/equatable.dart';

final class Quiz extends Equatable {
  const Quiz({
    required this.id,
    required this.thematique,
    required this.question,
    required this.reponses,
    required this.points,
    required this.explicationOk,
    required this.explicationKo,
    required this.article,
  });

  final String id;
  final String thematique;
  final String question;
  final List<QuizReponse> reponses;
  final int points;
  final String? explicationOk;
  final String? explicationKo;
  final String? article;

  @override
  List<Object?> get props => [id, thematique, question, reponses, points, explicationOk, explicationKo, article];
}

final class QuizReponse extends Equatable {
  const QuizReponse({required this.reponse, required this.exact});

  final String reponse;
  final bool exact;

  @override
  List<Object> get props => [reponse, exact];
}
