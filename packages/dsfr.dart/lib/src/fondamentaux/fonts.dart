// ignore_for_file: unused-code
import 'package:dsfr/src/fondamentaux/colors.g.dart';
import 'package:flutter/material.dart';

class DsfrTextStyle extends TextStyle {
  const DsfrTextStyle({
    required final double fontSize,
    super.fontWeight = FontWeight.normal,
    super.color = DsfrColors.grey50,
    super.fontStyle = FontStyle.normal,
    super.height = 1.4,
  }) : super(package: 'dsfr', fontFamily: 'Marianne', fontSize: fontSize);

  const DsfrTextStyle.displayXl({final Color color = DsfrColors.grey50})
    : this(fontSize: 72, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.displayLg({final Color color = DsfrColors.grey50})
    : this(fontSize: 64, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.displayMd({final Color color = DsfrColors.grey50})
    : this(fontSize: 56, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.displaySm({final Color color = DsfrColors.grey50})
    : this(fontSize: 48, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.displayXs({final Color color = DsfrColors.grey50})
    : this(fontSize: 40, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.headline1({final Color color = DsfrColors.grey50})
    : this(fontSize: 32, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.headline2({final Color color = DsfrColors.grey50})
    : this(fontSize: 28, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.headline3({final Color color = DsfrColors.grey50})
    : this(fontSize: 24, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.headline4({final Color color = DsfrColors.grey50})
    : this(fontSize: 22, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.headline5({final Color color = DsfrColors.grey50})
    : this(fontSize: 20, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.headline6({final Color color = DsfrColors.grey50})
    : this(fontSize: 18, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.bodyXl({final Color color = DsfrColors.grey50}) : this(fontSize: 20, color: color);

  const DsfrTextStyle.bodyXlMedium({final Color color = DsfrColors.grey50})
    : this(fontSize: 20, fontWeight: FontWeight.w500, color: color);

  const DsfrTextStyle.bodyXlBold({final Color color = DsfrColors.grey50})
    : this(fontSize: 20, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.bodyLg({final Color color = DsfrColors.grey50}) : this(fontSize: 18, color: color);

  const DsfrTextStyle.bodyLgMedium({final Color color = DsfrColors.grey50})
    : this(fontSize: 18, fontWeight: FontWeight.w500, color: color);

  const DsfrTextStyle.bodyLgBold({final Color color = DsfrColors.grey50})
    : this(fontSize: 18, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.bodyMd({final Color color = DsfrColors.grey50}) : this(fontSize: 16, color: color);

  const DsfrTextStyle.bodyMdMedium({final Color color = DsfrColors.grey50})
    : this(fontSize: 16, fontWeight: FontWeight.w500, color: color);

  const DsfrTextStyle.bodyMdBold({final Color color = DsfrColors.grey50})
    : this(fontSize: 16, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.bodySm({final Color color = DsfrColors.grey50}) : this(fontSize: 14, color: color);

  const DsfrTextStyle.bodySmItalic({final Color color = DsfrColors.grey50})
    : this(fontSize: 14, color: color, fontStyle: FontStyle.italic);

  const DsfrTextStyle.bodySmMedium({final Color color = DsfrColors.grey50})
    : this(fontSize: 14, fontWeight: FontWeight.w500, color: color);

  const DsfrTextStyle.bodySmBold({final Color color = DsfrColors.grey50})
    : this(fontSize: 14, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.bodyXs({final Color color = DsfrColors.grey50}) : this(fontSize: 12, color: color);

  const DsfrTextStyle.bodyXsMedium({final Color color = DsfrColors.grey50})
    : this(fontSize: 12, fontWeight: FontWeight.w500, color: color);

  const DsfrTextStyle.bodyXsBold({final Color color = DsfrColors.grey50})
    : this(fontSize: 12, fontWeight: FontWeight.bold, color: color);

  const DsfrTextStyle.fontFamily() : super(package: 'dsfr', fontFamily: 'Marianne');
}
