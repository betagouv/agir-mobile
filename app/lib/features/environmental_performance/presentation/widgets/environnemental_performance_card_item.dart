import 'package:app/features/environmental_performance/presentation/widgets/environmental_performance_level.dart';
import 'package:app/features/environmental_performance/presentation/widgets/environnemental_performance_card_item_level.dart';
import 'package:app/features/environmental_performance/presentation/widgets/progress_bar.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class EnvironnementalPerformanceCardItem extends StatelessWidget {
  const EnvironnementalPerformanceCardItem({
    super.key,
    required this.emoji,
    required this.label,
    required this.progress,
  });

  final String emoji;
  final String label;
  final double progress;

  @override
  Widget build(final BuildContext context) {
    final level = EnvironmentalPerformanceLevel.fromProgress(progress);

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
                  EnvironnementalPerformanceCardItemLevel(
                    label: level.label,
                    backgroundColor: level.backgroundColor,
                    labelColor: level.labelColor,
                  ),
                ],
              ),
              const SizedBox(height: DsfrSpacings.s1v5),
              ProgressBar(value: progress),
            ],
          ),
        ),
      ],
    );
  }
}
