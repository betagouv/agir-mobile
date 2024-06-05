import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';

/// Iel voit le texte Markdown.
void ielVoitLeTexteMarkdown(final WidgetTester tester, final String texte) {
  final markdownBody =
      tester.widget<MarkdownBody>(find.byType(MarkdownBody).first);
  expect(markdownBody.data, texte);
}
