import 'package:dsfr/src/composants/checkbox_icon.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrCheckbox extends StatelessWidget {
  const DsfrCheckbox._({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.padding,
    super.key,
  });

  const DsfrCheckbox.sm({
    required final String label,
    required final bool value,
    required final ValueChanged<bool>? onChanged,
    final Key? key,
  }) : this._(
          label: label,
          value: value,
          onChanged: onChanged,
          padding: EdgeInsets.zero,
          key: key,
        );

  const DsfrCheckbox.md({
    required final String label,
    required final bool value,
    final ValueChanged<bool>? onChanged,
    final Key? key,
  }) : this._(
          label: label,
          value: value,
          onChanged: onChanged,
          padding: const EdgeInsets.all(DsfrSpacings.s1v),
          key: key,
        );

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final EdgeInsets padding;

  @override
  Widget build(final context) => GestureDetector(
        onTap: onChanged == null ? null : () => onChanged?.call(!value),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DsfrCheckboxIcon(value: value, padding: padding),
            const SizedBox(width: DsfrSpacings.s1w),
            Flexible(
              child: Text(
                label,
                style: value
                    ? const DsfrTextStyle.bodyMdBold()
                    : const DsfrTextStyle.bodyMd(),
              ),
            ),
          ],
        ),
      );
}
