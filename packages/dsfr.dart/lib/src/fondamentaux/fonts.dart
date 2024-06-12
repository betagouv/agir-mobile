// ignore_for_file: unused-code

import 'package:flutter/rendering.dart';

class DsfrTextStyle extends TextStyle {
  const DsfrTextStyle({
    required final double fontSize,
    required final double lineHeight,
    super.fontWeight = FontWeight.normal,
  }) : super(
          package: 'dsfr',
          fontFamily: 'Marianne',
          fontSize: fontSize,
          height: lineHeight / fontSize,
        );

  const DsfrTextStyle.fontFamily()
      : super(package: 'dsfr', fontFamily: 'Marianne');
}

abstract final class DsfrFonts {
  const DsfrFonts._();

  static const displayXl =
      DsfrTextStyle(fontSize: 72, lineHeight: 72, fontWeight: FontWeight.bold);

  static const displayLg =
      DsfrTextStyle(fontSize: 64, lineHeight: 64, fontWeight: FontWeight.bold);

  static const displayMd =
      DsfrTextStyle(fontSize: 56, lineHeight: 56, fontWeight: FontWeight.bold);

  static const displaySm =
      DsfrTextStyle(fontSize: 48, lineHeight: 48, fontWeight: FontWeight.bold);

  static const displayXs =
      DsfrTextStyle(fontSize: 40, lineHeight: 40, fontWeight: FontWeight.bold);

  static const headline1 =
      DsfrTextStyle(fontSize: 32, lineHeight: 32, fontWeight: FontWeight.bold);

  static const headline2 =
      DsfrTextStyle(fontSize: 28, lineHeight: 34, fontWeight: FontWeight.bold);

  static const headline3 =
      DsfrTextStyle(fontSize: 24, lineHeight: 24, fontWeight: FontWeight.bold);

  static const headline4 =
      DsfrTextStyle(fontSize: 22, lineHeight: 22, fontWeight: FontWeight.bold);

  static const headline5 =
      DsfrTextStyle(fontSize: 20, lineHeight: 20, fontWeight: FontWeight.bold);

  static const headline6 =
      DsfrTextStyle(fontSize: 18, lineHeight: 20, fontWeight: FontWeight.bold);

  static const bodyXl = DsfrTextStyle(fontSize: 20, lineHeight: 20);

  static const bodyXlMedium =
      DsfrTextStyle(fontSize: 20, lineHeight: 20, fontWeight: FontWeight.w500);

  static const bodyLg = DsfrTextStyle(fontSize: 18, lineHeight: 18);

  static const bodyLgMedium =
      DsfrTextStyle(fontSize: 18, lineHeight: 28, fontWeight: FontWeight.w500);

  static const bodyMd = DsfrTextStyle(fontSize: 16, lineHeight: 24);

  static const bodyMdMedium =
      DsfrTextStyle(fontSize: 16, lineHeight: 20, fontWeight: FontWeight.w500);

  static const bodyMdBold =
      DsfrTextStyle(fontSize: 16, lineHeight: 20, fontWeight: FontWeight.bold);

  static const bodySm = DsfrTextStyle(fontSize: 14, lineHeight: 20);

  static const bodySmMedium =
      DsfrTextStyle(fontSize: 14, lineHeight: 24, fontWeight: FontWeight.w500);

  static const bodySmBold =
      DsfrTextStyle(fontSize: 14, lineHeight: 24, fontWeight: FontWeight.bold);

  static const bodyXs = DsfrTextStyle(fontSize: 12, lineHeight: 20);

  static const bodyXsBold =
      DsfrTextStyle(fontSize: 12, lineHeight: 20, fontWeight: FontWeight.bold);
}
