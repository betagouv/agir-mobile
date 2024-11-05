import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

class DsfrToggle extends StatelessWidget {
  const DsfrToggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(final context) => GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            _Switch(value: value),
            const SizedBox(width: DsfrSpacings.s2w),
            Flexible(child: Text(label, style: const DsfrTextStyle.bodyMd())),
          ],
        ),
      );
}

class _Switch extends StatelessWidget {
  const _Switch({required this.value});

  final bool value;

  @override
  Widget build(final context) {
    const width = 40.0;
    const height = 24.0;
    const offset = width - height;
    const primary = DsfrColors.blueFranceSun113;
    const border = Border.fromBorderSide(BorderSide(color: primary));
    const borderRadius = BorderRadius.all(Radius.circular(width));

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: value ? primary : null,
              border: border,
              borderRadius: borderRadius,
            ),
          ),
          Positioned(
            left: value ? offset : 0,
            top: 0,
            right: value ? 0 : offset,
            bottom: 0,
            child: value
                ? const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: border,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      DsfrIcons.systemCheckLine,
                      size: 16,
                      color: primary,
                    ),
                  )
                : const DecoratedBox(
                    decoration: BoxDecoration(
                      border: border,
                      borderRadius: borderRadius,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
