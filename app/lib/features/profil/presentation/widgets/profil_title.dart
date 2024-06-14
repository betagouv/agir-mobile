import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ProfilTitle extends StatelessWidget {
  const ProfilTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DsfrFonts.headline2),
          const SizedBox(height: DsfrSpacings.s3w),
          const DsfrDivider(
            width: DsfrSpacings.s4w,
            height: DsfrSpacings.s0v5,
            color: DsfrColors.blueFranceSun113,
            alignment: Alignment.centerLeft,
          ),
          const SizedBox(height: DsfrSpacings.s3w),
        ],
      );
}
