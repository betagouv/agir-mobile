import 'package:app/features/actions/domain/action_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

abstract final class ActionSummaryMapper {
  const ActionSummaryMapper._();

  static ActionSummary fromJson(final Map<String, dynamic> json) =>
      ActionSummary(
        themeType: _mapThemeType(json['thematique'] as String?),
        type: _mapActionType(json['type'] as String),
        id: json['code'] as String,
        title: json['titre'] as String,
        subTitle: json['sous_titre'] as String,
        numberOfActionsCompleted: json['nombre_actions_en_cours'] as int,
        numberOfAidsAvailable: json['nombre_aides_disponibles'] as int,
      );

  static ActionType _mapActionType(final String? type) => switch (type) {
        'classique' || _ => ActionType.classique,
      };

  static ThemeType _mapThemeType(final String? type) => switch (type) {
        'alimentation' => ThemeType.alimentation,
        'transport' => ThemeType.transport,
        'consommation' => ThemeType.consommation,
        'logement' => ThemeType.logement,
        _ => ThemeType.decouverte,
      };
}
