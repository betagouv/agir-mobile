import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel voit l'icône.
void ielVoitLIcone(final IconData icon, {final int n = 1}) {
  expect(find.byIcon(icon), findsNWidgets(n));
}
