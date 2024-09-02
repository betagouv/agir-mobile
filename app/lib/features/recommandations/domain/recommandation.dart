import 'package:equatable/equatable.dart';

class Recommandation extends Equatable {
  const Recommandation({
    required this.id,
    required this.type,
    required this.titre,
    required this.sousTitre,
    required this.imageUrl,
    required this.points,
    required this.thematique,
    required this.thematiqueLabel,
  });

  final String id;
  final TypeDuContenu type;
  final String titre;
  final String? sousTitre;
  final String imageUrl;
  final int points;
  final String thematique;
  final String thematiqueLabel;

  @override
  List<Object?> get props => [
        id,
        type,
        titre,
        sousTitre,
        imageUrl,
        points,
        thematique,
        thematiqueLabel,
      ];
}

enum TypeDuContenu {
  article,
  kyc,
  quiz,
}
