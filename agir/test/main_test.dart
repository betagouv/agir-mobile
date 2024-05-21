import 'package:agir/main.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets('show Hello World', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    expect(find.text("Hello World!"), findsOneWidget);
  });
}
