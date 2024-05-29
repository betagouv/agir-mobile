import 'package:flutter_test/flutter_test.dart';

import '../scenario_context.dart';

/// Iel s'appelle
Future<void> ielSappelle(final WidgetTester tester, final String prenom) async {
  ScenarioContext().prenom = prenom;
}
