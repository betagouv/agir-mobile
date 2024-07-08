import 'dart:async';

import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('Bouton', () {
    testWidgets('Voir le label', (final tester) async {
      const label = 'Label bouton';
      await tester.pumpWidget(
        const App(
          child: DsfrButton(
            label: label,
            variant: DsfrButtonVariant.primary,
            size: DsfrButtonSize.lg,
          ),
        ),
      );
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('Appuyer', (final tester) async {
      const label = 'Label bouton';
      final completer = Completer<void>();
      await tester.pumpWidget(
        App(
          child: DsfrButton(
            label: label,
            variant: DsfrButtonVariant.primary,
            size: DsfrButtonSize.lg,
            onPressed: completer.complete,
          ),
        ),
      );

      await tester.tap(find.text(label));

      expect(completer.isCompleted, true);
    });
    group('Accessibilité', () {
      testWidgets('État désactivé', (final tester) async {
        final handle = tester.ensureSemantics();
        const label = 'Label bouton';
        await tester.pumpWidget(
          const App(
            child: DsfrButton(
              label: label,
              variant: DsfrButtonVariant.primary,
              size: DsfrButtonSize.lg,
            ),
          ),
        );

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
        await tester.pumpWidget(
          App(
            child: DsfrButton(
              label: label,
              variant: DsfrButtonVariant.primary,
              size: DsfrButtonSize.lg,
              onPressed: () {},
            ),
          ),
        );
        expect(
          tester.getSemantics(find.text(label)),
          matchesSemantics(
            label: label,
            isButton: true,
            isFocusable: true,
            hasEnabledState: true,
            isEnabled: true,
            hasTapAction: true,
          ),
        );
        handle.dispose();
      });
    });
  });
}
