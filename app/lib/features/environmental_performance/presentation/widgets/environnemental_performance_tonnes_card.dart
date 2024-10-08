import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/environmental_performance/environmental_performance_l10n.dart';
import 'package:app/features/environmental_performance/presentation/widgets/compare_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class EnvironnementalPerformanceTonnesCard extends StatelessWidget {
  const EnvironnementalPerformanceTonnesCard({super.key});

  @override
  Widget build(final BuildContext context) => DecoratedBox(
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
            children: [
              const Row(
                children: [
                  Text(
                    '16,4',
                    style: DsfrTextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDF1451),
                    ),
                  ),
                  SizedBox(width: DsfrSpacings.s1w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        EnvironmentalPerformanceLocalisation.tonnes,
                        style: DsfrTextStyle.bodyMdBold(),
                      ),
                      Text(
                        EnvironmentalPerformanceLocalisation.deCO2eParAn,
                        style: DsfrTextStyle.bodyMd(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: DsfrSpacings.s1w),
              const CompareBar(value: 1),
              const SizedBox(height: DsfrSpacings.s1w),
              MarkdownBody(
                data: EnvironmentalPerformanceLocalisation.aTitreDeComparaison,
                styleSheet: MarkdownStyleSheet(
                  p: const DsfrTextStyle.bodyMd(),
                ),
              ),
              const SizedBox(height: DsfrSpacings.s4w),
              DsfrLink.sm(
                label: EnvironmentalPerformanceLocalisation.quEstCeQueCest,
                onTap: () {},
              ),
            ],
          ),
        ),
      );
}
