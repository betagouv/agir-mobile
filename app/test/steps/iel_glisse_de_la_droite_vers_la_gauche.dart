import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel glisse de la droite vers la gauche.
Future<void> ielGlisseDeLaDroiteVersLaGauche(final WidgetTester tester) async {
  await tester.dragFrom(
    tester.getCenter(find.byType(Scaffold)),
    Offset(-(tester.view.physicalSize.width / tester.view.devicePixelRatio), 0),
  );
  await tester.pumpAndSettle();
}
