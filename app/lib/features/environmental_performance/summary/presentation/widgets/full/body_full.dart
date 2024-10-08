// ignore_for_file: avoid-slow-collection-methods

import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_full.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/accordion.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/environmental_performance_tonnes_card.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/progress_bar.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/top_emission_source_item.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partner_card.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:collection/collection.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class BodyFull extends StatelessWidget {
  const BodyFull({super.key, required this.data});

  final EnvironmentalPerformanceFull data;

  @override
  Widget build(final BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3w),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: FnvTitleWidget(
              title: TextSpan(
                children: [
                  TextSpan(text: EnvironmentalPerformanceSummaryL10n.mon),
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
          const SizedBox(height: DsfrSpacings.s3w),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: EnvironmentalPerformanceTonnesCard(
              footprint: data.footprintInKgOfCO2ePerYear,
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text(
              EnvironmentalPerformanceSummaryL10n.mesPrincipauxPostesDemission,
              style: DsfrTextStyle.headline4(),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          ...data.top
              .mapIndexed(
                (final i, final e) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: paddingVerticalPage,
                  ),
                  child: TopEmissionSourceItem(
                    rank: i + 1,
                    label: e.label,
                    percentage: e.percentage?.toString() ?? '-',
                    emoji: e.emoji,
                  ),
                ),
              )
              .separator(const SizedBox(height: DsfrSpacings.s3w)),
          const SizedBox(height: DsfrSpacings.s3w),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: Text(
              EnvironmentalPerformanceSummaryL10n.voirDetailHebdomadaire,
              style: DsfrTextStyle.headline4(),
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          FnvAccordionsGroup(
            values: data.detail
                .map(
                  (final e) => FnvAccordion(
                    headerBuilder: (final isExpanded) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DsfrSpacings.s3w,
                      ),
                      child: _DetailHeader(
                        emoji: e.emoji,
                        label: e.label,
                        value:
                            e.footprintInKgOfCO2ePerYear.tonnesRepresentation,
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(DsfrSpacings.s3w),
                      child: Column(
                        children: e.subItems
                            .map(
                              (final f) => _DetailBody(
                                emoji: f.emoji,
                                label: f.label,
                                value: f.footprintInKgOfCO2ePerYear
                                    .kilogramsRepresentation,
                                progress: (f.percentage?.toDouble() ?? 0.0) /
                                    (e.subItems.first.percentage?.toDouble() ??
                                        100.0),
                              ),
                            )
                            .separator(const SizedBox(height: DsfrSpacings.s3w))
                            .toList(),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage),
            child: PartnerCard(),
          ),
          const SafeArea(child: SizedBox.shrink()),
        ],
      );
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.emoji,
    required this.label,
    required this.value,
  });

  final String emoji;
  final String label;
  final String value;

  @override
  Widget build(final context) {
    const color = Color(0xFF3636A1);

    return Row(
      children: [
        Text(emoji, style: const DsfrTextStyle.bodySmMedium()),
        const SizedBox(width: DsfrSpacings.s1w),
        Expanded(
          child: Text(label, style: const DsfrTextStyle.bodySmMedium()),
        ),
        const SizedBox(width: DsfrSpacings.s1w),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const DsfrTextStyle.bodySmBold(color: color),
              ),
              const TextSpan(text: ' '),
              const TextSpan(text: EnvironmentalPerformanceSummaryL10n.tonnes),
            ],
          ),
          style: const DsfrTextStyle.bodySm(color: color),
        ),
      ],
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.emoji,
    required this.label,
    required this.value,
    required this.progress,
  });

  final String emoji;
  final String label;
  final String value;
  final double progress;

  @override
  Widget build(final context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const DsfrTextStyle.bodySmMedium()),
          const SizedBox(width: DsfrSpacings.s1w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(label, style: const DsfrTextStyle.bodySmMedium()),
                const SizedBox(height: DsfrSpacings.s1v5),
                ProgressBar(value: progress),
              ],
            ),
          ),
          const SizedBox(width: DsfrSpacings.s2w),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style:
                      const DsfrTextStyle.bodySmBold(color: Color(0xff3636A1)),
                ),
                const TextSpan(text: ' '),
                const TextSpan(text: EnvironmentalPerformanceSummaryL10n.kg),
              ],
            ),
            style: const DsfrTextStyle.bodySm(color: Color(0xff3636A1)),
          ),
        ],
      );
}
