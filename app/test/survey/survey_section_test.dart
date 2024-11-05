import 'package:app/features/survey/survey_l10n.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SurveySection displays title', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: SurveySection()));

    expect(find.text(SurveySectionL10n.title), findsOneWidget);
  });

  testWidgets('SurveySection displays button', (final tester) async {
    await tester.pumpWidget(const MaterialApp(home: SurveySection()));

    expect(find.text(SurveySectionL10n.button), findsOneWidget);
    expect(find.byIcon(DsfrIcons.documentSurveyLine), findsOneWidget);
  });
}
