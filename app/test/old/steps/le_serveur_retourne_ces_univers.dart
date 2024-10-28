import 'package:app/features/theme/core/domain/theme_tile.dart';

import '../scenario_context.dart';

/// Le serveur retourne ces thematiques.
void leServeurRetourneCesThematiques(final List<ThemeTile> items) {
  ScenarioContext().themeTile = items;
}
