import 'package:app/features/environmental_performance/summary/domain/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_card_item_level.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/summary/presentation/widgets/partial/rainbow_progress_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class EnvironmentalPerformanceCardItem extends StatelessWidget {
  const EnvironmentalPerformanceCardItem({
    super.key,
    required this.emoji,
    required this.label,
    required this.level,
  });

  final String emoji;
  final String label;
  final EnvironmentalPerformanceLevel level;

  @override
  Widget build(final context) {
    final levelRepresentation =
        EnvironmentalPerformanceLevelRepresentation.fromProgress(level);

    return Row(
      children: [
        Text(emoji, style: const DsfrTextStyle.headline4()),
        const SizedBox(width: DsfrSpacings.s3v),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: const DsfrTextStyle.bodyMdMedium(),
                    ),
                  ),
                  const SizedBox(width: DsfrSpacings.s1v5),
                  EnvironmentalPerformanceCardItemLevel(
                    label: levelRepresentation.label,
                    backgroundColor: levelRepresentation.backgroundColor,
                    labelColor: levelRepresentation.labelColor,
                  ),
                ],
              ),
              const SizedBox(height: DsfrSpacings.s1v5),
              RainbowProgressBar(
                value: switch (level) {
                  EnvironmentalPerformanceLevel.low => 0.23,
                  EnvironmentalPerformanceLevel.medium => 0.47,
                  EnvironmentalPerformanceLevel.high => 0.77,
                  EnvironmentalPerformanceLevel.veryHigh => 1,
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
