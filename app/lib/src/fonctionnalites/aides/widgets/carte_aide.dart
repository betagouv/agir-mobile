import 'package:app/src/design_system/fondamentaux/colors.dart';
import 'package:app/src/design_system/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/src/design_system/fondamentaux/shadows.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class CarteAide extends StatelessWidget {
  const CarteAide({required this.titre, super.key});

  final String titre;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          shape: roundedRectangleBorder,
          color: FnvColors.carteFond,
          shadows: shadows,
        ),
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Row(
            children: [
              Expanded(child: Text(titre, style: DsfrFonts.bodyMdMedium)),
              const SizedBox(width: DsfrSpacings.s1w),
              const Icon(DsfrIcons.systemArrowRightSLine),
            ],
          ),
        ),
      );
}
