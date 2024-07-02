import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class FnvAlert extends StatelessWidget {
  const FnvAlert._({
    required this.icon,
    required this.label,
    required this.color,
    super.key,
  });

  const FnvAlert.error({required final String label, final Key? key})
      : this._(
          icon: DsfrIcons.systemFrWarningFill,
          label: label,
          color: DsfrColors.error425,
          key: key,
        );

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(final BuildContext context) => Row(
        children: [
          Icon(icon, size: DsfrSpacings.s2w, color: color),
          const SizedBox(width: DsfrSpacings.s1w),
          Expanded(
            child: Text(label, style: DsfrTextStyle.bodySm(color: color)),
          ),
        ],
      );
}
