import 'package:app/features/environmental_performance/environmental_performance_l10n.dart';
import 'package:app/features/environmental_performance/presentation/page/environmental_performance_page.dart';
import 'package:app/features/gamification/presentation/bloc/gamification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_page.dart';
import '../old/mocks/gamification_bloc_fake.dart';

Future<void> pumpEnvironmentalPerformancePage(final WidgetTester tester) async {
  await pumpPage(
    tester: tester,
    repositoryProviders: [],
    blocProviders: [
      BlocProvider<GamificationBloc>(
        create: (final context) => const GamificationBlocFake(),
      ),
    ],
    page: const EnvironmentalPerformancePage(),
  );
}

void main() {
  group('Votre bilan environnemental', () {
    for (final testCase in [
      (
        header: EnvironmentalPerformanceLocalisation.quEstCeQuUn,
        expected:
            'Que l’on se rende dans un magasin de quartier pour faire ses courses',
      ),
      (
        header: EnvironmentalPerformanceLocalisation.commentEstCalcule,
        expected: 'Votre bilan environnemental est calculé à partir',
      ),
    ]) {
      testWidgets(
        'Voir le contenu de ${testCase.header}',
        (final tester) async {
          await pumpEnvironmentalPerformancePage(tester);
          await tester.tap(find.text(testCase.header));
          await tester.pumpAndSettle();
          expect(find.textContaining(testCase.expected), findsOneWidget);
        },
      );
    }
  });

  testWidgets(
    'Voir le contenu de "Activer le mode développeur"',
    (final tester) async {
      await pumpEnvironmentalPerformancePage(tester);
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    },
    skip: true, // https://github.com/flutter/flutter/issues/156496
  );
}
