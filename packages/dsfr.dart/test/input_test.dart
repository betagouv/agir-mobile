import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'Champ de saisie',
    () {
      testWidgets('Voir le label', (final tester) async {
        const label = 'Label';
        await tester.pumpWidget(
          app(
            DsfrInput(
              label: label,
              onChanged: (final value) {},
            ),
          ),
        );
        expect(find.text(label), findsOneWidget);
      });

      testWidgets('Je saisie', (final tester) async {
        const label = 'Label';
        const text = 'a';
        await tester.pumpWidget(
          app(
            DsfrInput(
              label: label,
              onChanged: (final value) {},
            ),
          ),
        );
        await tester.enterText(find.byType(DsfrInput), text);

        await tester.testTextInput.receiveAction(TextInputAction.done);

        await tester.pump();

        expect(find.text(text), findsOneWidget);
      });
    },
  );
}
