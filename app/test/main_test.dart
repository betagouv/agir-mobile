import 'package:agir/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('show Hello World', (final tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
