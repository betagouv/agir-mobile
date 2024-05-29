import 'package:flutter_test/flutter_test.dart';

/// Iel voit le texte dans texte riche
Future<void> ielVoitLeTexteDansTexteRiche(
  final WidgetTester tester,
  final String texte,
) async {
  expect(find.textContaining(texte, findRichText: true), findsOneWidget);
}
