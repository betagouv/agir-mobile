import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('Champ de saisie', () {
    testWidgets('Voir le label', (final tester) async {
      const label = 'Label';
      await tester.pumpWidget(
        App(child: DsfrInput(label: label, onChanged: (final value) {})),
      );
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('Voir la description', (final tester) async {
      const hintText = 'Indice';
      await tester.pumpWidget(
        App(
          child: DsfrInput(
            label: 'Label',
            hintText: hintText,
            onChanged: (final value) {},
          ),
        ),
      );
      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('Voir la valeur par défaut', (final tester) async {
      const initialValue = 'Valeur';
      final controller = TextEditingController(text: initialValue);
      await tester.pumpWidget(
        App(
          child: DsfrInput(
            label: 'Label',
            hintText: 'Indice',
            controller: controller,
            onChanged: (final value) {},
          ),
        ),
      );
      expect(find.text(initialValue), findsOneWidget);
    });

    testWidgets('Je saisie', (final tester) async {
      const label = 'Label';
      const text = 'a';
      await tester.pumpWidget(
        App(child: DsfrInput(label: label, onChanged: (final value) {})),
      );

      await tester.enterText(find.byType(DsfrInput), text);

      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pump();

      expect(find.text(text), findsOneWidget);
    });
  });
}
