import 'package:dsfr/dsfr.dart';
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
          onChanged.call(value);
        },
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
                  fillColor:
                      const WidgetStatePropertyAll(DsfrColors.blueFranceSun113),
                  onChanged: null,
                ),
                Text(
                  title,
                  style: DsfrFonts.bodySm,
                ),
              ],
            ),
          ),
        ),
      );
}
