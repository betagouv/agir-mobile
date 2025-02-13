import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/environmental_performance/summary/domain/footprint.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/full/compare_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class EnvironmentalPerformanceTonnesCard extends StatelessWidget {
  const EnvironmentalPerformanceTonnesCard({
    super.key,
    required this.footprint,
  });

  final Footprint footprint;

  @override
  Widget build(final context) => DecoratedBox(
    decoration: const ShapeDecoration(
      color: FnvColors.carteFond,
      shadows: recommandationOmbre,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DsfrSpacings.s3v,
        horizontal: DsfrSpacings.s2w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s3v,
        children: [
          Row(
            spacing: DsfrSpacings.s1w,
            children: [
              Text(
                footprint.tonnesRepresentation,
                style: const DsfrTextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDF1451),
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      EnvironmentalPerformanceSummaryL10n.tonnes,
                      style: DsfrTextStyle.bodyMdBold(),
                    ),
                    Text(
                      EnvironmentalPerformanceSummaryL10n.deCO2eParAn,
                      style: DsfrTextStyle.bodyMd(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CompareBar(value: footprint.percentageOfMaxFootprint),
          MarkdownBody(
            data: EnvironmentalPerformanceSummaryL10n.aTitreDeComparaison,
            styleSheet: MarkdownStyleSheet(p: const DsfrTextStyle.bodyMd()),
          ),
        ],
      ),
    ),
  );
}
