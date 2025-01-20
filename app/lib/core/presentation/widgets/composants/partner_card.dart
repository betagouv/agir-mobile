import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/environmental_performance/summary/environmental_performance_summary_l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.url,
    required this.logo,
  });

  final String image;
  final String name;
  final String description;
  final String url;
  final String logo;

  @override
  Widget build(final context) {
    const borderColor = Color(0xffb1b1ff);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xffeef2ff),
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
                child: FnvImage.asset(
                  image,
                  alignment: Alignment.topCenter,
                  height: 170,
                  fit: BoxFit.cover,
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
                Text(name, style: const DsfrTextStyle.headline5()),
                const SizedBox(height: DsfrSpacings.s1w),
                Text(description, style: const DsfrTextStyle(fontSize: 15)),
                const SizedBox(height: DsfrSpacings.s1w),
                DsfrLink.md(
                  label: url,
                  onTap: () async => FnvUrlLauncher.launch(url),
                ),
                const SizedBox(height: DsfrSpacings.s4w),
                FnvImage.asset(
                  logo,
                  height: 40,
                  semanticLabel: 'Logo de $name',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
