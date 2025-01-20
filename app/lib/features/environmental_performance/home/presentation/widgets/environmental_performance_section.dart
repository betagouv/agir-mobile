import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_event.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_state.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/environmental_performance_tonnes_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_categories.dart';
import 'package:app/features/home/presentation/widgets/title_section.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceSection extends StatelessWidget {
  const EnvironmentalPerformanceSection({super.key});

  @override
  Widget build(final context) => const _View();
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) =>
      BlocBuilder<EnvironmentalPerformanceBloc, EnvironmentalPerformanceState>(
        builder: (final context, final state) => switch (state) {
          EnvironmentalPerformanceInitial() ||
          EnvironmentalPerformanceLoading() ||
          EnvironmentalPerformanceFailure() =>
            const SizedBox.shrink(),
          EnvironmentalPerformanceSuccess() => switch (state.data) {
              (final EnvironmentalPerformanceEmpty a) => _Empty(data: a),
              (final EnvironmentalPerformancePartial a) => _Partial(data: a),
              (final EnvironmentalPerformanceFull a) => _Full(data: a),
            },
        },
      );
}

class _Empty extends StatelessWidget {
  const _Empty({required this.data});

  final EnvironmentalPerformanceEmpty data;

  @override
  Widget build(final context) => Column(
        children: [
          const _TitleAndSubtitle(),
          const SizedBox(height: DsfrSpacings.s2w),
          DecoratedBox(
            decoration: const ShapeDecoration(
              color: FnvColors.carteFond,
              shadows: recommandationOmbre,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
              ),
            ),
            child: Material(
              color: FnvColors.transparent,
              child: InkWell(
                onTap: () async {
                  context.read<EnvironmentalPerformanceQuestionBloc>().add(
                        EnvironmentalPerformanceQuestionIdListGiven(
                          data.questions.map((final e) => e.id).toList(),
                        ),
                      );
                  final result = await GoRouter.of(context).pushNamed(
                    EnvironmentalPerformanceQuestionPage.name,
                    pathParameters: {'number': '1'},
                  );

                  if (!context.mounted) {
                    return;
                  }

                  if (result == true) {
                    await GoRouter.of(context)
                        .pushNamed(EnvironmentalPerformanceSummaryPage.name);

                    return;
                  }

                  context
                      .read<EnvironmentalPerformanceBloc>()
                      .add(const EnvironmentalPerformanceStarted());
                },
                borderRadius:
                    const BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
                child: Padding(
                  padding: const EdgeInsets.all(DsfrSpacings.s1w),
                  child: Row(
                    children: [
                      const _Icon(),
                      const SizedBox(width: DsfrSpacings.s1w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              EnvironmentalPerformanceSummaryL10n
                                  .estimerUnPremierBilan,
                              style: DsfrTextStyle.bodyLgBold(),
                            ),
                            Text(
                              '${data.questionsNumber} questions',
                              style: const DsfrTextStyle.bodySm(
                                color: DsfrColors.blueFranceSun113,
                              ),
                            ),
                            const SizedBox(height: DsfrSpacings.s1w),
                            LinearProgressIndicator(
                              value: data.percentageCompletion,
                              backgroundColor: const Color(0xFFEEEEFF),
                              color: DsfrColors.blueFranceSun113,
                              minHeight: 5,
                              semanticsLabel:
                                  '${data.questionsNumberAnswered} questions répondues sur ${data.questionsNumber}',
                              borderRadius: const BorderRadius.all(
                                Radius.circular(DsfrSpacings.s1v),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: DsfrSpacings.s1w),
                      const Icon(DsfrIcons.systemArrowRightSLine),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class _Icon extends StatelessWidget {
  const _Icon();

  @override
  Widget build(final context) {
    const dimension = 64.0;

    return SizedBox.square(
      dimension: dimension,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
        child: FnvSvg.asset(
          AssetsImages.miniBilan,
          width: dimension,
          height: dimension,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Partial extends StatelessWidget {
  const _Partial({required this.data});

  final EnvironmentalPerformancePartial data;

  @override
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TitleAndSubtitle(),
          const SizedBox(height: DsfrSpacings.s2w),
          EnvironmentalPerformanceCategories(categories: data.categories),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrLink.md(
            label: EnvironmentalPerformanceSummaryL10n.voirMonBilanDetaille,
            onTap: () async => GoRouter.of(context).pushNamed(
              EnvironmentalPerformanceSummaryPage.name,
            ),
          ),
        ],
      );
}

class _TitleAndSubtitle extends StatelessWidget {
  const _TitleAndSubtitle();

  @override
  Widget build(final context) => const TitleSection(
        title:
            EnvironmentalPerformanceSummaryL10n.estimerMonBilanEnvironnemental,
        subTitle:
            EnvironmentalPerformanceSummaryL10n.estimerMonEstimationSousTitre,
      );
}

class _Full extends StatelessWidget {
  const _Full({required this.data});

  final EnvironmentalPerformanceFull data;

  @override
  Widget build(final context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: EnvironmentalPerformanceSummaryL10n.monBilanEnvironnemental,
            styleSheet: MarkdownStyleSheet(
              p: const DsfrTextStyle.headline4(),
              strong: const DsfrTextStyle.headline4(
                color: DsfrColors.blueFranceSun113,
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          EnvironmentalPerformanceTonnesCard(
            footprint: data.footprintInKgOfCO2ePerYear,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrLink.md(
            label: EnvironmentalPerformanceSummaryL10n.voirMonBilanDetaille,
            onTap: () async => GoRouter.of(context).pushNamed(
              EnvironmentalPerformanceSummaryPage.name,
            ),
          ),
        ],
      );
}
