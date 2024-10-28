import 'package:equatable/equatable.dart';

class MissionListe extends Equatable {
  const MissionListe({
    required this.id,
    required this.titre,
    required this.progression,
    required this.progressionCible,
    required this.estNouvelle,
    required this.imageUrl,
    required this.niveau,
  });

  final String id;
  final String titre;
  final int progression;
  final int progressionCible;
  final bool estNouvelle;
  final String imageUrl;
  final int? niveau;

  @override
  List<Object?> get props =>
      [id, titre, progression, progressionCible, estNouvelle, imageUrl, niveau];
}
