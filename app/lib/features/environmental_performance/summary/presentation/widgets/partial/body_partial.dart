import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_categories.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partner_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/question_section.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class BodyPartial extends StatelessWidget {
  const BodyPartial({super.key, required this.data});

  final EnvironmentalPerformancePartial data;

  @override
  Widget build(final context) => ListView(
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text(
              EnvironmentalPerformanceSummaryL10n.maPremiereEstimation,
              style: DsfrTextStyle.headline4(),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: EnvironmentalPerformanceCard(partial: data),
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: EnvironmentalPerformanceSummaryL10n.etincelles,
                    style: DsfrTextStyle.headline4(),
                  ),
                  const TextSpan(
                    text:
                        ' ${EnvironmentalPerformanceSummaryL10n.estimationCompleteA} ',
                    style: DsfrTextStyle.bodyMd(),
                  ),
                  TextSpan(
                    text: '${data.percentageCompletion}%',
                    style: const DsfrTextStyle.bodyMd(
                      color: DsfrColors.blueFranceSun113,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s4w),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: EnvironmentalPerformanceSummaryL10n.affiner,
                    style: DsfrTextStyle.headline4(),
                  ),
                  TextSpan(text: ' ', style: DsfrTextStyle.headline4()),
                  TextSpan(
                    text: EnvironmentalPerformanceSummaryL10n.monEstimation,
                    style: DsfrTextStyle.headline4(
                      color: DsfrColors.blueFranceSun113,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s1v5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text(
              EnvironmentalPerformanceSummaryL10n.affinerMonEstimationSousTitre,
              style: DsfrTextStyle.bodyMd(),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3v),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child:
                EnvironmentalPerformanceCategories(categories: data.categories),
          ),
          const SizedBox(height: DsfrSpacings.s7w),
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
