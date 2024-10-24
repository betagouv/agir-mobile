import 'package:app/core/assets/images.dart';
import 'package:app/core/assets/svgs.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                topLeft: Radius.circular(DsfrSpacings.s1w),
                topRight: Radius.circular(DsfrSpacings.s1w),
              ),
              child: ColoredBox(
                color: Colors.white,
                child: SvgPicture.asset(
                  AssetsSvgs.nosGestesClimatIllustration,
                  height: 170,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  semanticsLabel: 'Illustration de Nos Gestes Climat',
                ),
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
                  EnvironmentalPerformanceSummaryL10n.proposePar,
                  style: DsfrTextStyle.bodySmItalic(
                    color: DsfrColors.blueFranceSun113,
                  ),
                ),
                const Text(
                  EnvironmentalPerformanceSummaryL10n.nosGestesClimat,
                  style: DsfrTextStyle.headline5(),
                ),
                const SizedBox(height: DsfrSpacings.s1w),
                const Text(
                  EnvironmentalPerformanceSummaryL10n
                      .nosGestesClimatDescription,
                  style: DsfrTextStyle(fontSize: 15),
                ),
                const SizedBox(height: DsfrSpacings.s1w),
                DsfrLink.md(
                  label: EnvironmentalPerformanceSummaryL10n.nosGestesClimatUrl,
                  onTap: () async => launchUrlString(
                    EnvironmentalPerformanceSummaryL10n.nosGestesClimatUrl,
                  ),
                ),
                const SizedBox(height: DsfrSpacings.s4w),
                Image.asset(
                  AssetsImages.nosGestesClimat,
                  semanticLabel: 'Logo de Nos Gestes Climat',
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
