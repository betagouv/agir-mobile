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

  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: () {
          onChanged(value);
        },
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
              children: [
                Radio<T>(
                  value: value,
                  groupValue: groupValue,
                  onChanged: null,
                  fillColor:
                      const WidgetStatePropertyAll(DsfrColors.blueFranceSun113),
                ),
                Expanded(child: Text(title, style: DsfrFonts.bodySm)),
              ],
            ),
          ),
        ),
      );
}
