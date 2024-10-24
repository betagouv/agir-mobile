import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_event.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/empty/estimaded_timed_widget.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partner_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/question_section.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BodyEmpty extends StatelessWidget {
  const BodyEmpty({super.key, required this.data});

  final EnvironmentalPerformanceEmpty data;

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: FnvTitleWidget(
              title: TextSpan(
                children: [
                  TextSpan(
                    text: EnvironmentalPerformanceSummaryL10n.estimerMon,
                  ),
                  TextSpan(text: ' '),
                  TextSpan(
                    text: EnvironmentalPerformanceSummaryL10n
                        .bilanEnvironnemental,
                    style: DsfrTextStyle.headline2(
                      color: DsfrColors.blueFranceSun113,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s4w),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: EstimadedTimedWidget(
              questionsNumber: data.questionsNumber.toString(),
              questionsMinutes: '2',
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text(
              EnvironmentalPerformanceSummaryL10n
                  .commencerMonMiniBilanDescription,
              style: DsfrTextStyle.bodyLg(),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: DsfrButton(
                  label:
                      EnvironmentalPerformanceSummaryL10n.commencerMonMiniBilan,
                  variant: DsfrButtonVariant.primary,
                  size: DsfrButtonSize.lg,
                  onPressed: () async {
                    context.read<EnvironmentalPerformanceQuestionBloc>().add(
                          EnvironmentalPerformanceQuestionIdListGiven(
                            data.questions.map((final e) => e.id).toList(),
                          ),
                        );
                    await GoRouter.of(context).pushNamed(
                      EnvironmentalPerformanceQuestionPage.name,
                      pathParameters: {'number': '1'},
                    );

                    if (!context.mounted) {
                      return;
                    }

                    context
                        .read<EnvironmentalPerformanceBloc>()
                        .add(const EnvironmentalPerformanceStarted());
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s4w),
          const QuestionSection(),
          const SizedBox(height: DsfrSpacings.s4w),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: PartnerCard(),
          ),
          const SafeArea(child: SizedBox.shrink()),
        ],
      );
}
