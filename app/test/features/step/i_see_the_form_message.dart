import 'package:dsfr/dsfr.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see the {'12 caractères minimum'} form message {'valid'}
Future<void> iSeeTheFormMessage(
  final WidgetTester tester,
  final String text,
  final String typeString,
) async {
  final type = typeString == 'valid'
      ? DsfrFormMessageType.valid
      : typeString == 'info'
          ? DsfrFormMessageType.info
          : UnimplementedError();
  expect(
    find.byWidgetPredicate(
      (final widget) =>
          widget is DsfrFormMessage &&
          widget.type == type &&
          widget.text == text,
    ),
    findsOneWidget,
  );
}
