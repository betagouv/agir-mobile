import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/partner_card.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:flutter/material.dart';

class EnvironmentalPerformancePartnerCard extends StatelessWidget {
  const EnvironmentalPerformancePartnerCard({super.key});

  @override
  Widget build(final context) => const PartnerCard(
        image: AssetImages.nosGestesClimatIllustration,
        name: EnvironmentalPerformanceSummaryL10n.nosGestesClimat,
        description:
            EnvironmentalPerformanceSummaryL10n.nosGestesClimatDescription,
        url: EnvironmentalPerformanceSummaryL10n.nosGestesClimatUrl,
        logo: AssetImages.nosGestesClimat,
      );
}
