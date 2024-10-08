import 'package:app/core/extensions/go_router.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/questions/presentation/widgets/question_progress_bar.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/mieux_vous_connaitre_controller.dart';
import 'package:app/features/mieux_vous_connaitre/detail/presentation/form/mieux_vous_connaitre_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceQuestionPage extends StatelessWidget {
  const EnvironmentalPerformanceQuestionPage({
    super.key,
    required this.questionIdList,
    required this.number,
  });

  static const name = 'bilan-question';
  static const path = '$name/:number';

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) {
          final extra = state.extra;
          if (extra is List<String>) {
            return EnvironmentalPerformanceQuestionPage(
              questionIdList: extra.map(QuestionId.new).toList(),
              number: int.parse(state.pathParameters['number'] ?? '1'),
            );
          }
          throw Exception('questionIdList is required');
        },
      );

  final List<QuestionId> questionIdList;
  final int number;

  @override
  Widget build(final BuildContext context) =>
      _View(questionIdList: questionIdList, number: number);
}

class _View extends StatefulWidget {
  const _View({required this.questionIdList, required this.number});

  final List<QuestionId> questionIdList;
  final int number;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _mieuxVousConnaitreController = MieuxVousConnaitreController();

  @override
  void dispose() {
    _mieuxVousConnaitreController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: const FnvAppBar(),
        body: Column(
          children: [
            QuestionsProgressBar(
              current: widget.number,
              total: widget.questionIdList.length,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(paddingVerticalPage),
                children: [
                  MieuxVousConnaitreForm(
                    id: widget.questionIdList[widget.number - 1].value,
                    controller: _mieuxVousConnaitreController,
                    onSaved: () async {
                      if (widget.number == widget.questionIdList.length) {
                        GoRouter.of(context).popUntilNamed(
                          EnvironmentalPerformanceSummaryPage.name,
                          result: true,
                        );

                        return;
                      }
                      await GoRouter.of(context).pushNamed(
                        EnvironmentalPerformanceQuestionPage.name,
                        pathParameters: {'number': '${widget.number + 1}'},
                        extra: widget.questionIdList
                            .map((final e) => e.value)
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: DsfrSpacings.s3w),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: DsfrButton(
                        label: Localisation.continuer,
                        variant: DsfrButtonVariant.primary,
                        size: DsfrButtonSize.lg,
                        onPressed: _mieuxVousConnaitreController.save,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: FnvColors.aidesFond,
      );
}
