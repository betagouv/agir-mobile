import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrRadioButton<T> extends StatelessWidget {
  const DsfrRadioButton({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  void _handleChange() => onChanged(value);

  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: _handleChange,
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                color: groupValue == value
                    ? DsfrColors.blueFranceSun113
                    : DsfrColors.grey900,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: DsfrSpacings.s2w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<T>(
                  key: ValueKey(title),
                  value: value,
                  groupValue: groupValue,
                  onChanged: null,
                  fillColor:
                      const WidgetStatePropertyAll(DsfrColors.blueFranceSun113),
                ),
                Text(title, style: DsfrFonts.bodySm),
              ],
            ),
          ),
        ),
      );
}
