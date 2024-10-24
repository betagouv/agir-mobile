import 'package:app/core/assets/svgs.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_bloc.dart';
import 'package:app/features/environmental_performance/questions/presentation/bloc/environmental_performance_question_event.dart';
import 'package:app/features/environmental_performance/questions/presentation/page/environmental_performance_question_page.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_empty.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_full.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_partial.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_summary.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_bloc.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_event.dart';
import 'package:app/features/environmental_performance/summary/presentation/bloc/environmental_performance_state.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/environmental_performance_tonnes_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_categories.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceSection extends StatelessWidget {
  const EnvironmentalPerformanceSection({super.key});

  @override
  Widget build(final BuildContext context) {
    context
        .read<EnvironmentalPerformanceBloc>()
        .add(const EnvironmentalPerformanceStarted());

    return const _View();
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<EnvironmentalPerformanceBloc, EnvironmentalPerformanceState>(
        builder: (final context, final state) => switch (state) {
          EnvironmentalPerformanceInitial() ||
          EnvironmentalPerformanceLoading() ||
          EnvironmentalPerformanceFailure() =>
            const SizedBox.shrink(),
          EnvironmentalPerformanceSuccess() => switch (state.data.type) {
              EnvironmentalPerformanceSummaryType.empty => _Empty(
                  data: state.data.empty,
                ),
              EnvironmentalPerformanceSummaryType.partial =>
                _Partial(data: state.data.partial),
              EnvironmentalPerformanceSummaryType.full =>
                _Full(data: state.data.full),
            },
        },
      );
}

class _Empty extends StatelessWidget {
  const _Empty({required this.data});

  final EnvironmentalPerformanceEmpty data;

  @override
  Widget build(final BuildContext context) => Column(
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
  Widget build(final BuildContext context) {
    const dimension = 64.0;

    return SizedBox.square(
      dimension: dimension,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(DsfrSpacings.s1w),
        ),
        child: SvgPicture.asset(
          AssetsSvgs.miniBilan,
          width: dimension,
          height: dimension,
          fit: BoxFit.cover,
          placeholderBuilder: (final context) =>
              const SizedBox.square(dimension: dimension),
        ),
      ),
    );
  }
}

class _Partial extends StatelessWidget {
  const _Partial({required this.data});

  final EnvironmentalPerformancePartial data;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _TitleAndSubtitle(),
          const SizedBox(height: DsfrSpacings.s2w),
          EnvironmentalPerformanceCategories(categories: data.categories),
          const SizedBox(height: DsfrSpacings.s2w),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Color(0xffeef1ff),
              border:
                  Border.fromBorderSide(BorderSide(color: Color(0xffD6D9F4))),
              borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DsfrSpacings.s3v,
                horizontal: DsfrSpacings.s3w,
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: EnvironmentalPerformanceSummaryL10n.etincelles,
                      style: DsfrTextStyle.headline4(),
                    ),
                    const TextSpan(text: ' ', style: DsfrTextStyle.bodyMd()),
                    const TextSpan(
                      text: 'Votre profil est complet à',
                      style: DsfrTextStyle.bodyMd(),
                    ),
                    const TextSpan(text: ' ', style: DsfrTextStyle.bodyMd()),
                    TextSpan(
                      text: '${data.percentageCompletion}%',
                      style: const DsfrTextStyle.bodyMd(
                        color: DsfrColors.blueFranceSun113,
                      ),
                    ),
                    const TextSpan(text: '.', style: DsfrTextStyle.bodyMd()),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}

class _TitleAndSubtitle extends StatelessWidget {
  const _TitleAndSubtitle();

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: EnvironmentalPerformanceSummaryL10n.estimerMon),
                TextSpan(text: ' '),
                TextSpan(
                  text:
                      EnvironmentalPerformanceSummaryL10n.bilanEnvironnemental,
                  style: DsfrTextStyle.headline5(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
              ],
            ),
            style: DsfrTextStyle.headline5(),
          ),
          const SizedBox(height: DsfrSpacings.s1v5),
          MarkdownBody(
            data: EnvironmentalPerformanceSummaryL10n
                .estimerMonEstimationSousTitre,
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd()),
          ),
        ],
      );
}

class _Full extends StatelessWidget {
  const _Full({required this.data});

  final EnvironmentalPerformanceFull data;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: EnvironmentalPerformanceSummaryL10n.mon),
                TextSpan(text: ' '),
                TextSpan(
                  text:
                      EnvironmentalPerformanceSummaryL10n.bilanEnvironnemental,
                  style: DsfrTextStyle.headline5(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
              ],
            ),
            style: DsfrTextStyle.headline5(),
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          EnvironmentalPerformanceTonnesCard(
            footprint: data.footprintInKgOfCO2ePerYear,
          ),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrLink.md(
            label: 'Voir le détail de mon empreinte',
            onTap: () async => GoRouter.of(context).pushNamed(
              EnvironmentalPerformanceSummaryPage.name,
            ),
          ),
        ],
      );
}
