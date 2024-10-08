import 'package:app/core/assets/images.dart';
import 'package:app/features/environmental_performance/environmental_performance_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({super.key});

  @override
  Widget build(final BuildContext context) {
    const backgroundColor = Color(0xffeef2ff);
    const borderColor = Color(0xffb1b1ff);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border.fromBorderSide(BorderSide(color: borderColor)),
        borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 1, top: 1, right: 1),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(DsfrSpacings.s1w - 1),
                topRight: Radius.circular(DsfrSpacings.s1w - 1),
              ),
              child: Image.asset(
                AssetsImages.nosGestesClimatIllustration,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const DsfrDivider(color: borderColor),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DsfrSpacings.s1w,
              horizontal: DsfrSpacings.s3w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  EnvironmentalPerformanceLocalisation.proposePar,
                  style: DsfrTextStyle.bodySmItalic(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
                const Text(
                  EnvironmentalPerformanceLocalisation.nosGestesClimat,
                  style: DsfrTextStyle.headline5(),
                ),
                const SizedBox(height: DsfrSpacings.s1w),
                const Text(
                  EnvironmentalPerformanceLocalisation
                      .nosGestesClimatDescription,
                  style: DsfrTextStyle(fontSize: 15),
                ),
                const SizedBox(height: DsfrSpacings.s1w),
                DsfrLink.md(
                  label:
                      EnvironmentalPerformanceLocalisation.nosGestesClimatUrl,
                  onTap: () async => launchUrlString(
                    EnvironmentalPerformanceLocalisation.nosGestesClimatUrl,
                  ),
                ),
                const SizedBox(height: DsfrSpacings.s4w),
                Image.asset(AssetsImages.nosGestesClimat, height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
