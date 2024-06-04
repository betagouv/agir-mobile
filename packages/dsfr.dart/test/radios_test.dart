import 'dart:async';

import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'Radios',
    () {
      testWidgets('Voir le label', (final tester) async {
        const label = 'Label radio';
        await tester.pumpWidget(
          app(
            DsfrRadioButton(
              title: label,
              value: 0,
              groupValue: 1,
              onChanged: (final value) {},
            ),
          ),
        );
        expect(find.text(label), findsOneWidget);
      });

      testWidgets('Appuyer', (final tester) async {
        final completer = Completer<void>();
        await tester.pumpWidget(
          app(
            DsfrRadioButton(
              title: 'Label radio',
              value: 0,
              groupValue: 1,
              onChanged: (final value) {
                completer.complete();
              },
            ),
          ),
        );
        await tester.tap(find.text('Label radio'));

        expect(completer.isCompleted, true);
      });
    },
  );

  group(
    'Groupe Radios',
    () {
      testWidgets('Voir le label', (final tester) async {
        const title = 'Title';
        const label1 = 'Un';
        const label2 = 'Deux';
        const label3 = 'Trois';
        await tester.pumpWidget(
          App(
            child: DsfrRadioButtonSet(
              title: title,
              values: const {1: label1, 2: label2, 3: label3},
              onCallback: (final value) {},
            ),
          ),
        );

        expect(find.text(title), findsOneWidget);
        expect(find.text(label1), findsOneWidget);
        expect(find.text(label2), findsOneWidget);
        expect(find.text(label3), findsOneWidget);
      });

      testWidgets('Appuyer', (final tester) async {
        final completer = Completer<int>();
        const label2 = 'Label2';
        await tester.pumpWidget(
          App(
            child: DsfrRadioButtonSet(
              title: 'Title',
              values: const {1: 'Label1', 2: label2, 3: 'Label3'},
              onCallback: completer.complete,
            ),
          ),
        );
        await tester.tap(find.text(label2));

        expect(completer.isCompleted, true);
        expect(await completer.future, 2);
      });
    },
  );
}
