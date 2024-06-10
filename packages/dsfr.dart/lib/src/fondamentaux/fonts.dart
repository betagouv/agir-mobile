// ignore_for_file: unused-code

import 'package:flutter/rendering.dart';

class DsfrTextStyle extends TextStyle {
  const DsfrTextStyle({
    required final double fontSize,
    super.fontWeight = FontWeight.normal,
  }) : super(package: 'dsfr', fontFamily: 'Marianne', fontSize: fontSize);

  const DsfrTextStyle.fontFamily()
      : super(package: 'dsfr', fontFamily: 'Marianne');
}

abstract final class DsfrFonts {
  const DsfrFonts._();

  static const displayXl =
      DsfrTextStyle(fontSize: 72, fontWeight: FontWeight.bold);

  static const displayLg =
      DsfrTextStyle(fontSize: 64, fontWeight: FontWeight.bold);

  static const displayMd =
      DsfrTextStyle(fontSize: 56, fontWeight: FontWeight.bold);

  static const displaySm =
      DsfrTextStyle(fontSize: 48, fontWeight: FontWeight.bold);

  static const displayXs =
      DsfrTextStyle(fontSize: 40, fontWeight: FontWeight.bold);

  static const headline1 =
      DsfrTextStyle(fontSize: 32, fontWeight: FontWeight.bold);

  static const headline2 =
      DsfrTextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  static const headline3 =
      DsfrTextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const headline4 =
      DsfrTextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  static const headline5 =
      DsfrTextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const headline6 =
      DsfrTextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const bodyXl = DsfrTextStyle(fontSize: 20);

  static const bodyXlMedium =
      DsfrTextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  static const bodyLg = DsfrTextStyle(fontSize: 18);

  static const bodyLgMedium =
      DsfrTextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  static const bodyMd = DsfrTextStyle(fontSize: 16);

  static const bodyMdMedium =
      DsfrTextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const bodyMdBold =
      DsfrTextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  static const bodySm = DsfrTextStyle(fontSize: 14);

  static const bodySmMedium =
      DsfrTextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static const bodySmBold =
      DsfrTextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  static const bodyXs = DsfrTextStyle(fontSize: 12);
}
