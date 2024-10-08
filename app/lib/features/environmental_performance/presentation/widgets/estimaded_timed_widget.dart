import 'package:app/features/environmental_performance/environmental_performance_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class EstimadedTimedWidget extends StatelessWidget {
  const EstimadedTimedWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    const backgroundColor = Color(0xffeef2ff);
    const borderColor = Color(0xffb1b1ff);

    return const DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.fromBorderSide(BorderSide(color: borderColor)),
        borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: DsfrSpacings.s3v,
          horizontal: DsfrSpacings.s3w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: _EstimadedTimedInfo(
                icon: DsfrIcons.communicationQuestionnaireLine,
                number: '10',
                text: EnvironmentalPerformanceLocalisation.questions,
              ),
            ),
            Flexible(
              child: _EstimadedTimedInfo(
                icon: DsfrIcons.systemTimerLine,
                number: '5',
                text: EnvironmentalPerformanceLocalisation.minutes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstimadedTimedInfo extends StatelessWidget {
  const _EstimadedTimedInfo({
    required this.icon,
    required this.number,
    required this.text,
  });

  final IconData icon;
  final String number;
  final String text;

  @override
  Widget build(final BuildContext context) {
    const color = DsfrColors.blueFranceSun113;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: color),
        const SizedBox(width: DsfrSpacings.s1w),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: const DsfrTextStyle.bodyMdBold(color: color),
                ),
                TextSpan(
                  text: ' $text',
                  style: const DsfrTextStyle.bodyMd(color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
