import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvTitle extends StatelessWidget {
  const FnvTitle({required this.title, this.subtitle, super.key});

  final String title;
  final String? subtitle;

  @override
  Widget build(final BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const DsfrTextStyle.headline2()),
          if (subtitle != null) ...[
            const SizedBox(height: DsfrSpacings.s1w),
            Text(subtitle!, style: const DsfrTextStyle.bodyMd()),
          ],
          const SizedBox(height: DsfrSpacings.s2w),
          const DsfrDivider(
            width: DsfrSpacings.s4w,
            height: DsfrSpacings.s0v5,
            color: DsfrColors.blueFranceSun113,
            alignment: Alignment.centerLeft,
          ),
        ],
      );
}
