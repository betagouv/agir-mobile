import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/environmental_performance/environmental_performance_l10n.dart';
import 'package:app/features/environmental_performance/presentation/widgets/environnemental_performance_card_item.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class EnvironnementalPerformanceCard extends StatelessWidget {
  const EnvironnementalPerformanceCard({super.key});

  @override
  Widget build(final BuildContext context) => const DecoratedBox(
        decoration: ShapeDecoration(
          color: FnvColors.carteFond,
          shadows: recommandationOmbre,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: DsfrSpacings.s3v,
            horizontal: DsfrSpacings.s2w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EnvironnementalPerformanceCardItem(
                emoji: EnvironmentalPerformanceLocalisation.transportsEmoji,
                label: EnvironmentalPerformanceLocalisation.transports,
                progress: 1,
              ),
              SizedBox(height: DsfrSpacings.s3v),
              EnvironnementalPerformanceCardItem(
                emoji: EnvironmentalPerformanceLocalisation.alimentationEmoji,
                label: EnvironmentalPerformanceLocalisation.alimentation,
                progress: 0.77,
              ),
              SizedBox(height: DsfrSpacings.s3v),
              EnvironnementalPerformanceCardItem(
                emoji: EnvironmentalPerformanceLocalisation.logementEmoji,
                label: EnvironmentalPerformanceLocalisation.logement,
                progress: 0.47,
              ),
              SizedBox(height: DsfrSpacings.s3v),
              EnvironnementalPerformanceCardItem(
                emoji: EnvironmentalPerformanceLocalisation.consommationEmoji,
                label: EnvironmentalPerformanceLocalisation.consommation,
                progress: 0.23,
              ),
            ],
          ),
        ),
      );
}
