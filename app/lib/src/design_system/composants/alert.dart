import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvAlert extends StatelessWidget {
  const FnvAlert._({
    required this.icon,
    required this.label,
    required this.color,
    super.key,
  });

  const FnvAlert.warning({
    required final String label,
    final Key? key,
  }) : this._(
          icon: DsfrIcons.systemFrWarningFill,
          label: label,
          color: DsfrColors.warning625,
          key: key,
        );

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(final BuildContext context) => Row(
        children: [
          Icon(
            icon,
            color: color,
            size: DsfrSpacings.s2w,
          ),
          const SizedBox(width: DsfrSpacings.s1w),
          Expanded(
            child: Text(label, style: DsfrFonts.bodySm.copyWith(color: color)),
          ),
        ],
      );
}
