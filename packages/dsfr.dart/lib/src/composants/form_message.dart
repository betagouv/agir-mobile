import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:dsfr/src/fondamentaux/fonts.dart';
import 'package:dsfr/src/fondamentaux/icons.g.dart';
import 'package:dsfr/src/fondamentaux/spacing.g.dart';
import 'package:flutter/material.dart';

enum DsfrFormMessageType { error, valid, warning, info }

class DsfrFormMessage extends StatelessWidget {
  const DsfrFormMessage({required this.type, required this.text, super.key});

  final DsfrFormMessageType type;
  final String text;

  Color _getColorByType(final DsfrFormMessageType type) => switch (type) {
        DsfrFormMessageType.error => DsfrColors.error425,
        DsfrFormMessageType.valid => DsfrColors.success425,
        DsfrFormMessageType.warning => DsfrColors.warning425,
        DsfrFormMessageType.info => DsfrColors.info425,
      };

  IconData _getIconByType(final DsfrFormMessageType type) => switch (type) {
        DsfrFormMessageType.error => DsfrIcons.systemFrErrorFill,
        DsfrFormMessageType.valid => DsfrIcons.systemCheckboxCircleFill,
        DsfrFormMessageType.warning => DsfrIcons.systemFrWarningFill,
        DsfrFormMessageType.info => DsfrIcons.systemFrInfoFill,
      };

  @override
  Widget build(final BuildContext context) {
    final color = _getColorByType(type);

    return Row(
      children: [
        Icon(_getIconByType(type), size: DsfrSpacings.s2w, color: color),
        const SizedBox(width: DsfrSpacings.s1v),
        Flexible(
          child: Text(text, style: DsfrFonts.bodyXs.copyWith(color: color)),
        ),
      ],
    );
  }
}
