import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class TopEmissionSourceItem extends StatelessWidget {
  const TopEmissionSourceItem({
    super.key,
    required this.rank,
    required this.label,
    required this.percentage,
    required this.emoji,
  });

  final int rank;
  final String label;
  final String percentage;
  final String emoji;

  @override
  Widget build(final context) => Row(
    children: [
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$rank.', style: const DsfrTextStyle.bodyXlMedium()),
            const SizedBox(width: DsfrSpacings.s1w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const DsfrTextStyle.bodyXlBold()),
                  const SizedBox(height: DsfrSpacings.s1v5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$percentage%',
                          style: const DsfrTextStyle.bodyLgBold(
                            color: Color(0xFFDF1451),
                          ),
                        ),
                        const TextSpan(
                          text: ' de vos émissions',
                          style: DsfrTextStyle.bodyLg(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: DsfrSpacings.s1w),
      Text(emoji, style: const DsfrTextStyle(fontSize: 30)),
      const SizedBox(width: DsfrSpacings.s2w),
    ],
  );
}
