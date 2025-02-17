import 'package:app/features/actions/domain/action_summary.dart';

abstract final class ActionSummaryMapper {
  const ActionSummaryMapper._();

  static ActionSummary fromJson(final Map<String, dynamic> json) => ActionSummary(
    type: _actionTypeFromJson(json['type'] as String),
    id: json['code'] as String,
    title: json['titre'] as String,
    numberOfActionsCompleted: json['nombre_actions_en_cours'] as int,
    numberOfAidsAvailable: json['nombre_aides_disponibles'] as int,
  );

  static ActionType _actionTypeFromJson(final String value) => switch (value) {
    'classique' => ActionType.classic,
    'quizz' => ActionType.quiz,
    'bilan' => ActionType.performance,
    'simulateur' => ActionType.simulator,
    _ => throw UnimplementedError('Unknown action type: $value'),
  };
}
