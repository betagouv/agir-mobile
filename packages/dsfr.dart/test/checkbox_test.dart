import 'dart:async';

import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('Case à cocher', () {
    testWidgets('Voir le label', (final tester) async {
      const label = 'Label';
      await tester.pumpWidget(App(child: DsfrCheckbox.sm(label: label, value: false, onChanged: (final value) {})));
      expect(find.text(label), findsOneWidget);
    });

    testWidgets('Appuyer', (final tester) async {
      const label = 'Label';
      final completer = Completer<void>();
      await tester.pumpWidget(App(child: DsfrCheckbox.sm(label: label, value: false, onChanged: completer.complete)));

      await tester.tap(find.text(label));

      expect(completer.isCompleted, true);
    });
  });
}
