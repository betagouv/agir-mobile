import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel ne voit pas l'icône.
void ielNeVoitPasLIcone(final IconData icon) {
  expect(find.byIcon(icon), findsNothing);
}
