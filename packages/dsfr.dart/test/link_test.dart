import 'dart:async';

import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'Lien',
    () {
      testWidgets('Voir le label', (final tester) async {
        const label = 'Label lien';
        await tester.pumpWidget(app(const DsfrLink.md(label: label)));
        expect(find.text(label), findsOneWidget);
      });

      testWidgets('Appuyer', (final tester) async {
        const label = 'Label lien';
        final completer = Completer<void>();
        await tester.pumpWidget(
          app(DsfrLink.md(label: label, onTap: completer.complete)),
        );

        await tester.tap(find.text(label));

        expect(completer.isCompleted, true);
      });
      group(
        'Accessibilité',
        () {
          testWidgets('État désactivé', (final tester) async {
            final handle = tester.ensureSemantics();
            const label = 'Label lien';
            await tester.pumpWidget(app(const DsfrLink.md(label: label)));

            expect(
              tester.getSemantics(find.text(label)),
              matchesSemantics(
                label: label,
                isLink: true,
                hasEnabledState: true,
              ),
            );
            handle.dispose();
          });

          testWidgets('État activé', (final tester) async {
            final handle = tester.ensureSemantics();
            const label = 'Label lien';
            await tester
                .pumpWidget(app(DsfrLink.md(label: label, onTap: () {})));
            expect(
              tester.getSemantics(find.text(label)),
              matchesSemantics(
                label: label,
                isLink: true,
                hasTapAction: true,
                isFocusable: true,
                hasEnabledState: true,
                isEnabled: true,
              ),
            );
            handle.dispose();
          });
        },
      );
    },
  );
}
