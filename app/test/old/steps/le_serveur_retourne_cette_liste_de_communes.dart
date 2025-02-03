import 'package:app/core/infrastructure/endpoints.dart';

import 'scenario_context.dart';

/// Le serveur retourne cette liste de communes.
void leServeurRetourneCetteListeDeCommunes(final List<String> communes) {
  ScenarioContext().dioMock!.getM(
        Endpoints.communes('39100'),
        responseData: communes,
      );
}
