import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'Accordéons',
    () {
      testWidgets('Voir le label', (final tester) async {
        const header1 = 'Header 1';
        const body1 = 'Body 1';
        const header2 = 'Header 2';
        const body2 = 'Body 2';
        await tester.pumpWidget(
          app(
            DsfrAccordionsGroup(
              values: [
                DsfrAccordion(
                  header: const Text(header1),
                  body: const Text(body1),
                ),
                DsfrAccordion(
                  header: const Text(header2),
                  body: const Text(body2),
                ),
              ],
            ),
          ),
        );
      });

      testWidgets('Appuyer', (final tester) async {
        const header1 = 'Header 1';
        const body1 = 'Body 1';
        await tester.pumpWidget(
          app(
            DsfrAccordionsGroup(
              values: [
                DsfrAccordion(
                  header: const Text(header1),
                  body: const Text(body1),
                ),
                DsfrAccordion(
                  header: const Text('Header 2'),
                  body: const Text('Body 2'),
                ),
              ],
            ),
          ),
        );
        await tester.tap(find.text(header1));
      });
    },
  );
}
