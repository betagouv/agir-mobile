import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('Accordéons', () {
    testWidgets('Voir le label', (final tester) async {
      const header1 = 'Header 1';
      const body1 = 'Body 1';
      const header2 = 'Header 2';
      const body2 = 'Body 2';
      await tester.pumpWidget(
        const App(
          child: DsfrAccordionsGroup(
            values: [
              DsfrAccordion(header: Text(header1), body: Text(body1)),
              DsfrAccordion(header: Text(header2), body: Text(body2)),
            ],
          ),
        ),
      );
    });

    testWidgets('Appuyer', (final tester) async {
      const header1 = 'Header 1';
      const body1 = 'Body 1';
      await tester.pumpWidget(
        const App(
          child: DsfrAccordionsGroup(
            values: [
              DsfrAccordion(header: Text(header1), body: Text(body1)),
              DsfrAccordion(header: Text('Header 2'), body: Text('Body 2')),
            ],
          ),
        ),
      );
      await tester.tap(find.text(header1));
    });
  });
}
