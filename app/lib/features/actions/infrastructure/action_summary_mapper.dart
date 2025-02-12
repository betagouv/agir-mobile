import 'package:app/features/actions/domain/action_summary.dart';

abstract final class ActionSummaryMapper {
  const ActionSummaryMapper._();

  static ActionSummary fromJson(final Map<String, dynamic> json) =>
      ActionSummary(
        id: json['code'] as String,
        title: json['titre'] as String,
        numberOfActionsCompleted: json['nombre_actions_en_cours'] as int,
        numberOfAidsAvailable: json['nombre_aides_disponibles'] as int,
      );
}
