import 'package:equatable/equatable.dart';

class Aide extends Equatable {
  const Aide({
    required this.titre,
    required this.thematique,
  });

  final String titre;
  final String thematique;

  @override
  List<Object?> get props => [titre, thematique];
}
