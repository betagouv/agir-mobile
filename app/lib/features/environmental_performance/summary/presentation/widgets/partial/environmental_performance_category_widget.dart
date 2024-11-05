import 'package:app/core/presentation/widgets/composants/badge.dart';
import 'package:app/core/presentation/widgets/composants/fnv_image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class EnvironmentalPerformanceCategoryWidget extends StatelessWidget {
  const EnvironmentalPerformanceCategoryWidget({
    super.key,
    required this.imageUrl,
    required this.completion,
    required this.label,
    required this.numberOfQuestions,
    required this.onTap,
  });

  static const _imageWidth = 130.0;
  static const _imageHeight = 126.0;

  final String imageUrl;
  final int completion;
  final String label;
  final int numberOfQuestions;
  final VoidCallback onTap;

  @override
  Widget build(final context) {
    final progression = completion / 100;

    final color =
        progression >= 1 ? DsfrColors.success425 : DsfrColors.blueFranceSun113;

    final widget = DecoratedBox(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shadows: recommandationOmbre,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
        ),
      ),
      child: Material(
        color: FnvColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius:
              const BorderRadius.all(Radius.circular(DsfrSpacings.s1w)),
          child: Padding(
            padding: const EdgeInsets.only(
              left: DsfrSpacings.s1w,
              top: DsfrSpacings.s1w,
              right: DsfrSpacings.s1w,
              bottom: DsfrSpacings.s3v,
            ),
            child: SizedBox(
              width: _imageWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(DsfrSpacings.s1v),
                    ),
                    child: FnvImage.network(
                      imageUrl,
                      width: _imageWidth,
                      height: _imageHeight,
                    ),
                  ),
                  const SizedBox(height: DsfrSpacings.s1v),
                  LinearProgressIndicator(
                    value: progression,
                    backgroundColor: const Color(0xFFEEEEFF),
                    color: color,
                    minHeight: DsfrSpacings.s1v5,
                    semanticsLabel: 'Bilan complété à $completion%',
                    borderRadius: const BorderRadius.all(
                      Radius.circular(DsfrSpacings.s1v),
                    ),
                  ),
                  const SizedBox(height: DsfrSpacings.s1w),
                  Text(label, style: const DsfrTextStyle.bodyLgMedium()),
                  Text(
                    '$numberOfQuestions questions',
                    style: DsfrTextStyle.bodySm(color: color),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(padding: const EdgeInsets.only(top: 10), child: widget),
        if (progression >= 1)
          FnvBadge(label: 'TERMINÉ !', backgroundColor: color),
      ],
    );
  }
}
