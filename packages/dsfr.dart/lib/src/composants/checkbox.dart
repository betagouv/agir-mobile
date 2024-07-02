import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrCheckbox extends StatelessWidget {
  const DsfrCheckbox._({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  const DsfrCheckbox.sm({
    required final String label,
    required final bool value,
    required final ValueChanged<bool>? onChanged,
    final Key? key,
  }) : this._(label: label, value: value, onChanged: onChanged, key: key);

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  void _handleTap() {
    onChanged?.call(!value);
  }

  @override
  Widget build(final BuildContext context) {
    const dimension = 16.0;
    const iconColor = DsfrColors.blueFrance975;
    const backgroundColor = DsfrColors.blueFranceSun113;
    const labelStyle = DsfrTextStyle.bodyMd();
    const borderRadius = BorderRadius.all(Radius.circular(4));
    const gap = DsfrSpacings.s1w;

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: value ? backgroundColor : null,
              border: const Border.fromBorderSide(
                BorderSide(color: backgroundColor),
              ),
              borderRadius: borderRadius,
            ),
            child: SizedBox.square(
              dimension: dimension,
              child: value
                  ? const Icon(
                      DsfrIcons.systemCheckLine,
                      size: dimension,
                      color: iconColor,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: gap),
          Flexible(child: Text(label, style: labelStyle)),
        ],
      ),
    );
  }
}
