import 'package:equatable/equatable.dart';

enum QuestionType { choixUnique, choixMultiple, libre }

enum Thematique {
  alimentation,
  transport,
  logement,
  consommation,
  climat,
  dechet,
  loisir
}

class Question extends Equatable {
  const Question({
    required this.id,
    required this.question,
    required this.reponse,
    required this.categorie,
    required this.points,
    required this.type,
    required this.reponsesPossibles,
    required this.deNosGestesClimat,
    required this.thematique,
  });

  final String id;
  final String question;
  final List<String> reponse;
  final String categorie;
  final int points;
  final QuestionType type;
  final List<String> reponsesPossibles;
  final bool deNosGestesClimat;
  final Thematique thematique;

  @override
  List<Object?> get props => [
        id,
        question,
        reponse,
        categorie,
        points,
        type,
        reponsesPossibles,
        deNosGestesClimat,
        thematique,
      ];
}
