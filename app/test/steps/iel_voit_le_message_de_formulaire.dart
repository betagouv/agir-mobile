import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

void ielVoitLeMessageDeFormulaire({
  required final String label,
  required final DsfrFormMessageType type,
}) {
  expect(
    find.byWidgetPredicate(
      (final widget) =>
          widget is DsfrFormMessage &&
          widget.type == type &&
          widget.text == label,
    ),
    findsOneWidget,
  );
}
