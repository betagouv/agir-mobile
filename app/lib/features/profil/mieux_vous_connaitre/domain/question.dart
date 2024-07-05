import 'package:equatable/equatable.dart';

enum ReponseType { choixUnique, choixMultiple, libre }

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
    required this.reponses,
    required this.categorie,
    required this.points,
    required this.type,
    required this.reponsesPossibles,
    required this.deNosGestesClimat,
    required this.thematique,
  });

  final String id;
  final String question;
  final List<String> reponses;
  final String categorie;
  final int points;
  final ReponseType type;
  final List<String> reponsesPossibles;
  final bool deNosGestesClimat;
  final Thematique thematique;

  Question copyWith({
    final String? id,
    final String? question,
    final List<String>? reponses,
    final String? categorie,
    final int? points,
    final ReponseType? type,
    final List<String>? reponsesPossibles,
    final bool? deNosGestesClimat,
    final Thematique? thematique,
  }) =>
      Question(
        id: id ?? this.id,
        question: question ?? this.question,
        reponses: reponses ?? this.reponses,
        categorie: categorie ?? this.categorie,
        points: points ?? this.points,
        type: type ?? this.type,
        reponsesPossibles: reponsesPossibles ?? this.reponsesPossibles,
        deNosGestesClimat: deNosGestesClimat ?? this.deNosGestesClimat,
        thematique: thematique ?? this.thematique,
      );

  @override
  List<Object?> get props => [
        id,
        question,
        reponses,
        categorie,
        points,
        type,
        reponsesPossibles,
        deNosGestesClimat,
        thematique,
      ];
}
