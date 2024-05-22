import 'dart:async';

import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'Bouton',
    () {
      testWidgets('Voir le label', (final tester) async {
        const label = 'Label bouton';
        await tester.pumpWidget(app(const DsfrButton.lg(label: label)));
        final finder = find.text(label);
        _expectColorByText(tester, finder, DsfrColors.grey925);
        expect(find.text(label), findsOneWidget);
      });

      testWidgets('Appuyer', (final tester) async {
        const label = 'Label bouton';
        final completer = Completer<void>();
        await tester.pumpWidget(
          app(DsfrButton.lg(label: label, onTap: completer.complete)),
        );

        final finder = find.text(label);

        _expectColorByText(tester, finder, DsfrColors.blueFranceSun113);

        await tester.tap(finder);

        expect(completer.isCompleted, true);
      });
      group(
        'Accessibilité',
        () {
          testWidgets('État désactivé', (final tester) async {
            final handle = tester.ensureSemantics();
            const label = 'Label bouton';
            await tester.pumpWidget(app(const DsfrButton.lg(label: label)));

            expect(
              tester.getSemantics(find.text(label)),
              matchesSemantics(
                label: label,
                isButton: true,
                hasEnabledState: true,
              ),
            );
            handle.dispose();
          });

          testWidgets('État activé', (final tester) async {
            final handle = tester.ensureSemantics();
            const label = 'Label bouton';
            await tester
                .pumpWidget(app(DsfrButton.lg(label: label, onTap: () {})));
            expect(
              tester.getSemantics(find.text(label)),
              matchesSemantics(
                label: label,
                isButton: true,
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

void _expectColorByText(
  final WidgetTester tester,
  final FinderBase<Element> of,
  final Color color,
) =>
    expect(
      tester
          .firstWidget<ColoredBox>(
            find.ancestor(
              of: of,
              matching: find.byType(ColoredBox),
            ),
          )
          .color,
      color,
    );
