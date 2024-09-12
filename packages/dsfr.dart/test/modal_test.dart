import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  group('Modal', () {
    testWidgets('Voir le bouton fermer', (final tester) async {
      const buttonLabel = 'Button';
      await tester
          .pumpWidget(const App(child: _Modal(buttonLabel: buttonLabel)));
      final closeText = find.text('Fermer');
      expect(closeText, findsNothing);
      await tester.tap(find.text(buttonLabel));
      await tester.pumpAndSettle();
      expect(closeText, findsOneWidget);
      await tester.tap(closeText);
      await tester.pumpAndSettle();
      expect(closeText, findsNothing);
    });
  });
}

class _Modal extends StatelessWidget {
  const _Modal({required this.buttonLabel});

  final String buttonLabel;

  @override
  Widget build(final BuildContext context) => DsfrButton(
        label: buttonLabel,
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onPressed: () async => DsfrModal.showModal(
          context: context,
          builder: (final context) => const SizedBox(),
          name: 'name',
        ),
      );
}
