import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class MissionListe extends Equatable {
  const MissionListe({
    required this.code,
    required this.titre,
    required this.progression,
    required this.progressionCible,
    required this.estNouvelle,
    required this.imageUrl,
    required this.themeType,
  });

  final String code;
  final String titre;
  final int progression;
  final int progressionCible;
  final bool estNouvelle;
  final String imageUrl;
  final ThemeType themeType;

  @override
  List<Object?> get props => [
    code,
    titre,
    progression,
    progressionCible,
    estNouvelle,
    imageUrl,
    themeType,
  ];
}
