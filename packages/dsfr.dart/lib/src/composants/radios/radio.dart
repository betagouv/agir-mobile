import 'package:dsfr/src/composants/radios/radio_icon.dart';
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRadioButton<T> extends StatelessWidget {
  const DsfrRadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.backgroundColor,
  });

  final String title;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? backgroundColor;

  @override
  Widget build(final context) => GestureDetector(
        onTap: onChanged == null ? null : () => onChanged!(value),
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.fromBorderSide(
              BorderSide(
                color: groupValue == value
                    ? DsfrColors.blueFranceSun113
                    : DsfrColors.grey900,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioIcon(
                  key: ValueKey(title),
                  value: value,
                  groupValue: groupValue,
                ),
                const SizedBox(width: DsfrSpacings.s1w),
                Flexible(
                  child: Text(title, style: const DsfrTextStyle.bodyMd()),
                ),
              ],
            ),
          ),
        ),
      );
}
