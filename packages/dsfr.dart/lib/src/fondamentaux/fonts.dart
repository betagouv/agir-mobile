import 'package:flutter/rendering.dart';

class DsfrTextStyle extends TextStyle {
  const DsfrTextStyle({
    required final double fontSize,
    super.fontWeight = FontWeight.normal,
  }) : super(
          package: 'dsfr',
          fontFamily: 'Marianne',
          fontSize: fontSize,
        );

  const DsfrTextStyle.fontFamily()
      : super(
          package: 'dsfr',
          fontFamily: 'Marianne',
        );
}

class DsfrFonts {
  const DsfrFonts._();

  static const displayXl =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 72);

  static const displayLg =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 64);

  static const displayMd =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 56);

  static const displaySm =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 48);

  static const displayXs =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 40);

  static const headline1 =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 32);

  static const headline2 =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 28);

  static const headline3 =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 24);

  static const headline4 =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 22);

  static const headline5 =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  static const headline6 =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 18);

  static const bodyXl = DsfrTextStyle(fontSize: 20);

  static const bodyXlMedium =
      DsfrTextStyle(fontWeight: FontWeight.w500, fontSize: 20);

  static const bodyLg = DsfrTextStyle(fontSize: 18);

  static const bodyLgMedium =
      DsfrTextStyle(fontWeight: FontWeight.w500, fontSize: 18);

  static const bodyMd = DsfrTextStyle(fontSize: 16);

  static const bodyMdMedium =
      DsfrTextStyle(fontWeight: FontWeight.w500, fontSize: 16);

  static const bodyMdBold =
      DsfrTextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  static const bodySm = DsfrTextStyle(fontSize: 14);

  static const bodySmMedium =
      DsfrTextStyle(fontWeight: FontWeight.w500, fontSize: 14);

  static const bodyXs = DsfrTextStyle(fontSize: 12);
}
