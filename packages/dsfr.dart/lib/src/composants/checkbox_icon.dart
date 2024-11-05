import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:flutter/material.dart';

class DsfrCheckboxIcon extends StatelessWidget {
  const DsfrCheckboxIcon({
    super.key,
    required this.value,
    this.padding = EdgeInsets.zero,
  });

  final bool value;
  final EdgeInsets padding;

  @override
  Widget build(final context) {
    const dimension = 16.0;
    const backgroundColor = DsfrColors.blueFranceSun113;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: value ? backgroundColor : null,
        border: const Border.fromBorderSide(
          BorderSide(color: backgroundColor),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: padding,
        child: SizedBox.square(
          dimension: dimension,
          child: value
              ? const Icon(
                  DsfrIcons.systemCheckLine,
                  size: dimension,
                  color: DsfrColors.blueFrance975,
                )
              : null,
        ),
      ),
    );
  }
}
