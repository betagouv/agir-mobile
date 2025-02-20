enum ActionType { classic, quiz, performance, simulator }

ActionType actionTypeFromAPIString(final String value) => switch (value) {
  'classique' => ActionType.classic,
  'quizz' => ActionType.quiz,
  'bilan' => ActionType.performance,
  'simulateur' => ActionType.simulator,
  _ => throw UnimplementedError('Unknown action type: $value'),
};

String actionTypeToAPIString(final ActionType value) => switch (value) {
  ActionType.classic => 'classique',
  ActionType.quiz => 'quizz',
  ActionType.performance => 'bilan',
  ActionType.simulator => 'simulateur',
};
