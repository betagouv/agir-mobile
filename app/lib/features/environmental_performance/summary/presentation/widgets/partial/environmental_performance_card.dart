import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_card_item.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class EnvironmentalPerformanceCard extends StatelessWidget {
  const EnvironmentalPerformanceCard({super.key, required this.partial});

  final EnvironmentalPerformancePartial partial;

  @override
  Widget build(final context) {
    final items = [
      if (partial.performanceOnTransport != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.transportsEmoji,
          label: EnvironmentalPerformanceSummaryL10n.transports,
          level: partial.performanceOnTransport!,
        ),
      if (partial.performanceOnFood != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.alimentationEmoji,
          label: EnvironmentalPerformanceSummaryL10n.alimentation,
          level: partial.performanceOnFood!,
        ),
      if (partial.performanceOnHousing != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.logementEmoji,
          label: EnvironmentalPerformanceSummaryL10n.logement,
          level: partial.performanceOnHousing!,
        ),
      if (partial.performanceOnConsumption != null)
        EnvironmentalPerformanceCardItem(
          emoji: EnvironmentalPerformanceSummaryL10n.consommationEmoji,
          label: EnvironmentalPerformanceSummaryL10n.consommation,
          level: partial.performanceOnConsumption!,
        ),
    ];

    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: FnvColors.carteFond,
        shadows: recommandationOmbre,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s3v, horizontal: DsfrSpacings.s2w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: DsfrSpacings.s2w, children: items),
      ),
    );
  }
}
