import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class EstimadedTimedWidget extends StatelessWidget {
  const EstimadedTimedWidget({
    super.key,
    required this.questionsNumber,
    required this.questionsMinutes,
  });

  final String questionsNumber;
  final String questionsMinutes;

  @override
  Widget build(final context) {
    const backgroundColor = Color(0xffeef2ff);
    const borderColor = Color(0xffb1b1ff);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border.fromBorderSide(BorderSide(color: borderColor)),
        borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DsfrSpacings.s3v,
          horizontal: DsfrSpacings.s3w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: _EstimadedTimedInfo(
                icon: DsfrIcons.communicationQuestionnaireLine,
                number: questionsNumber,
                text: EnvironmentalPerformanceSummaryL10n.questions,
              ),
            ),
            Flexible(
              child: _EstimadedTimedInfo(
                icon: DsfrIcons.systemTimerLine,
                number: questionsMinutes,
                text: EnvironmentalPerformanceSummaryL10n.minutes,
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
  Widget build(final context) {
    const color = DsfrColors.blueFranceSun113;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: DsfrSpacings.s1w,
      children: [
        Icon(icon, size: 24, color: color),
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
