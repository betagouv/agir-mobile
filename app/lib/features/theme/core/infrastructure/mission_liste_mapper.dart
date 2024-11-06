import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class MissionListeMapper {
  const MissionListeMapper._();

  static MissionListe fromJson(final Map<String, dynamic> json) => MissionListe(
        id: json['type'] as String,
        titre: json['titre'] as String,
        progression: (json['progression'] as num).toInt(),
        progressionCible: (json['cible_progression'] as num).toInt(),
        estNouvelle: json['is_new'] as bool,
        imageUrl: json['image_url'] as String,
        niveau: (json['niveau'] as num?)?.toInt(),
        themeType: _mapThemeType(json['univers_parent'] as String),
      );

  static ThemeType _mapThemeType(final String type) => switch (type) {
        'alimentation' => ThemeType.alimentation,
        'transport' => ThemeType.transport,
        'consommation' => ThemeType.consommation,
        'logement' => ThemeType.logement,
        _ => ThemeType.decouverte,
      };
}
