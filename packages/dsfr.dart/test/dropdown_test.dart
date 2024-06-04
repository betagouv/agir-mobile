import 'dart:async';

import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group(
    'Liste déroulante',
    () {
      testWidgets('Voir le label', (final tester) async {
        const label = 'Label';
        await tester.pumpWidget(
          App(
            child: DsfrSelect(
              label: label,
              dropdownMenuEntries: const [],
              onSelected: (final value) {},
            ),
          ),
        );
        expect(find.text(label), findsOneWidget);
      });

      testWidgets('Voir la description', (final tester) async {
        const hint = 'Hint';
        await tester.pumpWidget(
          App(
            child: DsfrSelect(
              label: 'Label',
              hint: hint,
              dropdownMenuEntries: const [],
              onSelected: (final value) {},
            ),
          ),
        );
        expect(find.text(hint), findsOneWidget);
      });

      testWidgets('Je sélectionne la 2ème valeure', (final tester) async {
        final completer = Completer<int>();
        const deux = 'Deux';
        await tester.pumpWidget(
          App(
            child: DsfrSelect(
              label: 'Label',
              dropdownMenuEntries: const [
                DropdownMenuEntry(label: 'Un', value: 1),
                DropdownMenuEntry(label: deux, value: 2),
                DropdownMenuEntry(label: 'Trois', value: 3),
              ],
              onSelected: completer.complete,
            ),
          ),
        );

        await tester
            .tap(find.byIcon(DsfrIcons.systemArrowDownSLine).hitTestable());
        await tester.pump();

        await tester.tap(find.text(deux).hitTestable());
        await tester.pump();

        expect(completer.isCompleted, true);
        expect(await completer.future, 2);
      });
    },
  );
}
